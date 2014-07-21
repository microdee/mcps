#include "DistanceFieldHelper.fxh"
#include "DistanceFieldPrimitiveSelector.fxh"

RWTexture3D<float> RWDistanceVolume : BACKBUFFER;
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
		RWDistanceVolume[ti] = dff;
		
		if(maxc>1)
		{
			for(uint i=1; i<maxc; i++)
			{
				dff = df(ti, mul(float4(p,1),InvTransform[i%tc]).xyz, uint3(i,pc,oc));
				RWDistanceVolume[ti] = dff;
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




