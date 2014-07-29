RWStructuredBuffer<float> Outbuf : BACKBUFFER;
#include "mups.fxh"
StructuredBuffer<float> Source;
StructuredBuffer<uint> Destination;
bool ResetColor = false;
float4 Color <bool color=true;> = 1;
bool ResetVelocity = false;
float4 Velocity = {0,0,0,1};
bool ResetSize = false;
float Size = 1;
int EmitterID = 0;
float emitcount = 100;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(64, 1, 1)]
void CS_Emit64(csin input)
{
	if(input.DTID.x > emitcount) return;
	/*
	uint PCount, VCount, Str;
	Position.GetDimensions(PCount, Str);
	Velocity.GetDimensions(VCount, Str);
	*/
	uint DstC, Str;
	Destination.GetDimensions(DstC, Str);
	
	uint ii = input.DTID.x + EmitCounter + EmitCountOffs[EmitterID];
	uint pii = input.DTID.x;
	uint dii = input.DTID.y;
	uint2 ai = mups_age(ii);
	Outbuf[ai.x] = 0;
	Outbuf[ai.y] = 0;
	
	if(ResetColor)
	{
		uint4 ci = mups_color(ii);
		for(uint i=0; i<4; i++) Outbuf[ci[i]] = Color[i];
	}
	if(ResetVelocity)
	{
		uint4 ci = mups_velocity(ii);
		for(uint i=0; i<4; i++) Outbuf[ci[i]] = Velocity[i];
	}
	
	if(ResetSize)
		Outbuf[mups_size(ii)] = Size;
	
	uint sii = pii*DstC+dii;
	Outbuf[ii*pelsize + Destination[dii]] = Source[sii];
}
technique11 Emit64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit64() ) );} }