RWStructuredBuffer<float> Outbuf : BACKBUFFER;
#include "mups.fxh"
StructuredBuffer<float3> Position;
StructuredBuffer<float3> Velocity;
float VelInfluence = 0;
StructuredBuffer<float3> RadiusStrengthPow;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(64, 1, 1)]
void CS_mups64(csin input)
{
	if(input.DTID.x > pcount) return;
	
	uint rspc, Str;
	RadiusStrengthPow.GetDimensions(rspc, Str);
	
	uint ii=input.DTID.x;
	uint aii=input.DTID.y;
	
	float3 pos = 0;
	uint3 pi = mups_position(ii);
	[unroll]
	for(uint i=0; i<3; i++)
		pos[i] = Outbuf[pi[i]];
	
	float3 avel = Velocity[aii];
	
	float3 dir = Position[aii]-pos;
	float ad = length(dir);
	dir = normalize(dir);
	float r = RadiusStrengthPow[aii%rspc].x;
	float s = RadiusStrengthPow[aii%rspc].y;
	float p = (RadiusStrengthPow[aii%rspc].z == 0) ? 1 : RadiusStrengthPow[aii%rspc].z;
	if(ad < r)
	{
		float attr = max(r - ad, 0);
		attr = pow(attr, p);
		float3 cvel = avel*VelInfluence*attr;
		attr *= s;
		float3 force = dir*attr;
		force += cvel;
		
		uint3 fi = mups_force(ii);
		
		[unroll]
		for(uint i=0; i<3; i++) Outbuf[fi[i]] += force[i];
	}
}
technique11 mups64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups64() ) );} }