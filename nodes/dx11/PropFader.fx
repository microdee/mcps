RWStructuredBuffer<float> Outbuf : BACKBUFFER;
#include "mups.fxh"
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

[numthreads(64, 1, 1)]
void CS_FadeFromTo(csin input)
{
	if(input.DTID.x > pcount) return;

	uint sftC, dstC, AgeFC, Str;
	SourceFromTo.GetDimensions(sftC, Str);
	Destination.GetDimensions(dstC, Str);
	AgeFromTo.GetDimensions(AgeFC, Str);
	
	uint ii=input.DTID.x;
	uint id=input.DTID.y;
	uint2 ai = mups_age(ii);
	float fader = saturate((Outbuf[ai.y]-AgeFromTo[id%AgeFC].x)/(AgeFromTo[id%AgeFC].y-AgeFromTo[id%AgeFC].x));
	
	Outbuf[ii*pelsize + Destination[id%dstC]] = lerp(SourceFromTo[id%sftC].x, SourceFromTo[id%sftC].y, pow(fader,FaderPow));
}
technique11 FadeFromTo { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFromTo() ) );} }