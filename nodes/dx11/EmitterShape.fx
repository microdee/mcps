#define PI 3.14159265359
RWStructuredBuffer<float> Outbuf : BACKBUFFER;
#include "mups.fxh"
interface iShape{
	float3 Shape(float3 p, float2 param);
};
class iSphere : iShape{
	float3 Shape(float3 p, float2 param)
	{
		float3 res;
		res.x = p.x*sin(p.y*PI*2)*cos(p.z*PI*2);
		res.y = p.x*sin(p.y*PI*2)*sin(p.z*PI*2);
		res.z = p.x*cos(p.y*PI*2);
		return res;
	}
};
class iCylinder : iShape{
	float3 Shape(float3 p, float2 param)
	{
		float3 res;
		res.y = saturate(p.y);
		float rad = lerp(param.x, param.y, res.y);
		res.x = sin(p.x*PI*2)*p.z*rad;
		res.z = cos(p.x*PI*2)*p.z*rad;
		res.y -= .5;
		res.y *= 2;
		return res;
	}
};
class iBox : iShape{
	float3 Shape(float3 p, float2 param)
	{
		return (p-.5)*2;
	}
};
class iTorus : iShape{
	float3 Shape(float3 p, float2 param)
	{
		float3 res;
		res.x = (param.x + param.y * p.x * cos(p.z*PI*2)) * cos(p.y*PI*2);
		res.y = (param.x + param.y * p.x * cos(p.z*PI*2)) * sin(p.y*PI*2);
		res.z = param.y * p.x*sin(p.z*PI*2);
		return res;
	}
};
iSphere Sphere;
iCylinder Cylinder;
iBox Box;
iTorus Torus;

iShape SelectedShape <string uiname="Primitive";string linkclass="Sphere,Cylinder,Box,Torus";> = Sphere;
float4x4 tW : WORLD;
float2 Param = 1;
float RandomSeed = 17;

StructuredBuffer<float> Source;
StructuredBuffer<uint> Destination;
bool ResetColor = false;
float4 Color <bool color=true;> = 1;
bool ResetSize = false;
float Size = 1;
int EmitterID = 0;
float emitcount = 100;

float _dnoise1(float3 u){
	u=dot(u+.2,float3(1,57,21));
	return (u.x*(.1+sin(u.x)));
}
float3 dnoise(float2 x,float randomseed){
	randomseed+=.00001;
	float3 c={
	_dnoise1(float3((x+randomseed*13+41)+11,length(sin((x-59)/151+randomseed*float2(11,7))))+.5),
	_dnoise1(float3((x+randomseed*7+293)+5,length(sin((x+127)/163+randomseed*float2(13,5))))+.5),
	_dnoise1(float3((x+randomseed*5+113)+7,length(sin((x+191)/173+randomseed*float2(7,17))))+.5)
	};
	return frac(c+x.x*2+RandomSeed);
}
struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(64, 1, 1)]
void CS_Emit64(csin input)
{
	if(input.DTID.x > emitcount) return;
	/*
	uint PCount, VCount, Str;
	Position.GetDimensions(PCount, Str);
	Velocity.GetDimensions(VCount, Str);
	*/
	uint DstC, Str;
	Destination.GetDimensions(DstC, Str);
	
	uint ii = input.DTID.x + EmitCounter + EmitCountOffs[EmitterID];
	uint pii = input.DTID.x;
	uint dii = input.DTID.y;
	uint2 ai = mups_age(ii);
	Outbuf[ai.x] = 0;
	Outbuf[ai.y] = 0;
	if(dii==0)
	{
		float ndrive = pii * 0.13563;
		float3 inpos = dnoise(ndrive.xx, RandomSeed);
		float3 outpos = mul(float4(SelectedShape.Shape(inpos, Param),1),tW).xyz;
		
		uint3 pi = mups_position(ii);
		for(uint i=0; i<3; i++) Outbuf[pi[i]] = outpos[i];
		
		if(ResetColor)
		{
			uint4 ci = mups_color(ii);
			for(uint i=0; i<4; i++) Outbuf[ci[i]] = Color[i];
		}
		uint4 ci = mups_velocity(ii);
		for(uint i=0; i<3; i++) Outbuf[ci[i]] = 0;
		Outbuf[ci.w] = 1;
		
		if(ResetSize)
			Outbuf[mups_size(ii)] = Size;
	}
	if(DstC!=0)
	{
		uint sii = pii*DstC+dii;
		Outbuf[ii*pelsize + Destination[dii]] = Source[sii];
	}
}
technique11 Emit64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_Emit64() ) );} }