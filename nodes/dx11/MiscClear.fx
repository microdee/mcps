#include "mups.fxh"

RWStructuredBuffer<float> Outbuf : BACKBUFFER;
StructuredBuffer<float> Source;
StructuredBuffer<uint> Destination;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

void main(csin input)
{
	uint ii=input.DTID.x;
	uint id=input.DTID.y;
	
	Outbuf[ii*pelsize+Destination[id]] = Source[id];
}

[numthreads(1, 1, 1)]
void CS_Clear1(csin input) { main(input); }
technique11 Clear1 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear1() ) );} }
[numthreads(2, 1, 1)]
void CS_Clear2(csin input) { main(input); }
technique11 Clear2 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear2() ) );} }
[numthreads(3, 1, 1)]
void CS_Clear3(csin input) { main(input); }
technique11 Clear3 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear3() ) );} }
[numthreads(4, 1, 1)]
void CS_Clear4(csin input) { main(input); }
technique11 Clear4 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear4() ) );} }
[numthreads(5, 1, 1)]
void CS_Clear5(csin input) { main(input); }
technique11 Clear5 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear5() ) );} }
[numthreads(6, 1, 1)]
void CS_Clear6(csin input) { main(input); }
technique11 Clear6 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear6() ) );} }
[numthreads(7, 1, 1)]
void CS_Clear7(csin input) { main(input); }
technique11 Clear7 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear7() ) );} }
[numthreads(8, 1, 1)]
void CS_Clear8(csin input) { main(input); }
technique11 Clear8 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear8() ) );} }
[numthreads(9, 1, 1)]
void CS_Clear9(csin input) { main(input); }
technique11 Clear9 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear9() ) );} }
[numthreads(10, 1, 1)]
void CS_Clear10(csin input) { main(input); }
technique11 Clear10 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear10() ) );} }
[numthreads(11, 1, 1)]
void CS_Clear11(csin input) { main(input); }
technique11 Clear11 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear11() ) );} }
[numthreads(12, 1, 1)]
void CS_Clear12(csin input) { main(input); }
technique11 Clear12 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear12() ) );} }
[numthreads(13, 1, 1)]
void CS_Clear13(csin input) { main(input); }
technique11 Clear13 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear13() ) );} }
[numthreads(14, 1, 1)]
void CS_Clear14(csin input) { main(input); }
technique11 Clear14 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear14() ) );} }
[numthreads(15, 1, 1)]
void CS_Clear15(csin input) { main(input); }
technique11 Clear15 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear15() ) );} }
[numthreads(16, 1, 1)]
void CS_Clear16(csin input) { main(input); }
technique11 Clear16 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear16() ) );} }
[numthreads(17, 1, 1)]
void CS_Clear17(csin input) { main(input); }
technique11 Clear17 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear17() ) );} }
[numthreads(18, 1, 1)]
void CS_Clear18(csin input) { main(input); }
technique11 Clear18 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear18() ) );} }
[numthreads(19, 1, 1)]
void CS_Clear19(csin input) { main(input); }
technique11 Clear19 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear19() ) );} }
[numthreads(20, 1, 1)]
void CS_Clear20(csin input) { main(input); }
technique11 Clear20 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear20() ) );} }
[numthreads(21, 1, 1)]
void CS_Clear21(csin input) { main(input); }
technique11 Clear21 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear21() ) );} }
[numthreads(22, 1, 1)]
void CS_Clear22(csin input) { main(input); }
technique11 Clear22 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear22() ) );} }
[numthreads(23, 1, 1)]
void CS_Clear23(csin input) { main(input); }
technique11 Clear23 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear23() ) );} }
[numthreads(24, 1, 1)]
void CS_Clear24(csin input) { main(input); }
technique11 Clear24 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear24() ) );} }
[numthreads(25, 1, 1)]
void CS_Clear25(csin input) { main(input); }
technique11 Clear25 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear25() ) );} }
[numthreads(26, 1, 1)]
void CS_Clear26(csin input) { main(input); }
technique11 Clear26 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear26() ) );} }
[numthreads(27, 1, 1)]
void CS_Clear27(csin input) { main(input); }
technique11 Clear27 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear27() ) );} }
[numthreads(28, 1, 1)]
void CS_Clear28(csin input) { main(input); }
technique11 Clear28 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear28() ) );} }
[numthreads(29, 1, 1)]
void CS_Clear29(csin input) { main(input); }
technique11 Clear29 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear29() ) );} }
[numthreads(30, 1, 1)]
void CS_Clear30(csin input) { main(input); }
technique11 Clear30 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear30() ) );} }
[numthreads(31, 1, 1)]
void CS_Clear31(csin input) { main(input); }
technique11 Clear31 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear31() ) );} }
[numthreads(32, 1, 1)]
void CS_Clear32(csin input) { main(input); }
technique11 Clear32 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear32() ) );} }
[numthreads(33, 1, 1)]
void CS_Clear33(csin input) { main(input); }
technique11 Clear33 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear33() ) );} }
[numthreads(34, 1, 1)]
void CS_Clear34(csin input) { main(input); }
technique11 Clear34 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear34() ) );} }
[numthreads(35, 1, 1)]
void CS_Clear35(csin input) { main(input); }
technique11 Clear35 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear35() ) );} }
[numthreads(36, 1, 1)]
void CS_Clear36(csin input) { main(input); }
technique11 Clear36 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear36() ) );} }
[numthreads(37, 1, 1)]
void CS_Clear37(csin input) { main(input); }
technique11 Clear37 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear37() ) );} }
[numthreads(38, 1, 1)]
void CS_Clear38(csin input) { main(input); }
technique11 Clear38 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear38() ) );} }
[numthreads(39, 1, 1)]
void CS_Clear39(csin input) { main(input); }
technique11 Clear39 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear39() ) );} }
[numthreads(40, 1, 1)]
void CS_Clear40(csin input) { main(input); }
technique11 Clear40 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear40() ) );} }
[numthreads(41, 1, 1)]
void CS_Clear41(csin input) { main(input); }
technique11 Clear41 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear41() ) );} }
[numthreads(42, 1, 1)]
void CS_Clear42(csin input) { main(input); }
technique11 Clear42 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear42() ) );} }
[numthreads(43, 1, 1)]
void CS_Clear43(csin input) { main(input); }
technique11 Clear43 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear43() ) );} }
[numthreads(44, 1, 1)]
void CS_Clear44(csin input) { main(input); }
technique11 Clear44 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear44() ) );} }
[numthreads(45, 1, 1)]
void CS_Clear45(csin input) { main(input); }
technique11 Clear45 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear45() ) );} }
[numthreads(46, 1, 1)]
void CS_Clear46(csin input) { main(input); }
technique11 Clear46 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear46() ) );} }
[numthreads(47, 1, 1)]
void CS_Clear47(csin input) { main(input); }
technique11 Clear47 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear47() ) );} }
[numthreads(48, 1, 1)]
void CS_Clear48(csin input) { main(input); }
technique11 Clear48 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear48() ) );} }
[numthreads(49, 1, 1)]
void CS_Clear49(csin input) { main(input); }
technique11 Clear49 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear49() ) );} }
[numthreads(50, 1, 1)]
void CS_Clear50(csin input) { main(input); }
technique11 Clear50 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear50() ) );} }
[numthreads(51, 1, 1)]
void CS_Clear51(csin input) { main(input); }
technique11 Clear51 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear51() ) );} }
[numthreads(52, 1, 1)]
void CS_Clear52(csin input) { main(input); }
technique11 Clear52 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear52() ) );} }
[numthreads(53, 1, 1)]
void CS_Clear53(csin input) { main(input); }
technique11 Clear53 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear53() ) );} }
[numthreads(54, 1, 1)]
void CS_Clear54(csin input) { main(input); }
technique11 Clear54 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear54() ) );} }
[numthreads(55, 1, 1)]
void CS_Clear55(csin input) { main(input); }
technique11 Clear55 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear55() ) );} }
[numthreads(56, 1, 1)]
void CS_Clear56(csin input) { main(input); }
technique11 Clear56 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear56() ) );} }
[numthreads(57, 1, 1)]
void CS_Clear57(csin input) { main(input); }
technique11 Clear57 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear57() ) );} }
[numthreads(58, 1, 1)]
void CS_Clear58(csin input) { main(input); }
technique11 Clear58 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear58() ) );} }
[numthreads(59, 1, 1)]
void CS_Clear59(csin input) { main(input); }
technique11 Clear59 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear59() ) );} }
[numthreads(60, 1, 1)]
void CS_Clear60(csin input) { main(input); }
technique11 Clear60 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear60() ) );} }
[numthreads(61, 1, 1)]
void CS_Clear61(csin input) { main(input); }
technique11 Clear61 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear61() ) );} }
[numthreads(62, 1, 1)]
void CS_Clear62(csin input) { main(input); }
technique11 Clear62 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear62() ) );} }
[numthreads(63, 1, 1)]
void CS_Clear63(csin input) { main(input); }
technique11 Clear63 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear63() ) );} }
[numthreads(64, 1, 1)]
void CS_Clear64(csin input) { main(input); }
technique11 Clear64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Clear64() ) );} }