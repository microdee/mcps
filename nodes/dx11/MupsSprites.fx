#include "mups.fxh"

float4x4 tV : VIEW;
float4x4 tVP : VIEWPROJECTION;
float4x4 tVI : VIEWINVERSE;
float4x4 tVPI : VIEWPROJECTIONINVERSE;

Texture2D texture2d;

float4 c <bool color=true;> = 1;
StructuredBuffer<float> mupsData;
float TailLength=.5;
float radius = 0.05f;
float innerradius = 0.05f;
 
float3 g_positions[4]:IMMUTABLE ={float3( -1, 1, 0 ),float3( 1, 1, 0 ),float3( -1, -1, 0 ),float3( 1, -1, 0 ),};
float2 g_texcoords[4]:IMMUTABLE ={float2(0,1), float2(1,1),float2(0,0),float2(1,0),};



SamplerState g_samLinear : IMMUTABLE
{
    Filter = MIN_MAG_MIP_LINEAR;
    AddressU = Clamp;
    AddressV = Clamp;
};

struct VS_IN
{
	uint iv : SV_VertexID;
	//float4 p: POSITION;	
};

struct vs2ps
{
    float4 PosWVP: SV_POSITION;	
	float2 TexCd : TEXCOORD0;
	uint iv : TEXCOORD1;
};

vs2ps VS(VS_IN In)
{
    //inititalize all fields of output struct with 0
    vs2ps Out = (vs2ps)0;
	uint3 pi = mups_position(In.iv);
	float3 p = 0;
	for(uint i=0; i<3; i++) p[i] = mupsData[pi[i]];
	
	//float4 po = In.p + float4(PData[In.iv],0);
    Out.PosWVP = float4(p,1);// mul(float4(po.xyz,1),tVP);
	Out.iv=In.iv;
    return Out;
}
[maxvertexcount(4)]
void GS(point vs2ps In[1], inout TriangleStream<vs2ps> SpriteStream)
{
    vs2ps output;
	output.TexCd = 0;	
	float3 p=In[0].PosWVP.xyz;
	output.iv=In[0].iv;
	uint iv=In[0].iv;
	
	float3 vel=0;
	uint4 vi = mups_velocity(iv);
	for(uint i=0; i<3; i++) vel[i] = mupsData[vi[i]] * Time.y;
	
	float3 camPos=mul(float4(0,0,0,1),tVI).xyz;
	float3 View = p - camPos;
	View = normalize(View);
	float3 upVector = normalize(vel+.0000001*float3(0,1,0));//float3(1, 1, 0);
	float3 rightVector = normalize(cross(View, upVector));
	//upVector*=1+1./(.1+88*length(mul(float4(upVector,1),tVP).xyz));
	//output.Color=c*pow(2,float4(In[0].vel.yzx*40,0))*(1+.3*length(In[0].vel));
	
	//.961*length(mul(float4(In[0].PosW.xyz+upVector,1.0),tV).xy-mul(float4(In[0].PosW.xyz-upVector,1.0),tV).xy);
	
	float size=radius*mupsData[mups_size(In[0].iv)];
	upVector*=size;
	upVector*=1+TailLength*40*(length(vel));
	rightVector*=size;
	output.TexCd=float2(1,1);
    output.PosWVP = mul(float4(p+rightVector+upVector,1.0),tVP);  
    SpriteStream.Append(output);
	output.TexCd=float2(0,1);
	output.PosWVP = mul(float4(p-rightVector+upVector,1.0),tVP);  
    SpriteStream.Append(output);
	output.TexCd=float2(1,0);
	output.PosWVP = mul(float4(p+rightVector-upVector*1,1.0),tVP);  
    SpriteStream.Append(output);
	output.TexCd=float2(0,0);
	output.PosWVP = mul(float4(p-rightVector-upVector*1,1.0),tVP);  
    SpriteStream.Append(output);
	SpriteStream.RestartStrip();

}
float3x3 lookat(float3 dir,float3 up=float3(0,1,0)){float3 z=normalize(dir);float3 x=normalize(cross(up,z));float3 y=normalize(cross(z,x));return float3x3(x,y,z);} 

[maxvertexcount(4)]
void GS2d(point vs2ps In[1], inout TriangleStream<vs2ps> SpriteStream)
{
    vs2ps output;
    
    //
    // Emit two new triangles
    //
	uint iv=In[0].iv;
	float3 vel=0;
	uint4 vi = mups_velocity(iv);
	for(uint i=0; i<3; i++) vel[i] = mupsData[vi[i]] * Time.y;
	float3 camPos=mul(float4(0,0,0,1),tVI).xyz;
	float3 p=In[0].PosWVP.xyz;
	float3 View = p - camPos;
	float size=radius*mupsData[mups_size(In[0].iv)];
    for(int i=0; i<4; i++)
    {
        float3 pos = g_positions[i]*size;
        //pos=mul(pos,(float3x3)tVI);
    	float3 screen_vel=float3(1,1,0)*mul(vel,(float3x3)tV);
    	
    	screen_vel=mul(float4(p,1.0),tV).xyz-mul(float4(p+vel,1.0),tV).xyz;
    	//screen_vel*=.5;
    	screen_vel.z=0;
    	pos.x*=1+TailLength*50*length(screen_vel);
    	//pos*=.5;
    	pos=mul(pos.yzx,lookat(screen_vel,float3(0,0,1)));
    	pos=mul(pos,(float3x3)tVI);
    	pos+=p;
    	//float3 norm=mul(float3(0,0,-1),(float3x3)tVI);
        output.PosWVP=mul(float4(pos,1.0),tVP);
    	output.iv=In[0].iv;
        output.TexCd=g_texcoords[i];	
        SpriteStream.Append(output);
    }
    SpriteStream.RestartStrip();
}

[maxvertexcount(4)]
void GSsprite(point vs2ps In[1], inout TriangleStream<vs2ps> SpriteStream)
{
    vs2ps output;
    
    //
    // Emit two new triangles
    //
	float size=radius*mupsData[mups_size(In[0].iv)];
    for(int i=0; i<4; i++)
    {
        float3 position = g_positions[i]*size;
    	//pow(2,sin(ppos[In[0].iv].age));
        position = mul( position, (float3x3)tVI ) + In[0].PosWVP.xyz;
    	//float3 norm = mul(float3(0,0,-1),(float3x3)tVI );
        output.PosWVP = mul( float4(position,1.0), tVP );
    	output.iv=In[0].iv;
        output.TexCd = g_texcoords[i];	
        SpriteStream.Append(output);
    }
    SpriteStream.RestartStrip();
}


float4 PS_Tex(vs2ps In): SV_Target
{
    float4 col = texture2d.Sample( g_samLinear, In.TexCd)*c;
	if(length(In.TexCd.xy-.5)>0.5)discard;
	if(length(In.TexCd.xy-.5)<innerradius)discard;
	
	uint4 ci = mups_color(In.iv);
	for(uint i=0; i<4; i++) col[i] *= mupsData[ci[i]];
	
	//col.a=1-2*length(In.TexCd.xy-.5);
	//col.rgb*=smoothstep(.5,0,length(In.TexCd.xy-.5));
    return col;
}


technique10 WorldVelocity
{
	pass P0
	{
		
		SetVertexShader( CompileShader( vs_4_0, VS() ) );
		SetGeometryShader( CompileShader( gs_4_0, GS() ) );
		SetPixelShader( CompileShader( ps_4_0, PS_Tex() ) );
	}
}
technique10 ScreenVelocity
{
	pass P0
	{
		
		SetVertexShader( CompileShader( vs_4_0, VS() ) );
		SetGeometryShader( CompileShader( gs_4_0, GS2d() ) );
		SetPixelShader( CompileShader( ps_4_0, PS_Tex() ) );
	}
}



