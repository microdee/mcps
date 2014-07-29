#include "mups.fxh"

RWStructuredBuffer<float> Outbuf : BACKBUFFER;
StructuredBuffer<float> SourceMin;
StructuredBuffer<float> SourceMax;
StructuredBuffer<float2> WidthPhase;
StructuredBuffer<uint> Destination;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(64, 1, 1)]
void CS_Clear64(csin input)
{
	if(input.DTID.x > pcount) return;

	uint ii=input.DTID.x;
	uint id=input.DTID.y;
	uint2 ai = mups_age(ii);
	
	uint WPc, SAc, SIc, Str;
	WidthPhase.GetDimensions(WPc, Str);
	SourceMax.GetDimensions(SAc, Str);
	SourceMin.GetDimensions(SIc, Str);
	
	float sw = Outbuf[ai.y]*WidthPhase[id%WPc].x+WidthPhase[id%WPc].y;
	float ss = sin(sw)*.5+.5;
	Outbuf[ii*pelsize+Destination[id]] = lerp(SourceMin[id%SIc],SourceMax[id%SAc],ss);
}
technique11 Clear64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear64() ) );} }