//@author: vux
//@help: standard constant shader
//@tags: color
//@credits: 

StructuredBuffer<float3> sbPosition;

Texture3D volumeDistance;

SamplerState linearSampler : IMMUTABLE
{
    Filter = MIN_MAG_MIP_LINEAR;
    AddressU = Clamp;
    AddressV = Clamp;
	AddressW = Clamp;
};

float sizescale = 1.0f;

cbuffer cbPerDraw : register( b0 )
{
	float4x4 tV : VIEW;
	float4x4 tW : WORLD;
	float4x4 tVP : VIEWPROJECTION;
};


struct vsInput
{
	float4 pos : POSITION;
	float3 norm : NORMAL;
	uint ii : SV_InstanceID;
};

struct psInput
{
    float4 pos: SV_POSITION;	
	float3 norm : TEXCOORD0;
	float4 col : COLOR0;
};

psInput VS(vsInput input)
{
    psInput output;
	
	float3 posw = sbPosition[input.ii];
	
	float4 p = input.pos;
	
	//Go into sdf space
	float3 pv = posw + 0.5f;
	
	//Get distance at position
	float4 volcol = volumeDistance.SampleLevel(linearSampler,pv,0);
	float d = volcol.w;
	output.col = volcol;
	
	//Scale cube depending on distance
	p.xyz *= -(abs(1.0-d) * sizescale);
	
	//Reject voxel outside of surface
	p.xyz *= d;
	
	p.xyz += posw;
	p = mul(float4(p.xyz,1),tW);
    output.pos  = mul(p,tVP);
	output.norm = mul(float4(input.norm,0.0f),tV).xyz;
    return output;
}

float4 PS_Tex(psInput input): SV_Target
{
	//float3 col = normalize(input.norm);
	float3 col = input.col.xyz;
	col = col * 0.5f + 0.5f; //Friendly normals
	
    return float4(col,1);
}





technique10 Constant
{
	pass P0
	{
		SetVertexShader( CompileShader( vs_4_0, VS() ) );
		SetPixelShader( CompileShader( ps_4_0, PS_Tex() ) );
	}
}




