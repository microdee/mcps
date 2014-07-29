RWStructuredBuffer<float> Outbuf : BACKBUFFER;
#include "mups.fxh"
StructuredBuffer<float4x4> GroundTr;
StructuredBuffer<float4x4> InvGroundTr;
Texture2D DirTex;

SamplerState s0 <bool visible=false;string uiname="Sampler";>
	{Filter=MIN_MAG_MIP_LINEAR;AddressU=WRAP;AddressV=WRAP;};

float Damping = .96;
float DirAm = 0;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

void main(csin input)
{
	if(input.DTID.x > pcount) return;
	
	uint ii = input.DTID.x;
	uint trii = input.DTID.y;
	
	float3 cpos = 0;
	uint3 pi = mups_position(ii);
	for(uint i=0; i<3; i++)
		cpos[i] = Outbuf[pi[i]];
	
	float4 vel = 0;
	uint4 vi = mups_velocity(ii);
	for(uint i=0; i<4; i++)
		vel[i] = Outbuf[vi[i]];
	
	float3 npos = mul(float4(cpos,1),InvGroundTr[trii]).xyz;
	float3 nvel = mul(float4(vel.xyz,0),InvGroundTr[trii]).xyz;
	if(npos.y<0)
	{
		nvel.y *= -Damping;
		float2 uv = mul(float4(cpos,1),GroundTr[trii]).xy;
		nvel.xyz += (DirTex.SampleLevel(s0, uv, 0).rgb-.5) * DirAm * saturate(nvel.y-1);
		nvel = mul(float4(nvel,0),GroundTr[trii]).xyz;
		npos = mul(float4(npos.x,0,npos.z,1),GroundTr[trii]).xyz;
		for(uint i=0; i<3; i++)
			Outbuf[pi[i]] = npos[i];
		for(uint i=0; i<3; i++)
			Outbuf[vi[i]] = nvel[i];
	}
	
}

[numthreads(64, 1, 1)]
void CS_Ground64(csin input) { main(input); }
technique11 Ground64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground64() ) );} }