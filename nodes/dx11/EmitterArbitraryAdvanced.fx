RWStructuredBuffer<float> Outbuf : BACKBUFFER;
#include "mups.fxh"
StructuredBuffer<float> Data;
StructuredBuffer<float3> BinSizeOffset;
// x: binsize; y: offset in source; z: offset in destination
float ElementSize = 7;

float NewCount = 3000;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(1, 1, 1)]
void CS_Em(csin input)
{
	uint ii=input.DTID.x + floor(Outbuf[mups_getemitoffs()]);
	uint dii=input.DTID.x;
	uint3 bii=BinSizeOffset[input.DTID.y];
	if(input.DTID.y == 0)
	{
		uint2 ai = mups_age(ii);
		Outbuf[ai.x] = 0;
		Outbuf[ai.y] = 0;
	}
	
	for(uint i=0; i<bii.x; i++) Outbuf[ii*pelsize+bii.z+i] = Data[dii*ElementSize+bii.y+i];
	
	mups_setemitoffs(Outbuf, NewCount);
}
technique11 Emit { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Em() ) );} }