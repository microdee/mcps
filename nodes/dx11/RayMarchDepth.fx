//@author: microdee
//@help: raymarcher in vvvv's space
//@credits: 
#define PI 3.14159265359
#include "DistanceFieldHelper.fxh"
#include "DistanceFieldPrimitiveSelector.fxh"

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

StructuredBuffer<uint> PrimitiveSelect;
StructuredBuffer<uint> PropAddress;
StructuredBuffer<float4x4> InvTransform;

SamplerState g_samLinear : IMMUTABLE
{
    Filter = MIN_MAG_MIP_LINEAR;
    AddressU = Clamp;
    AddressV = Clamp;
};

 
cbuffer cbPerDraw : register( b0 )
{
	float4x4 tPI : PROJECTIONINVERSE;
	float4x4 tVI : VIEWINVERSE;
	float4x4 tVP : VIEWPROJECTION;
	float2 rez : TARGETSIZE;
	float MaxIteration = 200;
	float MaxDist = 100;
	float Epsilon = 0.1;
	float FOV = 0.25;
	bool AspectRatio = true;
};


float dfiter(float initd, float3 p, uint SPrim, uint SOp, uint PropA)
{
	float pd = initd;
	float rd = Primitive(p, SPrim, PropA);
	float2 ss = OperationMass[SOp].xy;
	float m = max(OperationMass[SOp].w,0.0001);
	float da = blend(pd,rd,ss.x,m);
	
	if(floor(ss.x) != floor(ss.y))
	{
		float db = blend(pd,rd,ss.y,m);
		return lerp(da,db,OperationMass[SOp].z);
	}
	else return da;
}
float df(float initd, float3 p, uint maxc, uint tc, uint SPrimC, uint PAddrC, uint SOpC)
{
	
	float cd = initd;
	if(maxc > 0)
	{
		float3 pp = 0;
		
		for(uint i=0; i<maxc; i++)
		{
			pp = mul(float4(p,1),InvTransform[i%tc]).xyz;
			cd = dfiter(cd, pp, PrimitiveSelect[i%SPrimC], i%SOpC, PropAddress[i%PAddrC]);
		}
	}
	return cd;
}

struct VS_IN
{
	float4 PosO : POSITION;

};

struct vs2ps
{
    float4 PosWVP: SV_POSITION;
	float3 raystart : RS;
	float3 raydir : RD;
	uint4 bufsize : BS;
	uint maxbufsize : MBS;
};

vs2ps VS(VS_IN input)
{
    vs2ps Out = (vs2ps)0;
	
	uint primc, propc, oc, tc, str;
	PrimitiveSelect.GetDimensions(primc,str);
	PropAddress.GetDimensions(propc,str);
	OperationMass.GetDimensions(oc,str);
	InvTransform.GetDimensions(tc,str);
	
	Out.bufsize.x = primc;
	Out.bufsize.y = propc;
	Out.bufsize.z = oc;
	Out.bufsize.w = tc;
	Out.maxbufsize = max(max(max(primc,propc),oc),tc);
	
	float4x4 tt = mul(tPI,tVI);
	float4 bpos = float4(0,0,0,1);
	bpos = mul(bpos, tVI);
	
	float2 asp = 1;
	if(AspectRatio)
	{
		if(rez.x>rez.y) asp.x = rez.x/rez.y;
		if(rez.y>rez.x) asp.y = rez.y/rez.x;
	}
	float2 spread = tan(FOV*PI)*2 * asp;
	float4 fpos = float4(input.PosO.xy*spread,1,1);
	fpos = mul(fpos, tVI);
	
	Out.raystart = bpos.xyz;
	Out.raydir = normalize(fpos.xyz-bpos.xyz);
	
    Out.PosWVP  = float4(input.PosO.xy*2,input.PosO.zw);
    return Out;
}



struct PSOut
{
	float4 Pos : SV_Target;
	float Depth : SV_Depth;
};

PSOut PS(vs2ps In)
{
	float decrd = MaxDist;
	float currd = MaxDist;
	float3 currpos = In.raystart;
	uint ii = 0;
	
	for(uint i=0; (i<MaxIteration) && (currd > Epsilon) && (decrd > Epsilon); i++)
	{
		currd = df(MaxDist, currpos, In.maxbufsize, In.bufsize.w, In.bufsize.x, In.bufsize.y, In.bufsize.z);
		currpos += In.raydir * currd;
		decrd -= currd;
		ii=i;
	}
	if((decrd < Epsilon)) discard;
	
	PSOut o = (PSOut)0;
	o.Pos.rgb = currpos;
	o.Pos.a = 1;
	float4 ppos = mul(float4(currpos,1),tVP);
	o.Depth = ppos.z / ppos.w;
	return o;
}

technique11 Constant
{
	pass P0
	{
		SetVertexShader( CompileShader( vs_5_0, VS() ) );
		SetPixelShader( CompileShader( ps_5_0, PS() ) );
	}
}




