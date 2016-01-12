
#include "../../../mp.fxh/mupsWrite.fxh"
#include "../../../mp.fxh/CSThreadDefines.fxh"

RWByteAddressBuffer Outbuf : BACKBUFFER;

ByteAddressBuffer mupsData;
StructuredBuffer<uint> Source;
StructuredBuffer<uint> Destination;

cbuffer cbuf
{
    copyvelocity;
    uint ParticleSize = 17;
    uint EmitterID = 0;
    uint emitcount = 100;
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
	/*
	uint PCount, VCount, Str;
	Position.GetDimensions(PCount, Str);
	Velocity.GetDimensions(VCount, Str);
	*/
	uint DstC, Str;
	Destination.GetDimensions(DstC, Str);

    uint ii = input.DTID.x + WorldEmitOffset + EmitOffset[EmitterID];
	uint pii = input.DTID.x;
	uint dii = input.DTID.y;

    mupsAgeStore(Outbuf, ii, 0);

	float fromMups = BABLoad(mupsData, pii*ParticleSize + Source[dii]);
	mupsStore(Outbuf, ii, Destination[dii], fromMups);
}
technique11 csmain { pass P0{SetComputeShader( CompileShader( cs_5_0, CSMain() ) );} }
