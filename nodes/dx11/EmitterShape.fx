#define PI 3.14159265359
#include "../../../mp.fxh/pows.fxh"
#include "../../../mp.fxh/mcpsWrite.fxh"
#include "../../../mp.fxh/CSThreadDefines.fxh"

//define DO_ADDITIONAL

RWByteAddressBuffer Outbuf : BACKBUFFER;

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

cbuffer cbuf
{
    float4x4 tW : WORLD;
    float2 Param = 1;
    float RandomSeed = 17;
    uint EmitterID = 0;
    uint emitcount = 100;
}

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
	return sin((c+x.x*2+RandomSeed) * 0.1334)*0.5 + 0.5;
}
struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(XTHREADS, YTHREADS, ZTHREADS)]
void CSMain(csin input)
{
	if(input.DTID.x > emitcount) return;

	uint ii = input.DTID.x + WorldEmitOffset + EmitOffset[EmitterID];
	uint pii = input.DTID.x;
	mcpsAgeStore(Outbuf, ii, 0);

	float ndrive = pii * 0.13563;
	float3 inpos = dnoise(ndrive.xx, RandomSeed);
	float3 outpos = mul(float4(SelectedShape.Shape(inpos, Param),1),tW).xyz;

	mcpsPositionStore(Outbuf, ii, outpos);
	mcpsVelocityStore(Outbuf, ii, float4(0,0,0,1));
}
technique11 csmain { pass P0{SetComputeShader( CompileShader( cs_5_0, CSMain() ) );} }
