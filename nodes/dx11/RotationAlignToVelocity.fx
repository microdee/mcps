
#include "../../../mp.fxh/quaternion.fxh"
#include "../../../mp.fxh/mupsWrite.fxh"
#include "../../../mp.fxh/CSThreadDefines.fxh"

RWByteAddressBuffer Outbuf : BACKBUFFER;
cbuffer cbuf
{
	float3 Forward = float3(0,0,1);
	float Influence = 1;
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
#if defined(KNOW_ROTATION)
	if(input.DTID.x > PCOUNT) return;
	uint ii = input.DTID.x;
	float3 vel = mupsVelocityLoad(Outbuf, ii).xyz;
	if(length(vel) > 0.001)
	{
		float4 orot = mupsRotationLoad(Outbuf, ii);
		float4 rot = qLookAt(vel, Forward);
		mupsRotationStore(Outbuf, ii, slerp(orot, rot, Influence));
	}
#endif
}
technique11 csmain { pass P0{SetComputeShader( CompileShader( cs_5_0, CSMain() ) );} }