#include "mups.fxh"

RWStructuredBuffer<float> Outbuf : BACKBUFFER;

float3 gravity = {0,-9.80665,0};
float VelocityDamper = 1;
//float SleepThreshold = 0.5;
bool AddVelocity = true;
bool AddForce = true;
float ResetAllEps = 0.034;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

void main(csin input)
{
	uint ii=input.DTID.x;
	uint2 ai = mups_age(ii);
	Outbuf[ai.x]++;
	Outbuf[ai.y] += Time.y;
	//bool sleep = Outbuf[mups_sleep(ii)] > SleepThreshold;
	
	if(AddVelocity)
	{
		uint4 vi = mups_velocity(ii);
		if(AddForce)
		{
			uint3 fi = mups_force(ii);
			for(uint i=0; i<3; i++)
			{
				Outbuf[fi[i]] += gravity[i];
				
				Outbuf[vi[i]] += Outbuf[fi[i]] * Time.y;
				Outbuf[vi[i]] *= VelocityDamper;
				Outbuf[vi[i]] *= Outbuf[vi.w];
			}
		}
		else
		{
			for(uint i=0; i<3; i++)
			{
				Outbuf[vi[i]] *= VelocityDamper;
				Outbuf[vi[i]] *= Outbuf[vi.w];
			}
		}
		uint3 pi = mups_position(ii);
		for(uint i=0; i<3; i++) Outbuf[pi[i]] += Outbuf[vi[i]] * Time.y;
	}
	if(Time.x < ResetAllEps)
	{
		for(uint i=0; i<pelsize; i++) Outbuf[ii*pelsize+i] = 0;
	}
}

[numthreads(1, 1, 1)]
void CS_Iterate1(csin input) { main(input); }
technique11 Iterate1 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate1() ) );} }
[numthreads(2, 1, 1)]
void CS_Iterate2(csin input) { main(input); }
technique11 Iterate2 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate2() ) );} }
[numthreads(3, 1, 1)]
void CS_Iterate3(csin input) { main(input); }
technique11 Iterate3 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate3() ) );} }
[numthreads(4, 1, 1)]
void CS_Iterate4(csin input) { main(input); }
technique11 Iterate4 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate4() ) );} }
[numthreads(5, 1, 1)]
void CS_Iterate5(csin input) { main(input); }
technique11 Iterate5 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate5() ) );} }
[numthreads(6, 1, 1)]
void CS_Iterate6(csin input) { main(input); }
technique11 Iterate6 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate6() ) );} }
[numthreads(7, 1, 1)]
void CS_Iterate7(csin input) { main(input); }
technique11 Iterate7 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate7() ) );} }
[numthreads(8, 1, 1)]
void CS_Iterate8(csin input) { main(input); }
technique11 Iterate8 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate8() ) );} }
[numthreads(9, 1, 1)]
void CS_Iterate9(csin input) { main(input); }
technique11 Iterate9 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate9() ) );} }
[numthreads(10, 1, 1)]
void CS_Iterate10(csin input) { main(input); }
technique11 Iterate10 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate10() ) );} }
[numthreads(11, 1, 1)]
void CS_Iterate11(csin input) { main(input); }
technique11 Iterate11 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate11() ) );} }
[numthreads(12, 1, 1)]
void CS_Iterate12(csin input) { main(input); }
technique11 Iterate12 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate12() ) );} }
[numthreads(13, 1, 1)]
void CS_Iterate13(csin input) { main(input); }
technique11 Iterate13 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate13() ) );} }
[numthreads(14, 1, 1)]
void CS_Iterate14(csin input) { main(input); }
technique11 Iterate14 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate14() ) );} }
[numthreads(15, 1, 1)]
void CS_Iterate15(csin input) { main(input); }
technique11 Iterate15 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate15() ) );} }
[numthreads(16, 1, 1)]
void CS_Iterate16(csin input) { main(input); }
technique11 Iterate16 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate16() ) );} }
[numthreads(17, 1, 1)]
void CS_Iterate17(csin input) { main(input); }
technique11 Iterate17 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate17() ) );} }
[numthreads(18, 1, 1)]
void CS_Iterate18(csin input) { main(input); }
technique11 Iterate18 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate18() ) );} }
[numthreads(19, 1, 1)]
void CS_Iterate19(csin input) { main(input); }
technique11 Iterate19 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate19() ) );} }
[numthreads(20, 1, 1)]
void CS_Iterate20(csin input) { main(input); }
technique11 Iterate20 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate20() ) );} }
[numthreads(21, 1, 1)]
void CS_Iterate21(csin input) { main(input); }
technique11 Iterate21 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate21() ) );} }
[numthreads(22, 1, 1)]
void CS_Iterate22(csin input) { main(input); }
technique11 Iterate22 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate22() ) );} }
[numthreads(23, 1, 1)]
void CS_Iterate23(csin input) { main(input); }
technique11 Iterate23 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate23() ) );} }
[numthreads(24, 1, 1)]
void CS_Iterate24(csin input) { main(input); }
technique11 Iterate24 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate24() ) );} }
[numthreads(25, 1, 1)]
void CS_Iterate25(csin input) { main(input); }
technique11 Iterate25 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate25() ) );} }
[numthreads(26, 1, 1)]
void CS_Iterate26(csin input) { main(input); }
technique11 Iterate26 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate26() ) );} }
[numthreads(27, 1, 1)]
void CS_Iterate27(csin input) { main(input); }
technique11 Iterate27 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate27() ) );} }
[numthreads(28, 1, 1)]
void CS_Iterate28(csin input) { main(input); }
technique11 Iterate28 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate28() ) );} }
[numthreads(29, 1, 1)]
void CS_Iterate29(csin input) { main(input); }
technique11 Iterate29 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate29() ) );} }
[numthreads(30, 1, 1)]
void CS_Iterate30(csin input) { main(input); }
technique11 Iterate30 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate30() ) );} }
[numthreads(31, 1, 1)]
void CS_Iterate31(csin input) { main(input); }
technique11 Iterate31 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate31() ) );} }
[numthreads(32, 1, 1)]
void CS_Iterate32(csin input) { main(input); }
technique11 Iterate32 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate32() ) );} }
[numthreads(33, 1, 1)]
void CS_Iterate33(csin input) { main(input); }
technique11 Iterate33 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate33() ) );} }
[numthreads(34, 1, 1)]
void CS_Iterate34(csin input) { main(input); }
technique11 Iterate34 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate34() ) );} }
[numthreads(35, 1, 1)]
void CS_Iterate35(csin input) { main(input); }
technique11 Iterate35 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate35() ) );} }
[numthreads(36, 1, 1)]
void CS_Iterate36(csin input) { main(input); }
technique11 Iterate36 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate36() ) );} }
[numthreads(37, 1, 1)]
void CS_Iterate37(csin input) { main(input); }
technique11 Iterate37 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate37() ) );} }
[numthreads(38, 1, 1)]
void CS_Iterate38(csin input) { main(input); }
technique11 Iterate38 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate38() ) );} }
[numthreads(39, 1, 1)]
void CS_Iterate39(csin input) { main(input); }
technique11 Iterate39 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate39() ) );} }
[numthreads(40, 1, 1)]
void CS_Iterate40(csin input) { main(input); }
technique11 Iterate40 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate40() ) );} }
[numthreads(41, 1, 1)]
void CS_Iterate41(csin input) { main(input); }
technique11 Iterate41 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate41() ) );} }
[numthreads(42, 1, 1)]
void CS_Iterate42(csin input) { main(input); }
technique11 Iterate42 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate42() ) );} }
[numthreads(43, 1, 1)]
void CS_Iterate43(csin input) { main(input); }
technique11 Iterate43 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate43() ) );} }
[numthreads(44, 1, 1)]
void CS_Iterate44(csin input) { main(input); }
technique11 Iterate44 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate44() ) );} }
[numthreads(45, 1, 1)]
void CS_Iterate45(csin input) { main(input); }
technique11 Iterate45 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate45() ) );} }
[numthreads(46, 1, 1)]
void CS_Iterate46(csin input) { main(input); }
technique11 Iterate46 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate46() ) );} }
[numthreads(47, 1, 1)]
void CS_Iterate47(csin input) { main(input); }
technique11 Iterate47 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate47() ) );} }
[numthreads(48, 1, 1)]
void CS_Iterate48(csin input) { main(input); }
technique11 Iterate48 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate48() ) );} }
[numthreads(49, 1, 1)]
void CS_Iterate49(csin input) { main(input); }
technique11 Iterate49 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate49() ) );} }
[numthreads(50, 1, 1)]
void CS_Iterate50(csin input) { main(input); }
technique11 Iterate50 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate50() ) );} }
[numthreads(51, 1, 1)]
void CS_Iterate51(csin input) { main(input); }
technique11 Iterate51 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate51() ) );} }
[numthreads(52, 1, 1)]
void CS_Iterate52(csin input) { main(input); }
technique11 Iterate52 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate52() ) );} }
[numthreads(53, 1, 1)]
void CS_Iterate53(csin input) { main(input); }
technique11 Iterate53 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate53() ) );} }
[numthreads(54, 1, 1)]
void CS_Iterate54(csin input) { main(input); }
technique11 Iterate54 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate54() ) );} }
[numthreads(55, 1, 1)]
void CS_Iterate55(csin input) { main(input); }
technique11 Iterate55 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate55() ) );} }
[numthreads(56, 1, 1)]
void CS_Iterate56(csin input) { main(input); }
technique11 Iterate56 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate56() ) );} }
[numthreads(57, 1, 1)]
void CS_Iterate57(csin input) { main(input); }
technique11 Iterate57 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate57() ) );} }
[numthreads(58, 1, 1)]
void CS_Iterate58(csin input) { main(input); }
technique11 Iterate58 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate58() ) );} }
[numthreads(59, 1, 1)]
void CS_Iterate59(csin input) { main(input); }
technique11 Iterate59 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate59() ) );} }
[numthreads(60, 1, 1)]
void CS_Iterate60(csin input) { main(input); }
technique11 Iterate60 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate60() ) );} }
[numthreads(61, 1, 1)]
void CS_Iterate61(csin input) { main(input); }
technique11 Iterate61 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate61() ) );} }
[numthreads(62, 1, 1)]
void CS_Iterate62(csin input) { main(input); }
technique11 Iterate62 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate62() ) );} }
[numthreads(63, 1, 1)]
void CS_Iterate63(csin input) { main(input); }
technique11 Iterate63 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate63() ) );} }
[numthreads(64, 1, 1)]
void CS_Iterate64(csin input) { main(input); }
technique11 Iterate64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Iterate64() ) );} }