#include "mups.fxh"
#include "quaternion.fxh"
#define MINTWOPI -6.283185307179586476925286766559
#define TWOPI 6.283185307179586476925286766559

RWStructuredBuffer<float> Outbuf : BACKBUFFER;
float Freqs[22] : IMMUTABLE = {17,13,9,23,33,43,5,6,7,93,73,53,43,33,23,53,93,73,13,1,17,8};
float Amps[5] : IMMUTABLE = {5,5,9,7,2};
float4x4 FieldTr;
float Distort = 0;
float Saturation = 0;
float Rot = 0;
float Slerp = 0;

uint4 mups_Rotation(uint i) {return uint4(i*pelsize+17,i*pelsize+18,i*pelsize+19,i*pelsize+20);}

float3 lungth(float3 x,float3 c){
       return float3(length(x+c.r),length(x+c.g),length(x+c.b));
}
float3 distort(float3 inpos, float4x4 Transform, float saturation, float freq[22], float amp[5])
{
    float3 c=0;
    float3 x=mul(float4(inpos,1),Transform).xyz;
    x+=sin(x.zyx*sqrt(float3(freq[0],freq[1],freq[2])))/amp[0];
    c=lungth(sin(x*sqrt(float3(freq[3],freq[4],freq[5]))),float3(freq[6],freq[7],freq[8])*saturation);
    x+=sin(x.zyx*sqrt(float3(freq[9],freq[10],freq[11])))/amp[1];
    c=2*lungth(sin(x*sqrt(float3(freq[12],freq[13],freq[14]))),c/amp[2]);
    x+=sin(x.zyx*sqrt(float3(freq[15],freq[16],freq[17])))/amp[3];
    c=lungth(sin(x*sqrt(float3(freq[18],freq[19],freq[20]))),c/amp[4]);
    c=sin(c*freq[21]);
    return normalize(c);
}
struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

void main(csin input)
{
	if(input.DTID.x > pcount) return;
	uint ii=input.DTID.x;
	
	float3 pos = 0;
	uint3 pi = mups_position(ii);
	
	[unroll]
	for(uint i=0; i<3; i++)
		pos[i] = Outbuf[pi[i]];
	
	uint3 fi = mups_force(ii);
	
	float3 force = distort(pos, FieldTr, Saturation, Freqs, Amps);
	
	uint4 ri = mups_Rotation(ii);
	float4 rotate = normalize(aa2q(normalize(force), Rot));
	float4 orot = float4(0,0,0,1);
	
	[unroll]
	for(uint i=0; i<4; i++) orot[i] = Outbuf[ri[i]];
	
	float4 rot = qmul(orot,rotate);
	
	[unroll]
	for(uint i=0; i<4; i++) Outbuf[ri[i]] = rot[i];
	
	force *= Distort;
	
	[unroll]
	for(uint i=0; i<3; i++) Outbuf[fi[i]] += force[i];
	
}

[numthreads(64, 1, 1)]
void CS_mups64(csin input) { main(input); }
technique11 mups64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_mups64() ) );} }