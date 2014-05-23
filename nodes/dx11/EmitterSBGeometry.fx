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
StructuredBuffer<uint> CtrlTexDst;

StructuredBuffer<uint> TriangleID;
StructuredBuffer<float3> VertexWeight;

int EmitterID = 0;

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
void main(csin input, uint ThreadCount)
{
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
			Outbuf[ii*pelsize+CtrlTexDst[txii]] = ctrl[cid%4];
		}
	}
}

[numthreads(1, 1, 1)]
void CS_Emit1(csin input) { main(input, 1); }
technique11 Emit1 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit1() ) );} }
[numthreads(2, 1, 1)]
void CS_Emit2(csin input) { main(input, 2); }
technique11 Emit2 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit2() ) );} }
[numthreads(3, 1, 1)]
void CS_Emit3(csin input) { main(input, 3); }
technique11 Emit3 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit3() ) );} }
[numthreads(4, 1, 1)]
void CS_Emit4(csin input) { main(input, 4); }
technique11 Emit4 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit4() ) );} }
[numthreads(5, 1, 1)]
void CS_Emit5(csin input) { main(input, 5); }
technique11 Emit5 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit5() ) );} }
[numthreads(6, 1, 1)]
void CS_Emit6(csin input) { main(input, 6); }
technique11 Emit6 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit6() ) );} }
[numthreads(7, 1, 1)]
void CS_Emit7(csin input) { main(input, 7); }
technique11 Emit7 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit7() ) );} }
[numthreads(8, 1, 1)]
void CS_Emit8(csin input) { main(input, 8); }
technique11 Emit8 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit8() ) );} }
[numthreads(9, 1, 1)]
void CS_Emit9(csin input) { main(input, 9); }
technique11 Emit9 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit9() ) );} }
[numthreads(10, 1, 1)]
void CS_Emit10(csin input) { main(input, 10); }
technique11 Emit10 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit10() ) );} }
[numthreads(11, 1, 1)]
void CS_Emit11(csin input) { main(input, 11); }
technique11 Emit11 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit11() ) );} }
[numthreads(12, 1, 1)]
void CS_Emit12(csin input) { main(input, 12); }
technique11 Emit12 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit12() ) );} }
[numthreads(13, 1, 1)]
void CS_Emit13(csin input) { main(input, 13); }
technique11 Emit13 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit13() ) );} }
[numthreads(14, 1, 1)]
void CS_Emit14(csin input) { main(input, 14); }
technique11 Emit14 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit14() ) );} }
[numthreads(15, 1, 1)]
void CS_Emit15(csin input) { main(input, 15); }
technique11 Emit15 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit15() ) );} }
[numthreads(16, 1, 1)]
void CS_Emit16(csin input) { main(input, 16); }
technique11 Emit16 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit16() ) );} }
[numthreads(17, 1, 1)]
void CS_Emit17(csin input) { main(input, 17); }
technique11 Emit17 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit17() ) );} }
[numthreads(18, 1, 1)]
void CS_Emit18(csin input) { main(input, 18); }
technique11 Emit18 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit18() ) );} }
[numthreads(19, 1, 1)]
void CS_Emit19(csin input) { main(input, 19); }
technique11 Emit19 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit19() ) );} }
[numthreads(20, 1, 1)]
void CS_Emit20(csin input) { main(input, 20); }
technique11 Emit20 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit20() ) );} }
[numthreads(21, 1, 1)]
void CS_Emit21(csin input) { main(input, 21); }
technique11 Emit21 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit21() ) );} }
[numthreads(22, 1, 1)]
void CS_Emit22(csin input) { main(input, 22); }
technique11 Emit22 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit22() ) );} }
[numthreads(23, 1, 1)]
void CS_Emit23(csin input) { main(input, 23); }
technique11 Emit23 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit23() ) );} }
[numthreads(24, 1, 1)]
void CS_Emit24(csin input) { main(input, 24); }
technique11 Emit24 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit24() ) );} }
[numthreads(25, 1, 1)]
void CS_Emit25(csin input) { main(input, 25); }
technique11 Emit25 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit25() ) );} }
[numthreads(26, 1, 1)]
void CS_Emit26(csin input) { main(input, 26); }
technique11 Emit26 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit26() ) );} }
[numthreads(27, 1, 1)]
void CS_Emit27(csin input) { main(input, 27); }
technique11 Emit27 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit27() ) );} }
[numthreads(28, 1, 1)]
void CS_Emit28(csin input) { main(input, 28); }
technique11 Emit28 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit28() ) );} }
[numthreads(29, 1, 1)]
void CS_Emit29(csin input) { main(input, 29); }
technique11 Emit29 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit29() ) );} }
[numthreads(30, 1, 1)]
void CS_Emit30(csin input) { main(input, 30); }
technique11 Emit30 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit30() ) );} }
[numthreads(31, 1, 1)]
void CS_Emit31(csin input) { main(input, 31); }
technique11 Emit31 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit31() ) );} }
[numthreads(32, 1, 1)]
void CS_Emit32(csin input) { main(input, 32); }
technique11 Emit32 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit32() ) );} }
[numthreads(33, 1, 1)]
void CS_Emit33(csin input) { main(input, 33); }
technique11 Emit33 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit33() ) );} }
[numthreads(34, 1, 1)]
void CS_Emit34(csin input) { main(input, 34); }
technique11 Emit34 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit34() ) );} }
[numthreads(35, 1, 1)]
void CS_Emit35(csin input) { main(input, 35); }
technique11 Emit35 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit35() ) );} }
[numthreads(36, 1, 1)]
void CS_Emit36(csin input) { main(input, 36); }
technique11 Emit36 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit36() ) );} }
[numthreads(37, 1, 1)]
void CS_Emit37(csin input) { main(input, 37); }
technique11 Emit37 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit37() ) );} }
[numthreads(38, 1, 1)]
void CS_Emit38(csin input) { main(input, 38); }
technique11 Emit38 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit38() ) );} }
[numthreads(39, 1, 1)]
void CS_Emit39(csin input) { main(input, 39); }
technique11 Emit39 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit39() ) );} }
[numthreads(40, 1, 1)]
void CS_Emit40(csin input) { main(input, 40); }
technique11 Emit40 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit40() ) );} }
[numthreads(41, 1, 1)]
void CS_Emit41(csin input) { main(input, 41); }
technique11 Emit41 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit41() ) );} }
[numthreads(42, 1, 1)]
void CS_Emit42(csin input) { main(input, 42); }
technique11 Emit42 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit42() ) );} }
[numthreads(43, 1, 1)]
void CS_Emit43(csin input) { main(input, 43); }
technique11 Emit43 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit43() ) );} }
[numthreads(44, 1, 1)]
void CS_Emit44(csin input) { main(input, 44); }
technique11 Emit44 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit44() ) );} }
[numthreads(45, 1, 1)]
void CS_Emit45(csin input) { main(input, 45); }
technique11 Emit45 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit45() ) );} }
[numthreads(46, 1, 1)]
void CS_Emit46(csin input) { main(input, 46); }
technique11 Emit46 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit46() ) );} }
[numthreads(47, 1, 1)]
void CS_Emit47(csin input) { main(input, 47); }
technique11 Emit47 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit47() ) );} }
[numthreads(48, 1, 1)]
void CS_Emit48(csin input) { main(input, 48); }
technique11 Emit48 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit48() ) );} }
[numthreads(49, 1, 1)]
void CS_Emit49(csin input) { main(input, 49); }
technique11 Emit49 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit49() ) );} }
[numthreads(50, 1, 1)]
void CS_Emit50(csin input) { main(input, 50); }
technique11 Emit50 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit50() ) );} }
[numthreads(51, 1, 1)]
void CS_Emit51(csin input) { main(input, 51); }
technique11 Emit51 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit51() ) );} }
[numthreads(52, 1, 1)]
void CS_Emit52(csin input) { main(input, 52); }
technique11 Emit52 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit52() ) );} }
[numthreads(53, 1, 1)]
void CS_Emit53(csin input) { main(input, 53); }
technique11 Emit53 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit53() ) );} }
[numthreads(54, 1, 1)]
void CS_Emit54(csin input) { main(input, 54); }
technique11 Emit54 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit54() ) );} }
[numthreads(55, 1, 1)]
void CS_Emit55(csin input) { main(input, 55); }
technique11 Emit55 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit55() ) );} }
[numthreads(56, 1, 1)]
void CS_Emit56(csin input) { main(input, 56); }
technique11 Emit56 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit56() ) );} }
[numthreads(57, 1, 1)]
void CS_Emit57(csin input) { main(input, 57); }
technique11 Emit57 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit57() ) );} }
[numthreads(58, 1, 1)]
void CS_Emit58(csin input) { main(input, 58); }
technique11 Emit58 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit58() ) );} }
[numthreads(59, 1, 1)]
void CS_Emit59(csin input) { main(input, 59); }
technique11 Emit59 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit59() ) );} }
[numthreads(60, 1, 1)]
void CS_Emit60(csin input) { main(input, 60); }
technique11 Emit60 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit60() ) );} }
[numthreads(61, 1, 1)]
void CS_Emit61(csin input) { main(input, 61); }
technique11 Emit61 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit61() ) );} }
[numthreads(62, 1, 1)]
void CS_Emit62(csin input) { main(input, 62); }
technique11 Emit62 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit62() ) );} }
[numthreads(63, 1, 1)]
void CS_Emit63(csin input) { main(input, 63); }
technique11 Emit63 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit63() ) );} }
[numthreads(64, 1, 1)]
void CS_Emit64(csin input) { main(input, 64); }
technique11 Emit64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit64() ) );} }