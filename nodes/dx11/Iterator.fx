#include "mups.fxh"

RWStructuredBuffer<float> Outbuf : BACKBUFFER;

float3 gravity = {0,-9.80665,0};
float VelocityDamper = 1;
//float SleepThreshold = 0.5;
bool AddVelocity = true;
bool AddForce = true;
float ResetAllEps = 0.034;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(64, 1, 1)]
void CS_Iterate64(csin input)
{
	if(input.DTID.x > pcount) return;
	
	uint ii=input.DTID.x;
	uint2 ai = mups_age(ii);
	Outbuf[ai.x]++;
	Outbuf[ai.y] += Time.y;
	//bool sleep = Outbuf[mups_sleep(ii)] > SleepThreshold;
	
	if(AddVelocity)
	{
		uint4 vi = mups_velocity(ii);
		if(AddForce)
		{
			uint3 fi = mups_force(ii);
			for(uint i=0; i<3; i++)
			{
				Outbuf[fi[i]] += gravity[i];
				
				Outbuf[vi[i]] += Outbuf[fi[i]] * Time.y;
				Outbuf[vi[i]] *= VelocityDamper;
				Outbuf[vi[i]] *= Outbuf[vi.w];
			}
		}
		else
		{
			for(uint i=0; i<3; i++)
			{
				Outbuf[vi[i]] *= VelocityDamper;
				Outbuf[vi[i]] *= Outbuf[vi.w];
			}
		}
		uint3 pi = mups_position(ii);
		for(uint i=0; i<3; i++) Outbuf[pi[i]] += Outbuf[vi[i]] * Time.y;
	}
	if(Time.x < ResetAllEps)
	{
		for(uint i=0; i<pelsize; i++) Outbuf[ii*pelsize+i] = 0;
	}
}
technique11 Iterate64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate64() ) );} }