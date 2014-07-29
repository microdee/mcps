RWStructuredBuffer<float> Outbuf : BACKBUFFER;
#include "mups.fxh"
StructuredBuffer<float2> AgeFromTo;
StructuredBuffer<float> Source;
StructuredBuffer<uint> Destination;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(64, 1, 1)]
void CS_FadeTo(csin input)
{
	if(input.DTID.x > pcount) return;

	uint sftC, dstC, AgeFC, Str;
	Source.GetDimensions(sftC, Str);
	Destination.GetDimensions(dstC, Str);
	AgeFromTo.GetDimensions(AgeFC, Str);
	
	uint ii=input.DTID.x;
	uint id=input.DTID.y;
	uint2 ai = mups_age(ii);
	float fmul = 1/abs(AgeFromTo[id%AgeFC].y - AgeFromTo[id%AgeFC].x);
	float fader =lerp(0, Time.y * fmul, Outbuf[ai.y] > AgeFromTo[id%AgeFC].x);
	
	Outbuf[ii*pelsize + Destination[id%dstC]] = lerp(Outbuf[ii*pelsize + Destination[id%dstC]], Source[id%sftC], fader);
}
technique11 FadeTo { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo() ) );} }