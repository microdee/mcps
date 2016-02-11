
#include "../../../mp.fxh/mcpsWrite.fxh"
#include "../../../mp.fxh/CSThreadDefines.fxh"

RWByteAddressBuffer Outbuf : BACKBUFFER;

StructuredBuffer<float> Source;
StructuredBuffer<uint> Destination;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(XTHREADS, YTHREADS, ZTHREADS)]
void CS(csin input)
{
	if(input.DTID.x > PCOUNT) return;
	uint ii=input.DTID.x;
	uint id=input.DTID.y;

	mcpsStore(Outbuf, ii, Destination[id], Source[id]);
}
technique11 cst { pass P0{SetComputeShader( CompileShader( cs_5_0, CS() ) );} }
