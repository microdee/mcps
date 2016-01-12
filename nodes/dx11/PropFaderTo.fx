
#include "../../../mp.fxh/mupsWrite.fxh"
#include "../../../mp.fxh/CSThreadDefines.fxh"

RWByteAddressBuffer Outbuf : BACKBUFFER;
StructuredBuffer<float2> AgeFromTo;
StructuredBuffer<float> Source;
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

	uint sftC, dstC, AgeFC, Str;
	Source.GetDimensions(sftC, Str);
	Destination.GetDimensions(dstC, Str);
	AgeFromTo.GetDimensions(AgeFC, Str);

	uint ii=input.DTID.x;
	uint id=input.DTID.y;

    float age = mupsAgeLoad(Outbuf, ii);
	float fmul = 1/abs(AgeFromTo[id%AgeFC].y - AgeFromTo[id%AgeFC].x);
	float fader =lerp(0, mupsTime.y * fmul, age > AgeFromTo[id%AgeFC].x);
	if((age > AgeFromTo[id%AgeFC].x) && (age < AgeFromTo[id%AgeFC].y))
	{
        float orig = mupsLoad(Outbuf, ii, Destination[id%dstC]);
        float result = lerp(orig, Source[id%sftC], fader);
        mupsStore(Outbuf, ii, Destination[id%dstC], result);
    }
}
technique11 csmain { pass P0{SetComputeShader( CompileShader( cs_5_0, CSMain() ) );} }
