Texture2D tex <string uiname="Depth Buffer";>;
 
SamplerState s0:IMMUTABLE{Filter=MIN_MAG_MIP_POINT;AddressU=WRAP;AddressV=WRAP;};

cbuffer cbPerDraw : register( b0 )
{
	float4x4 tVP : VIEWPROJECTION;
	float4x4 tP : PROJECTION;
	float4x4 tVI : VIEWINVERSE;
	float4x4 tV : VIEW;
};


struct VS_IN
{
	float4 PosO : POSITION;
	float2 UV : TEXCOORD0;
};

struct VS_OUT
{
    float4 PosWVP: SV_POSITION;
    float2 UV: TEXCOORD0;
};

VS_OUT VS(VS_IN In)
{
    VS_OUT Out = (VS_OUT)0;

    //position (projected)
	Out.PosWVP = In.PosO;//mul(In.PosO,mul(tW,tVP));
    Out.UV = In.UV;
    return Out;
}

float4 PosV(float d,float2 uv){
	float ld = tP._43 / (d - tP._33);
	//if (ld > 200.0f) { return 0; }
	float3 p=float3((uv*2-1)/float2(tP._11,-tP._22)*ld,ld);
	return float4(p.xyz,1);
}
float4 PosW(float d,float2 uv){
	return mul(PosV(d,uv),tVI);
}
float4 PS_POSW(VS_OUT In): SV_Target{
    float d = tex.SampleLevel(s0,In.UV,0).x;
    return PosW(d,In.UV);
}
float4 PS_POSV(VS_OUT In): SV_Target{
    float d = tex.SampleLevel(s0,In.UV,0).x;
    return PosV(d,In.UV);
}
float2 R:TARGETSIZE;
float4 PS_NORW(VS_OUT In): SV_Target{
	float3 w0=PosW(tex.SampleLevel(s0,In.UV,0).x,In.UV).xyz;
	float3 w1=PosW(tex.SampleLevel(s0,In.UV-float2(1,0)/R,0).x,In.UV-float2(1,0)/R).xyz;
	float3 w2=PosW(tex.SampleLevel(s0,In.UV-float2(0,1)/R,0).x,In.UV-float2(0,1)/R).xyz;
	float3 w3=PosW(tex.SampleLevel(s0,In.UV+float2(1,0)/R,0).x,In.UV+float2(1,0)/R).xyz;
	float3 w4=PosW(tex.SampleLevel(s0,In.UV+float2(0,1)/R,0).x,In.UV+float2(0,1)/R).xyz;
	
	float3 c1=normalize(w1-w0);
	float3 c2=normalize(w2-w0);
	
	//c1=lerp(normalize(w1-w0),normalize(w0-w3),length(w1-w0)>length(w3-w0));
	//c2=lerp(normalize(w2-w0),normalize(w0-w4),length(w2-w0)>length(w4-w0));
	
	float3 NorW=normalize(cross(c1,c2));
	return float4(NorW,1);
}
float4 PS_REFL(VS_OUT In): SV_Target{
	float d = tex.SampleLevel(s0,In.UV,0).x;
	
	float3 Eye=normalize(PosW(d,In.UV).xyz-mul(float4(0,0,0,1),tVI).xyz);
	float3 NorW=PS_NORW(In).xyz;
	
	return float4(reflect(Eye,normalize(NorW.xyz)),1.0);
}
technique10 PositionWorld
{
	pass P0
	{
		SetVertexShader( CompileShader( vs_4_0, VS() ) );
		SetPixelShader( CompileShader( ps_4_0, PS_POSW() ) );
	}
}
technique10 PositionView
{
	pass P0
	{
		SetVertexShader( CompileShader( vs_4_0, VS() ) );
		SetPixelShader( CompileShader( ps_4_0, PS_POSV() ) );
	}
}
technique10 NormalWorld
{
	pass P0
	{
		SetVertexShader( CompileShader( vs_4_0, VS() ) );
		SetPixelShader( CompileShader( ps_4_0, PS_NORW() ) );
	}
}
technique10 Reflection
{
	pass P0
	{
		SetVertexShader( CompileShader( vs_4_0, VS() ) );
		SetPixelShader( CompileShader( ps_4_0, PS_REFL() ) );
	}
}

