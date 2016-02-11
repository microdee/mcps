
#include "mcps.fxh"
#include "DistanceFieldHelper.fxh"
#include "DistanceFieldPrimitiveSelector.fxh"

RWStructuredBuffer<float> Outbuf : BACKBUFFER;
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
int DistanceAddress = 17;
float SurfaceNormalCalcWidth = 0.1;
float IsoSurface = 0;
float Strength = 1;
float Power = 1;

uint mcps_distance(uint i) {return i*pelsize+DistanceAddress;}

float dfiter(float initd, float3 p, uint3 i)
{
	float pd = initd;
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
class cDF : DFInterface
{
	float df(float initd, float3 p, uint4 i)
	{
		
		float cd = initd;
		uint maxc = i.x;
		if(maxc > 0)
		{
			uint tc = i.y;
			float3 pp = 0;
			
			for(uint j=0; j<maxc; j++)
			{
				pp = mul(float4(p,1),InvTransform[j%tc]).xyz;
				cd = dfiter(cd, pp, uint3(j, i.z, i.w));
			}
		}
		return cd;
	}
};
cDF iDF;
DFInterface DF = iDF;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(64, 1, 1)]
void CS_mcps64(csin input)
{
	if(input.DTID.x > pcount) return;

	uint pc, oc, tc, str;
	Prop.GetDimensions(pc,str);
	InvTransform.GetDimensions(tc,str);
	OperationMass.GetDimensions(oc,str);
	pc /= iprim.PropSize();
	uint maxc = max(pc,max(oc,tc));
	
	uint ii=input.DTID.x;
	
	float3 pos = 0;
	uint3 pi = mcps_position(ii);
	[unroll]
	for(uint i=0; i<3; i++)
		pos[i] = Outbuf[pi[i]];
	
	uint di = mcps_distance(ii);
	float initd = Outbuf[di];
	
	float3 dir = CalcNorm(initd, pos, uint4(maxc, tc, pc, oc), SurfaceNormalCalcWidth, DF);
	float ad = DF.df(initd, pos, uint4(maxc, tc, pc, oc));
	Outbuf[di] = ad;
	
	float r = IsoSurface;
	float s = Strength;
	float p = (Power == 0) ? 1 : Power;
	if(ad < r)
	{
		float attr = pows(ad/IsoSurface, p) * -s;
		float3 force = dir*attr;
		
		uint3 fi = mcps_force(ii);
		
		[unroll]
		for(uint i=0; i<3; i++) Outbuf[fi[i]] += force[i];
	}
}
technique11 mcps64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mcps64() ) );} }