
#include "mups.fxh"
RWByteAddressBuffer Outbuf : BACKBUFFER;

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

void main(csin input)
{
	uint sftC, dstC, AgeFC, Str;
	SourceFromTo.GetDimensions(sftC, Str);
	Destination.GetDimensions(dstC, Str);
	AgeFromTo.GetDimensions(AgeFC, Str);
	
	uint ii=input.DTID.x;
	uint id=input.DTID.y;
	float fader = saturate((mups_age_load(Outbuf, ii).y-AgeFromTo[id%AgeFC].x)/(AgeFromTo[id%AgeFC].y-AgeFromTo[id%AgeFC].x));
	
	float res = lerp(SourceFromTo[id%sftC].x, SourceFromTo[id%sftC].y, pow(fader,FaderPow));
	mups_store(Outbuf, ii, Destination[id%dstC]*4, res);
}

[numthreads(1, 1, 1)]
void CS_FadeFull1(csin input) { main(input); }
technique11 FadeFull1 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull1() ) );} }
[numthreads(2, 1, 1)]
void CS_FadeFull2(csin input) { main(input); }
technique11 FadeFull2 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull2() ) );} }
[numthreads(3, 1, 1)]
void CS_FadeFull3(csin input) { main(input); }
technique11 FadeFull3 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull3() ) );} }
[numthreads(4, 1, 1)]
void CS_FadeFull4(csin input) { main(input); }
technique11 FadeFull4 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull4() ) );} }
[numthreads(5, 1, 1)]
void CS_FadeFull5(csin input) { main(input); }
technique11 FadeFull5 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull5() ) );} }
[numthreads(6, 1, 1)]
void CS_FadeFull6(csin input) { main(input); }
technique11 FadeFull6 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull6() ) );} }
[numthreads(7, 1, 1)]
void CS_FadeFull7(csin input) { main(input); }
technique11 FadeFull7 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull7() ) );} }
[numthreads(8, 1, 1)]
void CS_FadeFull8(csin input) { main(input); }
technique11 FadeFull8 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull8() ) );} }
[numthreads(9, 1, 1)]
void CS_FadeFull9(csin input) { main(input); }
technique11 FadeFull9 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull9() ) );} }
[numthreads(10, 1, 1)]
void CS_FadeFull10(csin input) { main(input); }
technique11 FadeFull10 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull10() ) );} }
[numthreads(11, 1, 1)]
void CS_FadeFull11(csin input) { main(input); }
technique11 FadeFull11 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull11() ) );} }
[numthreads(12, 1, 1)]
void CS_FadeFull12(csin input) { main(input); }
technique11 FadeFull12 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull12() ) );} }
[numthreads(13, 1, 1)]
void CS_FadeFull13(csin input) { main(input); }
technique11 FadeFull13 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull13() ) );} }
[numthreads(14, 1, 1)]
void CS_FadeFull14(csin input) { main(input); }
technique11 FadeFull14 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull14() ) );} }
[numthreads(15, 1, 1)]
void CS_FadeFull15(csin input) { main(input); }
technique11 FadeFull15 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull15() ) );} }
[numthreads(16, 1, 1)]
void CS_FadeFull16(csin input) { main(input); }
technique11 FadeFull16 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull16() ) );} }
[numthreads(17, 1, 1)]
void CS_FadeFull17(csin input) { main(input); }
technique11 FadeFull17 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull17() ) );} }
[numthreads(18, 1, 1)]
void CS_FadeFull18(csin input) { main(input); }
technique11 FadeFull18 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull18() ) );} }
[numthreads(19, 1, 1)]
void CS_FadeFull19(csin input) { main(input); }
technique11 FadeFull19 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull19() ) );} }
[numthreads(20, 1, 1)]
void CS_FadeFull20(csin input) { main(input); }
technique11 FadeFull20 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull20() ) );} }
[numthreads(21, 1, 1)]
void CS_FadeFull21(csin input) { main(input); }
technique11 FadeFull21 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull21() ) );} }
[numthreads(22, 1, 1)]
void CS_FadeFull22(csin input) { main(input); }
technique11 FadeFull22 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull22() ) );} }
[numthreads(23, 1, 1)]
void CS_FadeFull23(csin input) { main(input); }
technique11 FadeFull23 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull23() ) );} }
[numthreads(24, 1, 1)]
void CS_FadeFull24(csin input) { main(input); }
technique11 FadeFull24 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull24() ) );} }
[numthreads(25, 1, 1)]
void CS_FadeFull25(csin input) { main(input); }
technique11 FadeFull25 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull25() ) );} }
[numthreads(26, 1, 1)]
void CS_FadeFull26(csin input) { main(input); }
technique11 FadeFull26 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull26() ) );} }
[numthreads(27, 1, 1)]
void CS_FadeFull27(csin input) { main(input); }
technique11 FadeFull27 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull27() ) );} }
[numthreads(28, 1, 1)]
void CS_FadeFull28(csin input) { main(input); }
technique11 FadeFull28 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull28() ) );} }
[numthreads(29, 1, 1)]
void CS_FadeFull29(csin input) { main(input); }
technique11 FadeFull29 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull29() ) );} }
[numthreads(30, 1, 1)]
void CS_FadeFull30(csin input) { main(input); }
technique11 FadeFull30 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull30() ) );} }
[numthreads(31, 1, 1)]
void CS_FadeFull31(csin input) { main(input); }
technique11 FadeFull31 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull31() ) );} }
[numthreads(32, 1, 1)]
void CS_FadeFull32(csin input) { main(input); }
technique11 FadeFull32 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull32() ) );} }
[numthreads(33, 1, 1)]
void CS_FadeFull33(csin input) { main(input); }
technique11 FadeFull33 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull33() ) );} }
[numthreads(34, 1, 1)]
void CS_FadeFull34(csin input) { main(input); }
technique11 FadeFull34 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull34() ) );} }
[numthreads(35, 1, 1)]
void CS_FadeFull35(csin input) { main(input); }
technique11 FadeFull35 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull35() ) );} }
[numthreads(36, 1, 1)]
void CS_FadeFull36(csin input) { main(input); }
technique11 FadeFull36 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull36() ) );} }
[numthreads(37, 1, 1)]
void CS_FadeFull37(csin input) { main(input); }
technique11 FadeFull37 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull37() ) );} }
[numthreads(38, 1, 1)]
void CS_FadeFull38(csin input) { main(input); }
technique11 FadeFull38 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull38() ) );} }
[numthreads(39, 1, 1)]
void CS_FadeFull39(csin input) { main(input); }
technique11 FadeFull39 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull39() ) );} }
[numthreads(40, 1, 1)]
void CS_FadeFull40(csin input) { main(input); }
technique11 FadeFull40 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull40() ) );} }
[numthreads(41, 1, 1)]
void CS_FadeFull41(csin input) { main(input); }
technique11 FadeFull41 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull41() ) );} }
[numthreads(42, 1, 1)]
void CS_FadeFull42(csin input) { main(input); }
technique11 FadeFull42 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull42() ) );} }
[numthreads(43, 1, 1)]
void CS_FadeFull43(csin input) { main(input); }
technique11 FadeFull43 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull43() ) );} }
[numthreads(44, 1, 1)]
void CS_FadeFull44(csin input) { main(input); }
technique11 FadeFull44 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull44() ) );} }
[numthreads(45, 1, 1)]
void CS_FadeFull45(csin input) { main(input); }
technique11 FadeFull45 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull45() ) );} }
[numthreads(46, 1, 1)]
void CS_FadeFull46(csin input) { main(input); }
technique11 FadeFull46 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull46() ) );} }
[numthreads(47, 1, 1)]
void CS_FadeFull47(csin input) { main(input); }
technique11 FadeFull47 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull47() ) );} }
[numthreads(48, 1, 1)]
void CS_FadeFull48(csin input) { main(input); }
technique11 FadeFull48 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull48() ) );} }
[numthreads(49, 1, 1)]
void CS_FadeFull49(csin input) { main(input); }
technique11 FadeFull49 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull49() ) );} }
[numthreads(50, 1, 1)]
void CS_FadeFull50(csin input) { main(input); }
technique11 FadeFull50 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull50() ) );} }
[numthreads(51, 1, 1)]
void CS_FadeFull51(csin input) { main(input); }
technique11 FadeFull51 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull51() ) );} }
[numthreads(52, 1, 1)]
void CS_FadeFull52(csin input) { main(input); }
technique11 FadeFull52 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull52() ) );} }
[numthreads(53, 1, 1)]
void CS_FadeFull53(csin input) { main(input); }
technique11 FadeFull53 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull53() ) );} }
[numthreads(54, 1, 1)]
void CS_FadeFull54(csin input) { main(input); }
technique11 FadeFull54 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull54() ) );} }
[numthreads(55, 1, 1)]
void CS_FadeFull55(csin input) { main(input); }
technique11 FadeFull55 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull55() ) );} }
[numthreads(56, 1, 1)]
void CS_FadeFull56(csin input) { main(input); }
technique11 FadeFull56 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull56() ) );} }
[numthreads(57, 1, 1)]
void CS_FadeFull57(csin input) { main(input); }
technique11 FadeFull57 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull57() ) );} }
[numthreads(58, 1, 1)]
void CS_FadeFull58(csin input) { main(input); }
technique11 FadeFull58 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull58() ) );} }
[numthreads(59, 1, 1)]
void CS_FadeFull59(csin input) { main(input); }
technique11 FadeFull59 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull59() ) );} }
[numthreads(60, 1, 1)]
void CS_FadeFull60(csin input) { main(input); }
technique11 FadeFull60 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull60() ) );} }
[numthreads(61, 1, 1)]
void CS_FadeFull61(csin input) { main(input); }
technique11 FadeFull61 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull61() ) );} }
[numthreads(62, 1, 1)]
void CS_FadeFull62(csin input) { main(input); }
technique11 FadeFull62 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull62() ) );} }
[numthreads(63, 1, 1)]
void CS_FadeFull63(csin input) { main(input); }
technique11 FadeFull63 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull63() ) );} }
[numthreads(64, 1, 1)]
void CS_FadeFull64(csin input) { main(input); }
technique11 FadeFull64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeFull64() ) );} }