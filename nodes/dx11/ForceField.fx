
#include "../../../mp.fxh/mupsWrite.fxh"
#include "../../../mp.fxh/CSThreadDefines.fxh"
#if defined(KNOW_ROTATION)
#include "../../../mp.fxh/quaternion.fxh"
#endif

RWByteAddressBuffer Outbuf : BACKBUFFER;

Texture3D Field;
cbuffer cbuf
{
    float4x4 InvTransformField;
    float influance;
    float Rotation = 0;
};

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

SamplerState s0 <string uiname="Sampler";>
{
	Filter=MIN_MAG_MIP_LINEAR;
	AddressU=BORDER;
	AddressV=BORDER;
	AddressW=BORDER;
	BorderColor = float4(0,0,0,0);
};

[numthreads(XTHREADS, YTHREADS, ZTHREADS)]
void CSMain(csin input)
{
	if(input.DTID.x > PCOUNT) return;

	uint ii=input.DTID.x;

	float3 pos = mupsPositionLoad(Outbuf, ii);

	float3 mpos = mul(float4(pos,1),InvTransformField).xyz;
	mpos += 0.5;
	float3 dir = Field.SampleLevel(s0, mpos, 0).xyz;

    absforce = mupsForceLoad(Outbuf, ii) + dir * influance;
    mupsForceStore(Outbuf, ii, absforce);

    #if defined(KNOW_ROTATION)
        float4 rotate = normalize(aa2q(normalize(dir), Rotation));
        float4 orot = mupsRotationLoad(Outbuf, ii);
    	float4 rot = qmul(orot,rotate);
        mupsRotationStore(Outbuf, ii, rot);
    #endif
}
technique11 csmain { pass P0{SetComputeShader( CompileShader( cs_5_0, CSMain() ) );} }
