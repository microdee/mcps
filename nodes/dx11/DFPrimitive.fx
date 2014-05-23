#include "DistanceFieldHelper.fxh"

RWTexture3D<float> RWDistanceVolume : BACKBUFFER;
StructuredBuffer<float> Prop;
/*
	sphere 1+1
	cylinder 3+1
	plane 4
	box 3
	torus 2+2
	cone 2+1
	capsule 7+1
*/
StructuredBuffer<float4> OperationMass;
// Operation A
// Operation B
/*
	0 := replace
	1 := union
	2 := difference
	3 := intersect
	4 := smooth union
	5 := smooth difference
	6 := smooth intersect
	7 := bypass
*/
// blend A -> B
// Mass
StructuredBuffer<float4x4> InvTransform;

float3 InvVolumeSize : INVTARGETSIZE;
float3 VolumeSize : TARGETSIZE;
float4x4 tW : WORLDINVERSE;
float4x4 tV : VIEWINVERSE;

interface iPrimitive{
	float Primitive(float3 p, uint i);
	uint PropSize();
};
class iSphere : iPrimitive{
	uint PropSize(){return 1;}
	float Primitive(float3 p, uint i)
	{
		uint ii = i*this.PropSize();
		return sphere(p,Prop[ii+0]);
	}
};
class iSphereN : iPrimitive{
	uint PropSize(){return 2;}
	float Primitive(float3 p, uint i)
	{
		uint ii = i*this.PropSize();
		return sphere(p,Prop[ii+0],Prop[ii+1]);
	}
};
class iCylinder : iPrimitive{
	uint PropSize(){return 3;}
	float Primitive(float3 p, uint i)
	{
		uint ii = i*this.PropSize();
		float3 cc;
		cc.x = Prop[ii+0];
		cc.y = Prop[ii+1];
		cc.z = Prop[ii+2];
		return cylinder(p,cc);
	}
};
class iCylinderN : iPrimitive{
	uint PropSize(){return 4;}
	float Primitive(float3 p, uint i)
	{
		uint ii = i*this.PropSize();
		float3 cc;
		cc.x = Prop[ii+0];
		cc.y = Prop[ii+1];
		cc.z = Prop[ii+2];
		return cylinder(p,cc,Prop[ii+3]);
	}
};
class iPlane : iPrimitive{
	uint PropSize(){return 4;}
	float Primitive(float3 p, uint i)
	{
		uint ii = i*this.PropSize();
		float4 cc;
		cc.x = Prop[ii+0];
		cc.y = Prop[ii+1];
		cc.z = Prop[ii+2];
		cc.w = Prop[ii+3];
		return plane(p,cc);
	}
};
class iBox : iPrimitive{
	uint PropSize(){return 3;}
	float Primitive(float3 p, uint i)
	{
		uint ii = i*this.PropSize();
		float3 cc;
		cc.x = Prop[ii+0];
		cc.y = Prop[ii+1];
		cc.z = Prop[ii+2];
		return box(p,cc);
	}
};
class iTorus : iPrimitive{
	uint PropSize(){return 2;}
	float Primitive(float3 p, uint i)
	{
		uint ii = i*this.PropSize();
		float2 cc;
		cc.x = Prop[ii+0];
		cc.y = Prop[ii+1];
		return torus(p,cc);
	}
};
class iTorusN : iPrimitive{
	uint PropSize(){return 4;}
	float Primitive(float3 p, uint i)
	{
		uint ii = i*this.PropSize();
		float2 cc;
		cc.x = Prop[ii+0];
		cc.y = Prop[ii+1];
		float2 nn;
		nn.x = Prop[ii+2];
		nn.y = Prop[ii+3];
		return torus(p,cc,nn);
	}
};
class iCone : iPrimitive{
	uint PropSize(){return 2;}
	float Primitive(float3 p, uint i)
	{
		uint ii = i*this.PropSize();
		float2 cc;
		cc.x = Prop[ii+0];
		cc.y = Prop[ii+1];
		return cone(p,cc);
	}
};
class iConeN : iPrimitive{
	uint PropSize(){return 3;}
	float Primitive(float3 p, uint i)
	{
		uint ii = i*this.PropSize();
		float2 cc;
		cc.x = Prop[ii+0];
		cc.y = Prop[ii+1];
		return cone(p,cc,Prop[ii+2]);
	}
};
class iCapsule : iPrimitive{
	uint PropSize(){return 7;}
	float Primitive(float3 p, uint i)
	{
		uint ii = i*this.PropSize();
		float3 aa;
		aa.x = Prop[ii+0];
		aa.y = Prop[ii+1];
		aa.z = Prop[ii+2];
		float3 bb;
		bb.x = Prop[ii+3];
		bb.y = Prop[ii+4];
		bb.z = Prop[ii+5];
		return capsule(p,aa,bb,Prop[ii+6]);
	}
};
class iCapsuleN : iPrimitive{
	uint PropSize(){return 8;}
	float Primitive(float3 p, uint i)
	{
		uint ii = i*this.PropSize();
		float3 aa;
		aa.x = Prop[ii+0];
		aa.y = Prop[ii+1];
		aa.z = Prop[ii+2];
		float3 bb;
		bb.x = Prop[ii+3];
		bb.y = Prop[ii+4];
		bb.z = Prop[ii+5];
		return capsule(p,aa,bb,Prop[ii+6],Prop[ii+7]);
	}
};
iSphere Sphere;
iSphereN SphereN;
iCylinder Cylinder;
iCylinderN CylinderN;
iPlane Plane;
iBox Box;
iTorus Torus;
iTorusN TorusN;
iCone Cone;
iConeN ConeN;
iCapsule Capsule;
iCapsuleN CapsuleN;

iPrimitive iprim <string uiname="Primitive";string linkclass="Sphere,SphereN,Cylinder,CylinderN,Plane,Box,Torus,TorusN,Cone,ConeN,Capsule,CapsuleN";> = Sphere;
bool Sculpting = 0;
float SculptRadius = 0.125;
float blend(float a, float b, float s, float mass)
{
	float res = b;
	if(floor(s)==1) res = U(a,b);
	if(floor(s)==2) res = S(a,b);
	if(floor(s)==3) res = I(a,b);
	if(floor(s)==4) res = sU(a,b,mass);
	if(floor(s)==5) res = sS(a,b,mass/4);
	if(floor(s)==6) res = sI(a,b,mass/4);
	if(floor(s)==7) res = a;
	return res;
}

float df(uint3 ti, float3 p, uint3 i)
{
	float pd = RWDistanceVolume[ti];
	float rd = iprim.Primitive(p, i.x%i.y);
	float2 ss = OperationMass[i.x%i.z].xy;
	float m = max(OperationMass[i.x%i.z].w,0.0001);
	float da = blend(pd,rd,ss.x,m);
	
	if(floor(ss.x) != floor(ss.y))
	{
		float db = blend(pd,rd,ss.y,m);
		return lerp(da,db,OperationMass[i.x%i.z].z);
	}
	else return da;
}

float SculptAmount(float3 sp, float r)
{
	float sd = 1-saturate((RWDistanceVolume[(uint3)((sp+0.5)*VolumeSize)])/r);
	
	return sd;
}

[numthreads(8, 8, 8)]
void CSf( uint3 ti : SV_DispatchThreadID)
{ 
	float3 p = ti;
	p *= InvVolumeSize;
	p -= 0.5f;
	p = mul(float4(p,1),tW).xyz;
	p = mul(float4(p,1),tV).xyz;
	float3 pp = 0;
	pp = mul(float4(pp,1),tW).xyz;
	pp = mul(float4(pp,1),tV).xyz;
	
	uint pc, oc, tc, str;
	Prop.GetDimensions(pc,str);
	InvTransform.GetDimensions(tc,str);
	OperationMass.GetDimensions(oc,str);
	pc /= iprim.PropSize();
	uint maxc = max(pc,max(oc,tc));
	
	if(maxc>0)
	{
		float dff = df(ti, mul(float4(p,1),InvTransform[0]).xyz, uint3(0,pc,oc));
		//if(!Sculpting) RWDistanceVolume[ti] = dff;
		//else
		//{
			float sca = lerp(1,RWDistanceVolume[(uint3)((-mul(float4(pp,1),InvTransform[0]).xyz+0.5)*VolumeSize)]<SculptRadius,Sculpting);
			RWDistanceVolume[ti] = lerp(RWDistanceVolume[ti], dff, sca);
		//}
		if(maxc>1)
		{
			for(uint i=1; i<maxc; i++)
			{
				dff = df(ti, mul(float4(p,1),InvTransform[i%tc]).xyz, uint3(i,pc,oc));
				//if(!Sculpting) RWDistanceVolume[ti] = dff;
				//else
				//{
					/*float*/ sca = lerp(1,RWDistanceVolume[(uint3)((-mul(float4(pp,1),InvTransform[i%tc]).xyz+0.5)*VolumeSize)]<SculptRadius,Sculpting);
					RWDistanceVolume[ti] = lerp(RWDistanceVolume[ti], dff, sca);
				//}
			}
		}
	}
	//Do a simple distance field
	
}

technique11 Out
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CSf() ) );
	}
}




