#include "DistanceFieldHelper.fxh"

Texture3D<float> TInput;
RWTexture3D<float> BOutput : BACKBUFFER;
float4 Operation = 0;
float3 InvVolumeSize : INVTARGETSIZE;
float Multiplier = 1; 


SamplerState s0
{
	Filter=MIN_MAG_MIP_LINEAR;
	AddressU=CLAMP;
	AddressV=CLAMP;
	AddressW=CLAMP;
};
struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};
float blend(float a, float b, float s, float mass)
{
	float res = b;
	if(floor(s)==1) res = U(a,b);
	if(floor(s)==2) res = S(a,b);
	if(floor(s)==3) res = I(a,b);
	if(floor(s)==4) res = sU(a,b,mass);
	if(floor(s)==5) res = sS(a,b,mass/4);
	if(floor(s)==6) res = sI(a,b,mass/4);
	if(floor(s)==7) res = a;
	return res;
}
[numthreads(8, 8, 8)]
void CS_c1(csin input)
{
	uint3 ti=input.DTID;
	float3 uvw = ti*InvVolumeSize;
	float2 ss = Operation.xy;
	float m = max(Operation.w,0.0001);
	
	float pd = BOutput[ti];
	float rd = TInput.SampleLevel(s0,uvw,0).r*Multiplier;
	
	float da = blend(pd,rd,ss.x,m);
	float db = blend(pd,rd,ss.y,m);
	BOutput[ti] = lerp(da,db,Operation.z);
}
technique11 Copy1 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c1() ) );} }