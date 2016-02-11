
#include "../../../mp.fxh/mcpsWrite.fxh"
#include "../../../mp.fxh/CSThreadDefines.fxh"

RWByteAddressBuffer Outbuf : BACKBUFFER;

StructuredBuffer<float2> SourceFromTo;
StructuredBuffer<float2> AgeFromTo;
StructuredBuffer<uint> Destination;
float FaderPow = 1;

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

	uint sftC, dstC, AgeFC, Str;
	SourceFromTo.GetDimensions(sftC, Str);
	Destination.GetDimensions(dstC, Str);
	AgeFromTo.GetDimensions(AgeFC, Str);

	uint ii=input.DTID.x;
	uint id=input.DTID.y;
    float age = mcpsAgeLoad(Outbuf, ii).y;
	float fader = saturate((age-AgeFromTo[id%AgeFC].x)/(AgeFromTo[id%AgeFC].y-AgeFromTo[id%AgeFC].x));
	if((age >= AgeFromTo[id%AgeFC].x) && (age <= AgeFromTo[id%AgeFC].y))
	{
        float result = lerp(SourceFromTo[id%sftC].x, SourceFromTo[id%sftC].y, pow(fader,FaderPow));
        mcpsStore(Outbuf, ii, Destination[id%dstC], result);
	}
}
technique11 csmain { pass P0{SetComputeShader( CompileShader( cs_5_0, CSMain() ) );} }
