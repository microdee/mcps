
StructuredBuffer<float> Prop;
/*
	Optional
	(uint Sel)	(Name)		(Size in floats)	
	 0			sphere		1
	 1			sphereN		2
	 2			cylinder	3
	 3			cylinderN	4
	 4			plane		4
	 5			box			3
	 6			torus		2
	 7			torusN		4
	 8			cone		2
	 9			coneN		3
	10			capsule		7
	11			capsuleN	8

	if you want to select primitive type from buffer 

	and 1+ in case of a single call selector (select primitive)
*/

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