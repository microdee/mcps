//@author: vux
//@help: standard constant shader
//@tags: color
//@credits: 

float3 iR : INVTARGETSIZE;
StructuredBuffer<float4> Spheres;
StructuredBuffer<float3> Velocity;
float Feather = 1;
float FeatherPow = 1;
float mass = 0.1;
float4x4 tW : WORLD;

struct VS_IN
{
	float4 PosO : POSITION;
	float4 TexCd : TEXCOORD0;
	uint ii : SV_InstanceID;
};

struct vs2gs
{
	float4 Pos : SV_POSITION;
	float2 TexCd : TEXCOORD0;
	nointerpolation uint ii : TEXCOORD1;
};

struct gs2ps
{
	float4 pos : SV_POSITION;
	float2 TexCd : TEXCOORD0;
	uint layer : SV_RenderTargetArrayIndex;
	nointerpolation uint layerPS : TEXCOORD1;
	nointerpolation uint BufferCount : TEXCOORD2;
};

vs2gs VS(VS_IN input)
{
    vs2gs Out = (vs2gs)0;
    Out.Pos = input.PosO*2;
	Out.Pos.w = 1;
    Out.TexCd = input.TexCd;
	Out.ii = input.ii;
    return Out;
}

[maxvertexcount(3)]
void GS(triangle vs2gs input[3], inout TriangleStream<gs2ps> triOutputStream)
{
	gs2ps output;
	output.layer = input[0].ii;
	output.layerPS = input[0].ii;
	
	uint sc, str;
	Spheres.GetDimensions(sc,str);
	output.BufferCount = sc;
	
	for(int i=0; i < 3; ++i)
	{
		output.pos = input[i].Pos;
		output.TexCd = input[i].TexCd.xy;
		
		triOutputStream.Append(output);
	}
}

float sdSphere( float3 p, float s )
{
  return length(p)-s;
}

float sdBox( float3 p, float3 b )
{
  float3 d = abs(p) - b;
  return min(max(d.x,max(d.y,d.z)),0.0) +
         length(max(d,0.0));
}

float smin( float a, float b, float k )
{
    float h = clamp( 0.5+0.5*(b-a)/k, 0.0, 1.0 );
    return lerp( b, a, h ) - k*h*(1.0-h);
}

float3 smin( float3 a, float3 b, float k )
{
    float3 h = clamp( 0.5+0.5*(b-a)/k, 0.0, 1.0 );
    return lerp( b, a, h ) - k*h*(1.0-h);
}

float4 PS(gs2ps In): SV_Target
{
	float3 p = float3(In.TexCd, In.layerPS*iR.z)-0.5;
	p = mul(float4(p,1),tW).xyz;
	uint sc = In.BufferCount;
	float d = 0;
	float dd = 0;
	float3 vel = 0;
	if(sc>0)
	{
		d = sdSphere(p+Spheres[0].xyz,Spheres[0].w);
		vel = Velocity[0]*pow(saturate(1-d/Feather),FeatherPow);
		if(sc>1)
		{
			for(uint i=1; i<sc; i++)
			{
				float ddd = sdSphere(p+Spheres[i].xyz,Spheres[i].w);
				d = smin(d,ddd,mass);
				//d = min(d,sdSphere(p+Spheres[i].xyz,Spheres[i].w));
				//vel = smin(vel,Velocity[i]*pow(saturate(1-ddd/Feather),FeatherPow),-mass);
				vel += Velocity[i]*pow(saturate(1-ddd/Feather),FeatherPow);
			}
		}
		dd = pow(saturate(1-d/Feather),FeatherPow);
	}
	
    return float4(vel,dd);
}





technique10 Constant
{
	pass P0
	{
		SetVertexShader		( CompileShader( vs_5_0, VS() ) );
		SetGeometryShader	( CompileShader( gs_5_0, GS() ) );
		SetPixelShader		( CompileShader( ps_5_0, PS() ) );
	}
}




