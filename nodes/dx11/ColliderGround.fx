
#include "../../../mp.fxh/mupsWrite.fxh"
#include "../../../mp.fxh/CSThreadDefines.fxh"

RWByteAddressBuffer Outbuf : BACKBUFFER;
StructuredBuffer<float4x4> GroundTr;
StructuredBuffer<float4x4> InvGroundTr;
Texture2D DirTex;

SamplerState s0 <bool visible=false;string uiname="Sampler";>
	{Filter=MIN_MAG_MIP_LINEAR;AddressU=WRAP;AddressV=WRAP;};

cbuffer cbuf
{
    float Damping = .96;
    float DirAm = 0;
};

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(XTHREADS, YTHREADS, ZTHREADS)]
void CSMain(csin input)
{
	if(input.DTID.x > PCOUNT) return;

	uint ii = input.DTID.x;
	uint trii = input.DTID.y;

	float3 cpos = mupsPositionLoad(Outbuf, ii);

	float4 vel = mupsVelocityLoad(Outbuf, ii);

	float3 npos = mul(float4(cpos,1),InvGroundTr[trii]).xyz;
	float3 nvel = mul(float4(vel.xyz,0),InvGroundTr[trii]).xyz;
	if(npos.y<0)
	{
		nvel.y *= -Damping;
		float2 uv = mul(float4(cpos,1),GroundTr[trii]).xy;
		nvel.xyz += (DirTex.SampleLevel(s0, uv, 0).rgb-.5) * DirAm * saturate(nvel.y-1);
		nvel = mul(float4(nvel,0),GroundTr[trii]).xyz;
		npos = mul(float4(npos.x,0,npos.z,1),GroundTr[trii]).xyz;
        mupsPositionStore(Outbuf, ii, npos);
        mupsVelocityStore(Outbuf, ii, nvel);
	}

}

technique11 csmain { pass P0{SetComputeShader( CompileShader( cs_5_0, CSMain() ) );} }
