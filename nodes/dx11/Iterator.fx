
#include "../../../mp.fxh/mupsWrite.fxh"
#include "../../../mp.fxh/CSThreadDefines.fxh"

RWByteAddressBuffer Outbuf : BACKBUFFER;
cbuffer cbuf
{
    float3 gravity = {0,-9.80665,0};
    float VelocityDamper = 1;
    //float SleepThreshold = 0.5;
    bool AddVelocity = true;
    bool AddForce = true;
    float ResetAllEps = 0.034;
};

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(XTHREADS, YTHREADS, ZTHREADS)]
void CS_Iterate64(csin input)
{
	if(input.DTID.x > PCOUNT) return;

	uint ii=input.DTID.x;

	float2 age = mupsAgeLoad(Outbuf, ii);
	age.x++;
	age.y += mupsTime.y;
	mupsAgeStore(Outbuf, ii, age);
	//bool sleep = Outbuf[mups_sleep(ii)] > SleepThreshold;

	if(AddVelocity)
	{
		float4 vel = mupsVelocityLoad(Outbuf, ii);
		if(AddForce)
		{
			float3 force = mupsForceLoad(Outbuf, ii);
			force += gravity;
			vel.xyz += force;
			vel.xyz *= VelocityDamper;
			vel.xyz *= vel.w;
			mupsVelocityStore(Outbuf, ii, vel);
			mupsForceStore(Outbuf, ii, force);
		}
		else
		{
			vel.xyz *= VelocityDamper;
			vel.xyz *= vel.w;
			mupsVelocityStore(Outbuf, ii, vel);
		}
		float3 pos = mupsPositionLoad(Outbuf, ii);
		pos += vel.xyz * mupsTime.y;
		mupsPositionStore(Outbuf, ii, pos);
	}
	if(mupsTime.x < ResetAllEps)
	{
		for(uint i=0; i<PELSIZE; i++) mupsStore(Outbuf, ii, i, 0);
	}
}
technique11 Iterate64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate64() ) );} }
