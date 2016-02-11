
#include "../../../mp.fxh/mcpsWrite.fxh"
#include "../../../mp.fxh/CSThreadDefines.fxh"

RWByteAddressBuffer Outbuf : BACKBUFFER;
StructuredBuffer<float2> SourceMinMax;
StructuredBuffer<float2> WidthPhase;
StructuredBuffer<uint> Destination;

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
	uint id=input.DTID.y;
    float age = mcpsAgeLoad(Outbuf, ii);

	uint WPc, Sc, Str;
	WidthPhase.GetDimensions(WPc, Str);
	SourceMax.GetDimensions(Sc, Str);

	float sw = age*WidthPhase[id%WPc].x+WidthPhase[id%WPc].y;
	float ss = sin(sw)*.5+.5;

    float result = lerp(SourceMin[id%SIc],SourceMax[id%Sc],ss);
    mcpsStore(Outbuf, ii, Destination[id], result);
}
technique11 csmain { pass P0{SetComputeShader( CompileShader( cs_5_0, CSMain() ) );} }
