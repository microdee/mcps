
#include "mups.fxh"
RWByteAddressBuffer Outbuf : BACKBUFFER;
StructuredBuffer<float4x4> GroundTr;
StructuredBuffer<float4x4> InvGroundTr;
Texture2D DirTex;

SamplerState s0 <bool visible=false;string uiname="Sampler";>
	{Filter=MIN_MAG_MIP_LINEAR;AddressU=WRAP;AddressV=WRAP;};

float Damping = .96;
float DirAm = 0;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

void main(csin input)
{
	
	uint ii = input.DTID.x;
	uint trii = input.DTID.y;
	
	float3 cpos = mups_position_load(Outbuf, ii);
	
	float4 vel =  mups_velocity_load(Outbuf, ii);
	
	float3 npos = mul(float4(cpos,1),InvGroundTr[trii]).xyz;
	float3 nvel = mul(float4(vel.xyz,0),InvGroundTr[trii]).xyz;
	if(npos.y<0)
	{
		nvel.y *= -Damping;
		float2 uv = mul(float4(cpos,1),GroundTr[trii]).xy;
		nvel.xyz += (DirTex.SampleLevel(s0, uv, 0).rgb-.5) * DirAm * saturate(nvel.y-1);
		nvel = mul(float4(nvel,0),GroundTr[trii]).xyz;
		npos = mul(float4(npos.x,0,npos.z,1),GroundTr[trii]).xyz;

		mups_position_store(Outbuf, ii, npos);
		mups_velocity_store(Outbuf, ii, float4(nvel,vel.w));
	}
	
}

[numthreads(1, 1, 1)]
void CS_Ground1(csin input) { main(input); }
technique11 Ground1 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground1() ) );} }
[numthreads(2, 1, 1)]
void CS_Ground2(csin input) { main(input); }
technique11 Ground2 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground2() ) );} }
[numthreads(3, 1, 1)]
void CS_Ground3(csin input) { main(input); }
technique11 Ground3 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground3() ) );} }
[numthreads(4, 1, 1)]
void CS_Ground4(csin input) { main(input); }
technique11 Ground4 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground4() ) );} }
[numthreads(5, 1, 1)]
void CS_Ground5(csin input) { main(input); }
technique11 Ground5 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground5() ) );} }
[numthreads(6, 1, 1)]
void CS_Ground6(csin input) { main(input); }
technique11 Ground6 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground6() ) );} }
[numthreads(7, 1, 1)]
void CS_Ground7(csin input) { main(input); }
technique11 Ground7 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground7() ) );} }
[numthreads(8, 1, 1)]
void CS_Ground8(csin input) { main(input); }
technique11 Ground8 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground8() ) );} }
[numthreads(9, 1, 1)]
void CS_Ground9(csin input) { main(input); }
technique11 Ground9 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground9() ) );} }
[numthreads(10, 1, 1)]
void CS_Ground10(csin input) { main(input); }
technique11 Ground10 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground10() ) );} }
[numthreads(11, 1, 1)]
void CS_Ground11(csin input) { main(input); }
technique11 Ground11 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground11() ) );} }
[numthreads(12, 1, 1)]
void CS_Ground12(csin input) { main(input); }
technique11 Ground12 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground12() ) );} }
[numthreads(13, 1, 1)]
void CS_Ground13(csin input) { main(input); }
technique11 Ground13 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground13() ) );} }
[numthreads(14, 1, 1)]
void CS_Ground14(csin input) { main(input); }
technique11 Ground14 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground14() ) );} }
[numthreads(15, 1, 1)]
void CS_Ground15(csin input) { main(input); }
technique11 Ground15 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground15() ) );} }
[numthreads(16, 1, 1)]
void CS_Ground16(csin input) { main(input); }
technique11 Ground16 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground16() ) );} }
[numthreads(17, 1, 1)]
void CS_Ground17(csin input) { main(input); }
technique11 Ground17 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground17() ) );} }
[numthreads(18, 1, 1)]
void CS_Ground18(csin input) { main(input); }
technique11 Ground18 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground18() ) );} }
[numthreads(19, 1, 1)]
void CS_Ground19(csin input) { main(input); }
technique11 Ground19 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground19() ) );} }
[numthreads(20, 1, 1)]
void CS_Ground20(csin input) { main(input); }
technique11 Ground20 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground20() ) );} }
[numthreads(21, 1, 1)]
void CS_Ground21(csin input) { main(input); }
technique11 Ground21 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground21() ) );} }
[numthreads(22, 1, 1)]
void CS_Ground22(csin input) { main(input); }
technique11 Ground22 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground22() ) );} }
[numthreads(23, 1, 1)]
void CS_Ground23(csin input) { main(input); }
technique11 Ground23 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground23() ) );} }
[numthreads(24, 1, 1)]
void CS_Ground24(csin input) { main(input); }
technique11 Ground24 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground24() ) );} }
[numthreads(25, 1, 1)]
void CS_Ground25(csin input) { main(input); }
technique11 Ground25 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground25() ) );} }
[numthreads(26, 1, 1)]
void CS_Ground26(csin input) { main(input); }
technique11 Ground26 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground26() ) );} }
[numthreads(27, 1, 1)]
void CS_Ground27(csin input) { main(input); }
technique11 Ground27 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground27() ) );} }
[numthreads(28, 1, 1)]
void CS_Ground28(csin input) { main(input); }
technique11 Ground28 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground28() ) );} }
[numthreads(29, 1, 1)]
void CS_Ground29(csin input) { main(input); }
technique11 Ground29 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground29() ) );} }
[numthreads(30, 1, 1)]
void CS_Ground30(csin input) { main(input); }
technique11 Ground30 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground30() ) );} }
[numthreads(31, 1, 1)]
void CS_Ground31(csin input) { main(input); }
technique11 Ground31 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground31() ) );} }
[numthreads(32, 1, 1)]
void CS_Ground32(csin input) { main(input); }
technique11 Ground32 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground32() ) );} }
[numthreads(33, 1, 1)]
void CS_Ground33(csin input) { main(input); }
technique11 Ground33 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground33() ) );} }
[numthreads(34, 1, 1)]
void CS_Ground34(csin input) { main(input); }
technique11 Ground34 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground34() ) );} }
[numthreads(35, 1, 1)]
void CS_Ground35(csin input) { main(input); }
technique11 Ground35 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground35() ) );} }
[numthreads(36, 1, 1)]
void CS_Ground36(csin input) { main(input); }
technique11 Ground36 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground36() ) );} }
[numthreads(37, 1, 1)]
void CS_Ground37(csin input) { main(input); }
technique11 Ground37 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground37() ) );} }
[numthreads(38, 1, 1)]
void CS_Ground38(csin input) { main(input); }
technique11 Ground38 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground38() ) );} }
[numthreads(39, 1, 1)]
void CS_Ground39(csin input) { main(input); }
technique11 Ground39 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground39() ) );} }
[numthreads(40, 1, 1)]
void CS_Ground40(csin input) { main(input); }
technique11 Ground40 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground40() ) );} }
[numthreads(41, 1, 1)]
void CS_Ground41(csin input) { main(input); }
technique11 Ground41 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground41() ) );} }
[numthreads(42, 1, 1)]
void CS_Ground42(csin input) { main(input); }
technique11 Ground42 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground42() ) );} }
[numthreads(43, 1, 1)]
void CS_Ground43(csin input) { main(input); }
technique11 Ground43 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground43() ) );} }
[numthreads(44, 1, 1)]
void CS_Ground44(csin input) { main(input); }
technique11 Ground44 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground44() ) );} }
[numthreads(45, 1, 1)]
void CS_Ground45(csin input) { main(input); }
technique11 Ground45 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground45() ) );} }
[numthreads(46, 1, 1)]
void CS_Ground46(csin input) { main(input); }
technique11 Ground46 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground46() ) );} }
[numthreads(47, 1, 1)]
void CS_Ground47(csin input) { main(input); }
technique11 Ground47 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground47() ) );} }
[numthreads(48, 1, 1)]
void CS_Ground48(csin input) { main(input); }
technique11 Ground48 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground48() ) );} }
[numthreads(49, 1, 1)]
void CS_Ground49(csin input) { main(input); }
technique11 Ground49 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground49() ) );} }
[numthreads(50, 1, 1)]
void CS_Ground50(csin input) { main(input); }
technique11 Ground50 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground50() ) );} }
[numthreads(51, 1, 1)]
void CS_Ground51(csin input) { main(input); }
technique11 Ground51 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground51() ) );} }
[numthreads(52, 1, 1)]
void CS_Ground52(csin input) { main(input); }
technique11 Ground52 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground52() ) );} }
[numthreads(53, 1, 1)]
void CS_Ground53(csin input) { main(input); }
technique11 Ground53 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground53() ) );} }
[numthreads(54, 1, 1)]
void CS_Ground54(csin input) { main(input); }
technique11 Ground54 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground54() ) );} }
[numthreads(55, 1, 1)]
void CS_Ground55(csin input) { main(input); }
technique11 Ground55 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground55() ) );} }
[numthreads(56, 1, 1)]
void CS_Ground56(csin input) { main(input); }
technique11 Ground56 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground56() ) );} }
[numthreads(57, 1, 1)]
void CS_Ground57(csin input) { main(input); }
technique11 Ground57 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground57() ) );} }
[numthreads(58, 1, 1)]
void CS_Ground58(csin input) { main(input); }
technique11 Ground58 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground58() ) );} }
[numthreads(59, 1, 1)]
void CS_Ground59(csin input) { main(input); }
technique11 Ground59 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground59() ) );} }
[numthreads(60, 1, 1)]
void CS_Ground60(csin input) { main(input); }
technique11 Ground60 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground60() ) );} }
[numthreads(61, 1, 1)]
void CS_Ground61(csin input) { main(input); }
technique11 Ground61 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground61() ) );} }
[numthreads(62, 1, 1)]
void CS_Ground62(csin input) { main(input); }
technique11 Ground62 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground62() ) );} }
[numthreads(63, 1, 1)]
void CS_Ground63(csin input) { main(input); }
technique11 Ground63 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground63() ) );} }
[numthreads(64, 1, 1)]
void CS_Ground64(csin input) { main(input); }
technique11 Ground64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Ground64() ) );} }