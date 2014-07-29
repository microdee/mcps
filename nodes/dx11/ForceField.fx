RWStructuredBuffer<float> Outbuf : BACKBUFFER;
#include "mups.fxh"

Texture3D Field;
float influance;
float4x4 InvTransformField;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

SamplerState s0 <bool visible=false;string uiname="Sampler";>
{
	Filter=MIN_MAG_MIP_LINEAR;
	AddressU=BORDER;
	AddressV=BORDER;
	AddressW=BORDER;
	BorderColor = float4(0,0,0,0);
};

[numthreads(64, 1, 1)]
void CS_mups64(csin input)
{
	if(input.DTID.x > pcount) return;
	
	uint ii=input.DTID.x;
	
	float3 pos = 0;
	uint3 pi = mups_position(ii);
	
	[unroll]
	for(uint i=0; i<3; i++)
		pos[i] = Outbuf[pi[i]];
	float3 mpos = mul(float4(pos,1),InvTransformField).xyz;
	mpos += 0.5;
	float3 dir = Field.SampleLevel(s0, mpos, 0).xyz * influance;
	
	uint3 fi = mups_force(ii);
	[unroll]
	for(uint i=0; i<3; i++) Outbuf[fi[i]] += dir[i];
}
technique11 mups64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups64() ) );} }