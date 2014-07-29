RWStructuredBuffer<float> Outbuf : BACKBUFFER;
#include "mups.fxh"

ByteAddressBuffer GeometryBuf;
int Strides = 32;
float4x4 tW : WORLD;
// size, offset
StructuredBuffer<uint> Source;
StructuredBuffer<uint> Destination;

float NormalToVelocity = 0;
int NormalOffset = 12;
float VelocityFromPrevPos = 0;
int PrevPosOffset = 64;

Texture2D ColorTex;
Texture2D CtrlTex;
SamplerState s0 <bool visible=false;string uiname="Sampler";>
	{Filter=MIN_MAG_MIP_LINEAR;AddressU=CLAMP;AddressV=CLAMP;};

StructuredBuffer<uint> CtrlTexSrc;
StructuredBuffer<uint> CtrlTexDst;
int TexCdOffset = 24;

StructuredBuffer<uint> TriangleID;
StructuredBuffer<float3> VertexWeight;

int EmitterID = 0;
float emitcount = 100;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};
struct vertex
{
	float3 pos;
	float3 ppos;
	float3 norm;
	float2 txcd;
};

[numthreads(64, 1, 1)]
void CS_Emit64(csin input)
{
	if(input.DTID.x > emitcount) return;
	// get dimensions
	uint SrcC, DstC, TIDC, VWC, CtrlSrcC, CtrlDstC, Str;
	Source.GetDimensions(SrcC, Str);
	Destination.GetDimensions(DstC, Str);
	TriangleID.GetDimensions(TIDC, Str);
	VertexWeight.GetDimensions(VWC, Str);
	CtrlTexSrc.GetDimensions(CtrlSrcC, Str);
	CtrlTexDst.GetDimensions(CtrlDstC, Str);
	
	// calculate ID's
	uint ii=input.DTID.x + EmitCounter + EmitCountOffs[EmitterID];
	uint pii=input.DTID.x;
	uint2 ai = mups_age(ii);
	Outbuf[ai.x] = 0;
	Outbuf[ai.y] = 0;
	uint trii = TriangleID[pii]*3;
	
	// calculate barycentric
	vertex vert[3];
	for(uint i=0; i<3; i++)
	{
		vert[i].pos = asfloat(GeometryBuf.Load3((trii+i)*Strides));
		vert[i].norm = asfloat(GeometryBuf.Load3((trii+i)*Strides+NormalOffset));
		vert[i].txcd = asfloat(GeometryBuf.Load2((trii+i)*Strides+TexCdOffset));
		vert[i].ppos = asfloat(GeometryBuf.Load3((trii+i)*Strides+PrevPosOffset));
	}
	float3 vweight = VertexWeight[pii];
	float vweightSum = vweight.x + vweight.y + vweight.z;
	float3 tpos = 0;
	float3 tppos = 0;
	float3 tnorm = 0;
	float2 ttxcd = 0;
	for(uint i=0; i<3; i++)
	{
		tpos += vert[i].pos * vweight[i];
		tppos += vert[i].ppos * vweight[i];
		tnorm += vert[i].norm * vweight[i];
		ttxcd += vert[i].txcd * vweight[i];
	}
	tpos /= vweightSum;
	tpos = mul(float4(tpos,1),tW).xyz;
	tppos /= vweightSum;
	tppos = mul(float4(tppos,1),tW).xyz;
	tnorm /= vweightSum;
	tnorm = mul(float4(tpos,0),tW).xyz;
	ttxcd /= vweightSum;
	
	// main thread
	if(input.DTID.y == 0)
	{
		float4 col = ColorTex.SampleLevel(s0, ttxcd, 0);
		uint3 pi = mups_position(ii);
		for(uint i=0; i<3; i++) Outbuf[pi[i]] = tpos[i];
		
		uint4 vi = mups_velocity(ii);
		for(uint i=0; i<3; i++) 
		{
			Outbuf[vi[i]] = tnorm[i] * NormalToVelocity;
			Outbuf[vi[i]] += ((tpos[i]-tppos[i]) * VelocityFromPrevPos) / Time.y;
		}
		Outbuf[vi.w] = 1;
		
		uint4 ci = mups_color(ii);
		for(uint i=0; i<4; i++) Outbuf[ci[i]] = col[i];
		Outbuf[mups_size(ii)] = 1;
	}
	
	// optional vertex data controlled
	if(DstC != 0)
	{
		if((input.DTID.y > 0) && (input.DTID.y <= DstC))
		{
			uint oii = max(input.DTID.y-1,0);
			float3 vertexprop;
			for(uint i=0; i<3; i++)
				vertexprop[i] = asfloat(GeometryBuf.Load((trii+i)*Strides+Source[oii%SrcC]));
			vertexprop *= vweight;
			float prop = (vertexprop.x + vertexprop.y + vertexprop.z)/vweightSum;
			Outbuf[ii*pelsize+Destination[oii]] = prop;
		}
	}
	
	// optional texture controlled
	if(CtrlDstC != 0)
	{
		if(input.DTID.y > DstC)
		{
			uint txii = max(input.DTID.y-1-DstC,0);
			float4 ctrl = CtrlTex.SampleLevel(s0, ttxcd, 0);
			Outbuf[ii*pelsize+CtrlTexDst[txii]] = ctrl[CtrlTexSrc[txii%CtrlSrcC]%4];
		}
	}
}
technique11 Emit64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit64() ) );} }