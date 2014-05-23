RWStructuredBuffer<float> Outbuf : BACKBUFFER;
#include "mups.fxh"
StructuredBuffer<float4> ColorTo;
StructuredBuffer<float2> SizeTo;
StructuredBuffer<float2> AgeFromTo;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

void main(csin input)
{
	uint ColTC, SizFC, AgeFC, Str;
	ColorTo.GetDimensions(ColTC, Str);
	SizeTo.GetDimensions(SizFC, Str);
	AgeFromTo.GetDimensions(AgeFC, Str);
	
	uint ii=input.DTID.x;
	uint2 ai = mups_age(ii);
	float fader = 1/abs(AgeFromTo[ii%AgeFC].x-AgeFromTo[ii%AgeFC].y);
	fader *= Time.y;
	fader = (Outbuf[ai.y] < AgeFromTo[ii%AgeFC].x) ? 0.0 : fader;
	if(ColTC>0)
	{
		uint4 ci = mups_color(ii);
		for(uint i=0; i<4; i++)
			Outbuf[ci[i]] = lerp(Outbuf[ci[i]],ColorTo[ii%ColTC][i],fader);
	}
	if(SizFC>0)
		Outbuf[mups_size(ii)] = lerp(Outbuf[mups_size(ii)],SizeTo[ii%SizFC].y,fader);
}

[numthreads(1, 1, 1)]
void CS_FadeTo1(csin input) { main(input); }
technique11 FadeTo1 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo1() ) );} }
[numthreads(2, 1, 1)]
void CS_FadeTo2(csin input) { main(input); }
technique11 FadeTo2 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo2() ) );} }
[numthreads(3, 1, 1)]
void CS_FadeTo3(csin input) { main(input); }
technique11 FadeTo3 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo3() ) );} }
[numthreads(4, 1, 1)]
void CS_FadeTo4(csin input) { main(input); }
technique11 FadeTo4 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo4() ) );} }
[numthreads(5, 1, 1)]
void CS_FadeTo5(csin input) { main(input); }
technique11 FadeTo5 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo5() ) );} }
[numthreads(6, 1, 1)]
void CS_FadeTo6(csin input) { main(input); }
technique11 FadeTo6 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo6() ) );} }
[numthreads(7, 1, 1)]
void CS_FadeTo7(csin input) { main(input); }
technique11 FadeTo7 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo7() ) );} }
[numthreads(8, 1, 1)]
void CS_FadeTo8(csin input) { main(input); }
technique11 FadeTo8 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo8() ) );} }
[numthreads(9, 1, 1)]
void CS_FadeTo9(csin input) { main(input); }
technique11 FadeTo9 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo9() ) );} }
[numthreads(10, 1, 1)]
void CS_FadeTo10(csin input) { main(input); }
technique11 FadeTo10 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo10() ) );} }
[numthreads(11, 1, 1)]
void CS_FadeTo11(csin input) { main(input); }
technique11 FadeTo11 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo11() ) );} }
[numthreads(12, 1, 1)]
void CS_FadeTo12(csin input) { main(input); }
technique11 FadeTo12 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo12() ) );} }
[numthreads(13, 1, 1)]
void CS_FadeTo13(csin input) { main(input); }
technique11 FadeTo13 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo13() ) );} }
[numthreads(14, 1, 1)]
void CS_FadeTo14(csin input) { main(input); }
technique11 FadeTo14 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo14() ) );} }
[numthreads(15, 1, 1)]
void CS_FadeTo15(csin input) { main(input); }
technique11 FadeTo15 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo15() ) );} }
[numthreads(16, 1, 1)]
void CS_FadeTo16(csin input) { main(input); }
technique11 FadeTo16 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo16() ) );} }
[numthreads(17, 1, 1)]
void CS_FadeTo17(csin input) { main(input); }
technique11 FadeTo17 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo17() ) );} }
[numthreads(18, 1, 1)]
void CS_FadeTo18(csin input) { main(input); }
technique11 FadeTo18 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo18() ) );} }
[numthreads(19, 1, 1)]
void CS_FadeTo19(csin input) { main(input); }
technique11 FadeTo19 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo19() ) );} }
[numthreads(20, 1, 1)]
void CS_FadeTo20(csin input) { main(input); }
technique11 FadeTo20 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo20() ) );} }
[numthreads(21, 1, 1)]
void CS_FadeTo21(csin input) { main(input); }
technique11 FadeTo21 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo21() ) );} }
[numthreads(22, 1, 1)]
void CS_FadeTo22(csin input) { main(input); }
technique11 FadeTo22 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo22() ) );} }
[numthreads(23, 1, 1)]
void CS_FadeTo23(csin input) { main(input); }
technique11 FadeTo23 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo23() ) );} }
[numthreads(24, 1, 1)]
void CS_FadeTo24(csin input) { main(input); }
technique11 FadeTo24 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo24() ) );} }
[numthreads(25, 1, 1)]
void CS_FadeTo25(csin input) { main(input); }
technique11 FadeTo25 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo25() ) );} }
[numthreads(26, 1, 1)]
void CS_FadeTo26(csin input) { main(input); }
technique11 FadeTo26 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo26() ) );} }
[numthreads(27, 1, 1)]
void CS_FadeTo27(csin input) { main(input); }
technique11 FadeTo27 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo27() ) );} }
[numthreads(28, 1, 1)]
void CS_FadeTo28(csin input) { main(input); }
technique11 FadeTo28 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo28() ) );} }
[numthreads(29, 1, 1)]
void CS_FadeTo29(csin input) { main(input); }
technique11 FadeTo29 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo29() ) );} }
[numthreads(30, 1, 1)]
void CS_FadeTo30(csin input) { main(input); }
technique11 FadeTo30 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo30() ) );} }
[numthreads(31, 1, 1)]
void CS_FadeTo31(csin input) { main(input); }
technique11 FadeTo31 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo31() ) );} }
[numthreads(32, 1, 1)]
void CS_FadeTo32(csin input) { main(input); }
technique11 FadeTo32 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo32() ) );} }
[numthreads(33, 1, 1)]
void CS_FadeTo33(csin input) { main(input); }
technique11 FadeTo33 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo33() ) );} }
[numthreads(34, 1, 1)]
void CS_FadeTo34(csin input) { main(input); }
technique11 FadeTo34 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo34() ) );} }
[numthreads(35, 1, 1)]
void CS_FadeTo35(csin input) { main(input); }
technique11 FadeTo35 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo35() ) );} }
[numthreads(36, 1, 1)]
void CS_FadeTo36(csin input) { main(input); }
technique11 FadeTo36 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo36() ) );} }
[numthreads(37, 1, 1)]
void CS_FadeTo37(csin input) { main(input); }
technique11 FadeTo37 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo37() ) );} }
[numthreads(38, 1, 1)]
void CS_FadeTo38(csin input) { main(input); }
technique11 FadeTo38 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo38() ) );} }
[numthreads(39, 1, 1)]
void CS_FadeTo39(csin input) { main(input); }
technique11 FadeTo39 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo39() ) );} }
[numthreads(40, 1, 1)]
void CS_FadeTo40(csin input) { main(input); }
technique11 FadeTo40 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo40() ) );} }
[numthreads(41, 1, 1)]
void CS_FadeTo41(csin input) { main(input); }
technique11 FadeTo41 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo41() ) );} }
[numthreads(42, 1, 1)]
void CS_FadeTo42(csin input) { main(input); }
technique11 FadeTo42 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo42() ) );} }
[numthreads(43, 1, 1)]
void CS_FadeTo43(csin input) { main(input); }
technique11 FadeTo43 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo43() ) );} }
[numthreads(44, 1, 1)]
void CS_FadeTo44(csin input) { main(input); }
technique11 FadeTo44 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo44() ) );} }
[numthreads(45, 1, 1)]
void CS_FadeTo45(csin input) { main(input); }
technique11 FadeTo45 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo45() ) );} }
[numthreads(46, 1, 1)]
void CS_FadeTo46(csin input) { main(input); }
technique11 FadeTo46 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo46() ) );} }
[numthreads(47, 1, 1)]
void CS_FadeTo47(csin input) { main(input); }
technique11 FadeTo47 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo47() ) );} }
[numthreads(48, 1, 1)]
void CS_FadeTo48(csin input) { main(input); }
technique11 FadeTo48 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo48() ) );} }
[numthreads(49, 1, 1)]
void CS_FadeTo49(csin input) { main(input); }
technique11 FadeTo49 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo49() ) );} }
[numthreads(50, 1, 1)]
void CS_FadeTo50(csin input) { main(input); }
technique11 FadeTo50 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo50() ) );} }
[numthreads(51, 1, 1)]
void CS_FadeTo51(csin input) { main(input); }
technique11 FadeTo51 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo51() ) );} }
[numthreads(52, 1, 1)]
void CS_FadeTo52(csin input) { main(input); }
technique11 FadeTo52 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo52() ) );} }
[numthreads(53, 1, 1)]
void CS_FadeTo53(csin input) { main(input); }
technique11 FadeTo53 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo53() ) );} }
[numthreads(54, 1, 1)]
void CS_FadeTo54(csin input) { main(input); }
technique11 FadeTo54 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo54() ) );} }
[numthreads(55, 1, 1)]
void CS_FadeTo55(csin input) { main(input); }
technique11 FadeTo55 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo55() ) );} }
[numthreads(56, 1, 1)]
void CS_FadeTo56(csin input) { main(input); }
technique11 FadeTo56 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo56() ) );} }
[numthreads(57, 1, 1)]
void CS_FadeTo57(csin input) { main(input); }
technique11 FadeTo57 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo57() ) );} }
[numthreads(58, 1, 1)]
void CS_FadeTo58(csin input) { main(input); }
technique11 FadeTo58 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo58() ) );} }
[numthreads(59, 1, 1)]
void CS_FadeTo59(csin input) { main(input); }
technique11 FadeTo59 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo59() ) );} }
[numthreads(60, 1, 1)]
void CS_FadeTo60(csin input) { main(input); }
technique11 FadeTo60 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo60() ) );} }
[numthreads(61, 1, 1)]
void CS_FadeTo61(csin input) { main(input); }
technique11 FadeTo61 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo61() ) );} }
[numthreads(62, 1, 1)]
void CS_FadeTo62(csin input) { main(input); }
technique11 FadeTo62 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo62() ) );} }
[numthreads(63, 1, 1)]
void CS_FadeTo63(csin input) { main(input); }
technique11 FadeTo63 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo63() ) );} }
[numthreads(64, 1, 1)]
void CS_FadeTo64(csin input) { main(input); }
technique11 FadeTo64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_FadeTo64() ) );} }