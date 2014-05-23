//@author: vux
//@help: standard constant shader
//@tags: color
//@credits:

StructuredBuffer<float> BInput;
RWStructuredBuffer<float> BOutput : BACKBUFFER;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(1, 1, 1)]
void CS_c1(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy1 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c1() ) );} }
[numthreads(2, 1, 1)]
void CS_c2(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy2 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c2() ) );} }
[numthreads(3, 1, 1)]
void CS_c3(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy3 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c3() ) );} }
[numthreads(4, 1, 1)]
void CS_c4(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy4 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c4() ) );} }
[numthreads(5, 1, 1)]
void CS_c5(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy5 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c5() ) );} }
[numthreads(6, 1, 1)]
void CS_c6(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy6 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c6() ) );} }
[numthreads(7, 1, 1)]
void CS_c7(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy7 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c7() ) );} }
[numthreads(8, 1, 1)]
void CS_c8(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy8 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c8() ) );} }
[numthreads(9, 1, 1)]
void CS_c9(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy9 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c9() ) );} }
[numthreads(10, 1, 1)]
void CS_c10(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy10 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c10() ) );} }
[numthreads(11, 1, 1)]
void CS_c11(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy11 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c11() ) );} }
[numthreads(12, 1, 1)]
void CS_c12(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy12 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c12() ) );} }
[numthreads(13, 1, 1)]
void CS_c13(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy13 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c13() ) );} }
[numthreads(14, 1, 1)]
void CS_c14(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy14 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c14() ) );} }
[numthreads(15, 1, 1)]
void CS_c15(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy15 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c15() ) );} }
[numthreads(16, 1, 1)]
void CS_c16(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy16 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c16() ) );} }
[numthreads(17, 1, 1)]
void CS_c17(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy17 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c17() ) );} }
[numthreads(18, 1, 1)]
void CS_c18(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy18 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c18() ) );} }
[numthreads(19, 1, 1)]
void CS_c19(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy19 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c19() ) );} }
[numthreads(20, 1, 1)]
void CS_c20(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy20 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c20() ) );} }
[numthreads(21, 1, 1)]
void CS_c21(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy21 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c21() ) );} }
[numthreads(22, 1, 1)]
void CS_c22(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy22 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c22() ) );} }
[numthreads(23, 1, 1)]
void CS_c23(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy23 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c23() ) );} }
[numthreads(24, 1, 1)]
void CS_c24(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy24 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c24() ) );} }
[numthreads(25, 1, 1)]
void CS_c25(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy25 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c25() ) );} }
[numthreads(26, 1, 1)]
void CS_c26(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy26 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c26() ) );} }
[numthreads(27, 1, 1)]
void CS_c27(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy27 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c27() ) );} }
[numthreads(28, 1, 1)]
void CS_c28(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy28 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c28() ) );} }
[numthreads(29, 1, 1)]
void CS_c29(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy29 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c29() ) );} }
[numthreads(30, 1, 1)]
void CS_c30(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy30 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c30() ) );} }
[numthreads(31, 1, 1)]
void CS_c31(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy31 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c31() ) );} }
[numthreads(32, 1, 1)]
void CS_c32(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy32 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c32() ) );} }
[numthreads(33, 1, 1)]
void CS_c33(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy33 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c33() ) );} }
[numthreads(34, 1, 1)]
void CS_c34(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy34 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c34() ) );} }
[numthreads(35, 1, 1)]
void CS_c35(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy35 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c35() ) );} }
[numthreads(36, 1, 1)]
void CS_c36(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy36 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c36() ) );} }
[numthreads(37, 1, 1)]
void CS_c37(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy37 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c37() ) );} }
[numthreads(38, 1, 1)]
void CS_c38(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy38 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c38() ) );} }
[numthreads(39, 1, 1)]
void CS_c39(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy39 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c39() ) );} }
[numthreads(40, 1, 1)]
void CS_c40(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy40 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c40() ) );} }
[numthreads(41, 1, 1)]
void CS_c41(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy41 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c41() ) );} }
[numthreads(42, 1, 1)]
void CS_c42(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy42 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c42() ) );} }
[numthreads(43, 1, 1)]
void CS_c43(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy43 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c43() ) );} }
[numthreads(44, 1, 1)]
void CS_c44(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy44 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c44() ) );} }
[numthreads(45, 1, 1)]
void CS_c45(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy45 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c45() ) );} }
[numthreads(46, 1, 1)]
void CS_c46(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy46 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c46() ) );} }
[numthreads(47, 1, 1)]
void CS_c47(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy47 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c47() ) );} }
[numthreads(48, 1, 1)]
void CS_c48(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy48 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c48() ) );} }
[numthreads(49, 1, 1)]
void CS_c49(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy49 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c49() ) );} }
[numthreads(50, 1, 1)]
void CS_c50(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy50 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c50() ) );} }
[numthreads(51, 1, 1)]
void CS_c51(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy51 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c51() ) );} }
[numthreads(52, 1, 1)]
void CS_c52(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy52 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c52() ) );} }
[numthreads(53, 1, 1)]
void CS_c53(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy53 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c53() ) );} }
[numthreads(54, 1, 1)]
void CS_c54(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy54 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c54() ) );} }
[numthreads(55, 1, 1)]
void CS_c55(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy55 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c55() ) );} }
[numthreads(56, 1, 1)]
void CS_c56(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy56 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c56() ) );} }
[numthreads(57, 1, 1)]
void CS_c57(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy57 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c57() ) );} }
[numthreads(58, 1, 1)]
void CS_c58(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy58 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c58() ) );} }
[numthreads(59, 1, 1)]
void CS_c59(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy59 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c59() ) );} }
[numthreads(60, 1, 1)]
void CS_c60(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy60 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c60() ) );} }
[numthreads(61, 1, 1)]
void CS_c61(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy61 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c61() ) );} }
[numthreads(62, 1, 1)]
void CS_c62(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy62 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c62() ) );} }
[numthreads(63, 1, 1)]
void CS_c63(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy63 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c63() ) );} }
[numthreads(64, 1, 1)]
void CS_c64(csin input) { uint ii=input.DTID.x; BOutput[ii] = BInput[ii]; }
technique11 Copy64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c64() ) );} }