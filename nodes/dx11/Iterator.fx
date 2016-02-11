
#include "../../../mp.fxh/mcpsWrite.fxh"
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

	float2 age = mcpsAgeLoad(Outbuf, ii);
	age.x++;
	age.y += mcpsTime.y;
	mcpsAgeStore(Outbuf, ii, age);
	//bool sleep = Outbuf[mcps_sleep(ii)] > SleepThreshold;

	if(AddVelocity)
	{
		float4 vel = mcpsVelocityLoad(Outbuf, ii);
		if(AddForce)
		{
			float3 force = mcpsForceLoad(Outbuf, ii);
			force += gravity;
			vel.xyz += force;
			vel.xyz *= VelocityDamper;
			vel.xyz *= vel.w;
			mcpsVelocityStore(Outbuf, ii, vel);
			mcpsForceStore(Outbuf, ii, force);
		}
		else
		{
			vel.xyz *= VelocityDamper;
			vel.xyz *= vel.w;
			mcpsVelocityStore(Outbuf, ii, vel);
		}
		float3 pos = mcpsPositionLoad(Outbuf, ii);
		pos += vel.xyz * mcpsTime.y;
		mcpsPositionStore(Outbuf, ii, pos);
	}
	if(mcpsTime.x < ResetAllEps)
	{
		for(uint i=0; i<PELSIZE; i++) mcpsStore(Outbuf, ii, i, 0);
	}
}
technique11 Iterate64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate64() ) );} }
