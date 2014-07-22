
#include "mups.fxh"
#include "DistanceFieldHelper.fxh"
#include "DistanceFieldPrimitiveSelector.fxh"

RWStructuredBuffer<float> Outbuf : BACKBUFFER;
StructuredBuffer<float4> OperationMass;
// Operation A
// Operation B
/*
	0 := replace
	1 := union
	2 := difference
	3 := intersect
	4 := smooth union
	5 := smooth difference
	6 := smooth intersect
	7 := bypass
*/
// blend A -> B
// Mass
StructuredBuffer<float4x4> InvTransform;
int DistanceAddress = 17;
float SurfaceNormalCalcWidth = 0.1;
float IsoSurface = 0;
float Strength = 1;
float Power = 1;

uint mups_distance(uint i) {return i*pelsize+DistanceAddress;}

float dfiter(float initd, float3 p, uint3 i)
{
	float pd = initd;
	float rd = iprim.Primitive(p, i.x%i.y);
	float2 ss = OperationMass[i.x%i.z].xy;
	float m = max(OperationMass[i.x%i.z].w,0.0001);
	float da = blend(pd,rd,ss.x,m);
	
	if(floor(ss.x) != floor(ss.y))
	{
		float db = blend(pd,rd,ss.y,m);
		return lerp(da,db,OperationMass[i.x%i.z].z);
	}
	else return da;
}
class cDF : DFInterface
{
	float df(float initd, float3 p, uint4 i)
	{
		
		float cd = initd;
		uint maxc = i.x;
		if(maxc > 0)
		{
			uint tc = i.y;
			float3 pp = 0;
			
			for(uint j=0; j<maxc; j++)
			{
				pp = mul(float4(p,1),InvTransform[j%tc]).xyz;
				cd = dfiter(cd, pp, uint3(j, i.z, i.w));
			}
		}
		return cd;
	}
};
cDF iDF;
DFInterface DF = iDF;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

void main(csin input)
{
	uint pc, oc, tc, str;
	Prop.GetDimensions(pc,str);
	InvTransform.GetDimensions(tc,str);
	OperationMass.GetDimensions(oc,str);
	pc /= iprim.PropSize();
	uint maxc = max(pc,max(oc,tc));
	
	uint ii=input.DTID.x;
	
	float3 pos = 0;
	uint3 pi = mups_position(ii);
	[unroll]
	for(uint i=0; i<3; i++)
		pos[i] = Outbuf[pi[i]];
	
	uint di = mups_distance(ii);
	float initd = Outbuf[di];
	
	float3 dir = CalcNorm(initd, pos, uint4(maxc, tc, pc, oc), SurfaceNormalCalcWidth, DF);
	float ad = DF.df(initd, pos, uint4(maxc, tc, pc, oc));
	Outbuf[di] = ad;
	
	float r = IsoSurface;
	float s = Strength;
	float p = (Power == 0) ? 1 : Power;
	if(ad < r)
	{
		float attr = pows(ad/IsoSurface, p) * -s;
		float3 force = dir*attr;
		
		uint3 fi = mups_force(ii);
		
		[unroll]
		for(uint i=0; i<3; i++) Outbuf[fi[i]] += force[i];
	}
}

[numthreads(1, 1, 1)]
void CS_mups1(csin input) { main(input); }
technique11 mups1 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups1() ) );} }
[numthreads(2, 1, 1)]
void CS_mups2(csin input) { main(input); }
technique11 mups2 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups2() ) );} }
[numthreads(3, 1, 1)]
void CS_mups3(csin input) { main(input); }
technique11 mups3 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups3() ) );} }
[numthreads(4, 1, 1)]
void CS_mups4(csin input) { main(input); }
technique11 mups4 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups4() ) );} }
[numthreads(5, 1, 1)]
void CS_mups5(csin input) { main(input); }
technique11 mups5 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups5() ) );} }
[numthreads(6, 1, 1)]
void CS_mups6(csin input) { main(input); }
technique11 mups6 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups6() ) );} }
[numthreads(7, 1, 1)]
void CS_mups7(csin input) { main(input); }
technique11 mups7 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups7() ) );} }
[numthreads(8, 1, 1)]
void CS_mups8(csin input) { main(input); }
technique11 mups8 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups8() ) );} }
[numthreads(9, 1, 1)]
void CS_mups9(csin input) { main(input); }
technique11 mups9 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups9() ) );} }
[numthreads(10, 1, 1)]
void CS_mups10(csin input) { main(input); }
technique11 mups10 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups10() ) );} }
[numthreads(11, 1, 1)]
void CS_mups11(csin input) { main(input); }
technique11 mups11 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups11() ) );} }
[numthreads(12, 1, 1)]
void CS_mups12(csin input) { main(input); }
technique11 mups12 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups12() ) );} }
[numthreads(13, 1, 1)]
void CS_mups13(csin input) { main(input); }
technique11 mups13 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups13() ) );} }
[numthreads(14, 1, 1)]
void CS_mups14(csin input) { main(input); }
technique11 mups14 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups14() ) );} }
[numthreads(15, 1, 1)]
void CS_mups15(csin input) { main(input); }
technique11 mups15 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups15() ) );} }
[numthreads(16, 1, 1)]
void CS_mups16(csin input) { main(input); }
technique11 mups16 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups16() ) );} }
[numthreads(17, 1, 1)]
void CS_mups17(csin input) { main(input); }
technique11 mups17 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups17() ) );} }
[numthreads(18, 1, 1)]
void CS_mups18(csin input) { main(input); }
technique11 mups18 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups18() ) );} }
[numthreads(19, 1, 1)]
void CS_mups19(csin input) { main(input); }
technique11 mups19 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups19() ) );} }
[numthreads(20, 1, 1)]
void CS_mups20(csin input) { main(input); }
technique11 mups20 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups20() ) );} }
[numthreads(21, 1, 1)]
void CS_mups21(csin input) { main(input); }
technique11 mups21 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups21() ) );} }
[numthreads(22, 1, 1)]
void CS_mups22(csin input) { main(input); }
technique11 mups22 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups22() ) );} }
[numthreads(23, 1, 1)]
void CS_mups23(csin input) { main(input); }
technique11 mups23 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups23() ) );} }
[numthreads(24, 1, 1)]
void CS_mups24(csin input) { main(input); }
technique11 mups24 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups24() ) );} }
[numthreads(25, 1, 1)]
void CS_mups25(csin input) { main(input); }
technique11 mups25 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups25() ) );} }
[numthreads(26, 1, 1)]
void CS_mups26(csin input) { main(input); }
technique11 mups26 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups26() ) );} }
[numthreads(27, 1, 1)]
void CS_mups27(csin input) { main(input); }
technique11 mups27 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups27() ) );} }
[numthreads(28, 1, 1)]
void CS_mups28(csin input) { main(input); }
technique11 mups28 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups28() ) );} }
[numthreads(29, 1, 1)]
void CS_mups29(csin input) { main(input); }
technique11 mups29 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups29() ) );} }
[numthreads(30, 1, 1)]
void CS_mups30(csin input) { main(input); }
technique11 mups30 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups30() ) );} }
[numthreads(31, 1, 1)]
void CS_mups31(csin input) { main(input); }
technique11 mups31 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups31() ) );} }
[numthreads(32, 1, 1)]
void CS_mups32(csin input) { main(input); }
technique11 mups32 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups32() ) );} }
[numthreads(33, 1, 1)]
void CS_mups33(csin input) { main(input); }
technique11 mups33 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups33() ) );} }
[numthreads(34, 1, 1)]
void CS_mups34(csin input) { main(input); }
technique11 mups34 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups34() ) );} }
[numthreads(35, 1, 1)]
void CS_mups35(csin input) { main(input); }
technique11 mups35 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups35() ) );} }
[numthreads(36, 1, 1)]
void CS_mups36(csin input) { main(input); }
technique11 mups36 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups36() ) );} }
[numthreads(37, 1, 1)]
void CS_mups37(csin input) { main(input); }
technique11 mups37 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups37() ) );} }
[numthreads(38, 1, 1)]
void CS_mups38(csin input) { main(input); }
technique11 mups38 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups38() ) );} }
[numthreads(39, 1, 1)]
void CS_mups39(csin input) { main(input); }
technique11 mups39 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups39() ) );} }
[numthreads(40, 1, 1)]
void CS_mups40(csin input) { main(input); }
technique11 mups40 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups40() ) );} }
[numthreads(41, 1, 1)]
void CS_mups41(csin input) { main(input); }
technique11 mups41 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups41() ) );} }
[numthreads(42, 1, 1)]
void CS_mups42(csin input) { main(input); }
technique11 mups42 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups42() ) );} }
[numthreads(43, 1, 1)]
void CS_mups43(csin input) { main(input); }
technique11 mups43 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups43() ) );} }
[numthreads(44, 1, 1)]
void CS_mups44(csin input) { main(input); }
technique11 mups44 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups44() ) );} }
[numthreads(45, 1, 1)]
void CS_mups45(csin input) { main(input); }
technique11 mups45 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups45() ) );} }
[numthreads(46, 1, 1)]
void CS_mups46(csin input) { main(input); }
technique11 mups46 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups46() ) );} }
[numthreads(47, 1, 1)]
void CS_mups47(csin input) { main(input); }
technique11 mups47 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups47() ) );} }
[numthreads(48, 1, 1)]
void CS_mups48(csin input) { main(input); }
technique11 mups48 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups48() ) );} }
[numthreads(49, 1, 1)]
void CS_mups49(csin input) { main(input); }
technique11 mups49 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups49() ) );} }
[numthreads(50, 1, 1)]
void CS_mups50(csin input) { main(input); }
technique11 mups50 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups50() ) );} }
[numthreads(51, 1, 1)]
void CS_mups51(csin input) { main(input); }
technique11 mups51 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups51() ) );} }
[numthreads(52, 1, 1)]
void CS_mups52(csin input) { main(input); }
technique11 mups52 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups52() ) );} }
[numthreads(53, 1, 1)]
void CS_mups53(csin input) { main(input); }
technique11 mups53 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups53() ) );} }
[numthreads(54, 1, 1)]
void CS_mups54(csin input) { main(input); }
technique11 mups54 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups54() ) );} }
[numthreads(55, 1, 1)]
void CS_mups55(csin input) { main(input); }
technique11 mups55 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups55() ) );} }
[numthreads(56, 1, 1)]
void CS_mups56(csin input) { main(input); }
technique11 mups56 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups56() ) );} }
[numthreads(57, 1, 1)]
void CS_mups57(csin input) { main(input); }
technique11 mups57 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups57() ) );} }
[numthreads(58, 1, 1)]
void CS_mups58(csin input) { main(input); }
technique11 mups58 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups58() ) );} }
[numthreads(59, 1, 1)]
void CS_mups59(csin input) { main(input); }
technique11 mups59 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups59() ) );} }
[numthreads(60, 1, 1)]
void CS_mups60(csin input) { main(input); }
technique11 mups60 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups60() ) );} }
[numthreads(61, 1, 1)]
void CS_mups61(csin input) { main(input); }
technique11 mups61 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups61() ) );} }
[numthreads(62, 1, 1)]
void CS_mups62(csin input) { main(input); }
technique11 mups62 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups62() ) );} }
[numthreads(63, 1, 1)]
void CS_mups63(csin input) { main(input); }
technique11 mups63 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups63() ) );} }
[numthreads(64, 1, 1)]
void CS_mups64(csin input) { main(input); }
technique11 mups64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups64() ) );} }