//@author: vux
//@help: standard constant shader
//@tags: color
//@credits:

StructuredBuffer<float> BInput1;
StructuredBuffer<float> BInput2;
RWStructuredBuffer<float> BOutput : BACKBUFFER;
bool sel = false;
struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(1, 1, 1)]
void CS_m1(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge1 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m1() ) );} }
[numthreads(2, 1, 1)]
void CS_m2(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge2 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m2() ) );} }
[numthreads(3, 1, 1)]
void CS_m3(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge3 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m3() ) );} }
[numthreads(4, 1, 1)]
void CS_m4(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge4 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m4() ) );} }
[numthreads(5, 1, 1)]
void CS_m5(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge5 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m5() ) );} }
[numthreads(6, 1, 1)]
void CS_m6(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge6 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m6() ) );} }
[numthreads(7, 1, 1)]
void CS_m7(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge7 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m7() ) );} }
[numthreads(8, 1, 1)]
void CS_m8(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge8 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m8() ) );} }
[numthreads(9, 1, 1)]
void CS_m9(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge9 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m9() ) );} }
[numthreads(10, 1, 1)]
void CS_m10(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge10 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m10() ) );} }
[numthreads(11, 1, 1)]
void CS_m11(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge11 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m11() ) );} }
[numthreads(12, 1, 1)]
void CS_m12(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge12 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m12() ) );} }
[numthreads(13, 1, 1)]
void CS_m13(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge13 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m13() ) );} }
[numthreads(14, 1, 1)]
void CS_m14(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge14 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m14() ) );} }
[numthreads(15, 1, 1)]
void CS_m15(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge15 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m15() ) );} }
[numthreads(16, 1, 1)]
void CS_m16(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge16 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m16() ) );} }
[numthreads(17, 1, 1)]
void CS_m17(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge17 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m17() ) );} }
[numthreads(18, 1, 1)]
void CS_m18(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge18 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m18() ) );} }
[numthreads(19, 1, 1)]
void CS_m19(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge19 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m19() ) );} }
[numthreads(20, 1, 1)]
void CS_m20(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge20 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m20() ) );} }
[numthreads(21, 1, 1)]
void CS_m21(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge21 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m21() ) );} }
[numthreads(22, 1, 1)]
void CS_m22(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge22 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m22() ) );} }
[numthreads(23, 1, 1)]
void CS_m23(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge23 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m23() ) );} }
[numthreads(24, 1, 1)]
void CS_m24(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge24 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m24() ) );} }
[numthreads(25, 1, 1)]
void CS_m25(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge25 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m25() ) );} }
[numthreads(26, 1, 1)]
void CS_m26(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge26 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m26() ) );} }
[numthreads(27, 1, 1)]
void CS_m27(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge27 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m27() ) );} }
[numthreads(28, 1, 1)]
void CS_m28(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge28 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m28() ) );} }
[numthreads(29, 1, 1)]
void CS_m29(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge29 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m29() ) );} }
[numthreads(30, 1, 1)]
void CS_m30(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge30 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m30() ) );} }
[numthreads(31, 1, 1)]
void CS_m31(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge31 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m31() ) );} }
[numthreads(32, 1, 1)]
void CS_m32(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge32 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m32() ) );} }
[numthreads(33, 1, 1)]
void CS_m33(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge33 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m33() ) );} }
[numthreads(34, 1, 1)]
void CS_m34(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge34 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m34() ) );} }
[numthreads(35, 1, 1)]
void CS_m35(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge35 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m35() ) );} }
[numthreads(36, 1, 1)]
void CS_m36(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge36 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m36() ) );} }
[numthreads(37, 1, 1)]
void CS_m37(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge37 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m37() ) );} }
[numthreads(38, 1, 1)]
void CS_m38(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge38 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m38() ) );} }
[numthreads(39, 1, 1)]
void CS_m39(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge39 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m39() ) );} }
[numthreads(40, 1, 1)]
void CS_m40(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge40 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m40() ) );} }
[numthreads(41, 1, 1)]
void CS_m41(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge41 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m41() ) );} }
[numthreads(42, 1, 1)]
void CS_m42(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge42 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m42() ) );} }
[numthreads(43, 1, 1)]
void CS_m43(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge43 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m43() ) );} }
[numthreads(44, 1, 1)]
void CS_m44(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge44 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m44() ) );} }
[numthreads(45, 1, 1)]
void CS_m45(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge45 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m45() ) );} }
[numthreads(46, 1, 1)]
void CS_m46(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge46 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m46() ) );} }
[numthreads(47, 1, 1)]
void CS_m47(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge47 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m47() ) );} }
[numthreads(48, 1, 1)]
void CS_m48(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge48 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m48() ) );} }
[numthreads(49, 1, 1)]
void CS_m49(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge49 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m49() ) );} }
[numthreads(50, 1, 1)]
void CS_m50(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge50 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m50() ) );} }
[numthreads(51, 1, 1)]
void CS_m51(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge51 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m51() ) );} }
[numthreads(52, 1, 1)]
void CS_m52(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge52 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m52() ) );} }
[numthreads(53, 1, 1)]
void CS_m53(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge53 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m53() ) );} }
[numthreads(54, 1, 1)]
void CS_m54(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge54 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m54() ) );} }
[numthreads(55, 1, 1)]
void CS_m55(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge55 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m55() ) );} }
[numthreads(56, 1, 1)]
void CS_m56(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge56 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m56() ) );} }
[numthreads(57, 1, 1)]
void CS_m57(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge57 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m57() ) );} }
[numthreads(58, 1, 1)]
void CS_m58(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge58 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m58() ) );} }
[numthreads(59, 1, 1)]
void CS_m59(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge59 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m59() ) );} }
[numthreads(60, 1, 1)]
void CS_m60(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge60 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m60() ) );} }
[numthreads(61, 1, 1)]
void CS_m61(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge61 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m61() ) );} }
[numthreads(62, 1, 1)]
void CS_m62(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge62 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m62() ) );} }
[numthreads(63, 1, 1)]
void CS_m63(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge63 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m63() ) );} }
[numthreads(64, 1, 1)]
void CS_m64(csin input){uint ii=input.DTID.x;if(sel){BOutput[ii]=BInput2[ii];}else{BOutput[ii] = BInput2[ii];}}
technique11 Merge64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m64() ) );} }