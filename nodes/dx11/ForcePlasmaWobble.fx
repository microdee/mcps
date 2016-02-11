
#include "../../../mp.fxh/mcpsWrite.fxh"
#include "../../../mp.fxh/CSThreadDefines.fxh"
#include "../../../mp.fxh/plasmanoise.fxh"
#if defined(KNOW_ROTATION)
#include "../../../mp.fxh/quaternion.fxh"
#endif

RWByteAddressBuffer Outbuf : BACKBUFFER;

cbuffer cbuf
{
    float4x4 FieldTr : WORLD;
    float Distort = 0;
    float Saturation = 0;
    float Rotation = 0;
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

	uint ii=input.DTID.x;

    float3 pos = mcpsPositionLoad(Outbuf, ii);

	float3 force = distort(pos, FieldTr, Saturation, Freqs, Amps);

    float3 absforce = mcpsForceLoad(Outbuf, ii) + force * Distort;
    mcpsForceStore(Outbuf, ii, absforce);

    #if defined(KNOW_ROTATION)
        float4 rotate = normalize(aa2q(normalize(force), Rotation));
        float4 orot = mcpsRotationLoad(Outbuf, ii);
    	float4 rot = qmul(orot,rotate);
        mcpsRotationStore(Outbuf, ii, rot);
    #endif
}
technique11 csmain { pass P0{SetComputeShader( CompileShader( cs_5_0, CSMain() ) );} }
