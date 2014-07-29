#include "mups.fxh"

RWStructuredBuffer<float> Outbuf : BACKBUFFER;
StructuredBuffer<float> Source;
StructuredBuffer<uint> Destination;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

void main(csin input)
{
	uint ii=input.DTID.x;
	uint id=input.DTID.y;
	
	Outbuf[ii*pelsize+Destination[id]] = Source[id];
}

[numthreads(64, 1, 1)]
void CS_Clear64(csin input)
{
	if(input.DTID.x > pcount) return;
	uint ii=input.DTID.x;
	uint id=input.DTID.y;
	
	Outbuf[ii*pelsize+Destination[id]] = Source[id];
}
technique11 Clear64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear64() ) );} }