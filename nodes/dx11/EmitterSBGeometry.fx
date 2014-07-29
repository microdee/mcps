RWStructuredBuffer<float> Outbuf : BACKBUFFER;
#include "mups.fxh"

ByteAddressBuffer IndexBuf;
StructuredBuffer<float3> GeomPosition;
StructuredBuffer<float3> GeomNormal;
StructuredBuffer<float3> GeomUV;
float4x4 tW : WORLD;
// size, offset

float NormalToVelocity = 0;

Texture2D ColorTex;
Texture2DArray CtrlTex;
SamplerState s0 <bool visible=false;string uiname="Sampler";>
	{Filter=MIN_MAG_MIP_LINEAR;AddressU=CLAMP;AddressV=CLAMP;};

StructuredBuffer<uint> CtrlTexSrc;
float4x4 CtrlTexTr;
StructuredBuffer<uint> CtrlTexDst;

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
	float3 norm;
	float2 txcd;
};

[numthreads(64, 1, 1)]
void CS_Emit64(csin input)
{
	if(input.DTID.x > emitcount) return;

	// get dimensions
	uint TIDC, VWC, CtrlSrcC, CtrlDstC, Str;
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
		vert[i].pos = GeomPosition[IndexBuf.Load((trii+i)*4)];
		vert[i].norm = GeomNormal[IndexBuf.Load((trii+i)*4)];
		vert[i].txcd = GeomUV[IndexBuf.Load((trii+i)*4)].xy;
	}
	float3 vweight = VertexWeight[pii];
	float vweightSum = vweight.x + vweight.y + vweight.z;
	float3 tpos = 0;
	float3 tnorm = 0;
	float2 ttxcd = 0;
	for(uint i=0; i<3; i++)
	{
		tpos += vert[i].pos * vweight[i];
		tnorm += vert[i].norm * vweight[i];
		ttxcd += vert[i].txcd * vweight[i];
	}
	tpos /= vweightSum;
	tpos = mul(float4(tpos,1),tW).xyz;
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
		for(uint i=0; i<3; i++) Outbuf[vi[i]] = tnorm[i] * NormalToVelocity;
		Outbuf[vi.w] = 1;
		
		uint4 ci = mups_color(ii);
		for(uint i=0; i<4; i++) Outbuf[ci[i]] = col[i];
		Outbuf[mups_size(ii)] = 1;
	}
	
	// optional texture controlled
	if(CtrlDstC != 0)
	{
		if(input.DTID.y > 0)
		{
			uint txii = max(input.DTID.y-1,0);
			uint cid = CtrlTexSrc[txii%CtrlSrcC];
			float4 ctrl = CtrlTex.SampleLevel(s0, float3(ttxcd, floor(cid/4)), 0);
			ctrl.rgb = mul(float4(ctrl.rgb,1),CtrlTexTr).xyz;
			
			Outbuf[ii*pelsize+CtrlTexDst[txii]] = ctrl[cid%4];
		}
	}
}
technique11 Emit64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit64() ) );} }