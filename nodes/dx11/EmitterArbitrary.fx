
#include "../../../mp.fxh/mcpsWrite.fxh"
#include "../../../mp.fxh/CSThreadDefines.fxh"

RWByteAddressBuffer Outbuf : BACKBUFFER;

StructuredBuffer<float> Source;
StructuredBuffer<uint> Destination;

cbuffer cbuf
{
    uint emitcount = 100;
    uint EmitterID = 0;
}

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(XTHREADS, YTHREADS, ZTHREADS)]
void CSMain(csin input)
{
	if(input.DTID.x > emitcount) return;

	uint DstC, Str;
	Destination.GetDimensions(DstC, Str);

	uint ii = input.DTID.x + WorldEmitOffset + EmitOffset[EmitterID];
	uint pii = input.DTID.x;
	uint dii = input.DTID.y;
    mcpsAgeStore(Outbuf, ii, 0);

	uint sii = pii*DstC+dii;
    mcpsStore(Outbuf, ii, Destination[dii], Source[sii]);
}
technique11 csmain { pass P0{SetComputeShader( CompileShader( cs_5_0, CSMain() ) );} }
