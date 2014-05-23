RWStructuredBuffer<float> Outbuf : BACKBUFFER;
#include "mups.fxh"
StructuredBuffer<float4> ColorFrom;
StructuredBuffer<float4> ColorTo;
StructuredBuffer<float2> SizeFromTo;
StructuredBuffer<float2> AgeFromTo;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(1, 1, 1)]
void CS_Full(csin input)
{
	uint ColFC, ColTC, SizFC, AgeFC, Str;
	ColorFrom.GetDimensions(ColFC, Str);
	ColorTo.GetDimensions(ColTC, Str);
	SizeFromTo.GetDimensions(SizFC, Str);
	AgeFromTo.GetDimensions(AgeFC, Str);
	
	uint ii=input.DTID.x;
	uint2 ai = mups_age(ii);
	float fader = saturate((Outbuf[ai.y]-AgeFromTo[ii%AgeFC].x)/(AgeFromTo[ii%AgeFC].y-AgeFromTo[ii%AgeFC].x));
	if((ColFC>0) && (ColTC>0))
	{
		uint4 ci = mups_color(ii);
		for(uint i=0; i<4; i++)
			Outbuf[ci[i]] = smoothstep(ColorFrom[ii%ColFC][i],ColorTo[ii%ColTC][i],fader);
	}
	if(SizFC>0)
		Outbuf[mups_size(ii)] = smoothstep(SizeFromTo[ii%SizFC].x,SizeFromTo[ii%SizFC].y,fader);
}
technique11 FadeFromTo { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Full() ) );} }

[numthreads(1, 1, 1)]
void CS_To(csin input)
{
	uint ColTC, SizFC, AgeFC, Str;
	ColorTo.GetDimensions(ColTC, Str);
	SizeFromTo.GetDimensions(SizFC, Str);
	AgeFromTo.GetDimensions(AgeFC, Str);
	
	uint ii=input.DTID.x;
	uint2 ai = mups_age(ii);
	float fader = 1/AgeFromTo[ii%AgeFC].y;
	fader *= Time.y;
	if(ColTC>0)
	{
		uint4 ci = mups_color(ii);
		for(uint i=0; i<4; i++)
			Outbuf[ci[i]] = lerp(Outbuf[ci[i]],ColorTo[ii%ColTC][i],fader);
	}
	if(SizFC>0)
		Outbuf[mups_size(ii)] = lerp(Outbuf[mups_size(ii)],SizeFromTo[ii%SizFC].y,fader);
}
technique11 FadeTo { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_To() ) );} }