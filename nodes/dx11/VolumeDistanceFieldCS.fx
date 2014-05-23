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

RWTexture3D<float4> RWDistanceVolume : BACKBUFFER;
StructuredBuffer<float4> Spheres;
StructuredBuffer<float3> Velocity;

float3 InvVolumeSize : INVTARGETSIZE;
float Feather = 1;
float FeatherPow = 1;
float mass = 0.1;

float smin( float a, float b, float k )
{
    float h = clamp( 0.5+0.5*(b-a)/k, 0.0, 1.0 );
    return lerp( b, a, h ) - k*h*(1.0-h);
}

float smax( float a, float b, float k )
{
    return log( exp(k*a) + exp(k*b) ) / k;
}

float3 smin( float3 a, float3 b, float k )
{
    float3 h = clamp( 0.5+0.5*(b-a)/k, 0.0, 1.0 );
    return lerp( b, a, h ) - k*h*(1.0-h);
}

float pows(float a, float b)
{
	return pow(abs(a),b)*sign(a);
}

[numthreads(8, 8, 8)]
void CSf( uint3 i : SV_DispatchThreadID)
{ 
	float3 p = i;
	p *= InvVolumeSize;
	p -= 0.5f;
	
	uint sc, str;
	Spheres.GetDimensions(sc,str);
	
	if(sc>0)
	{
		float d = sdBox(p+Spheres[0].xyz,Spheres[0].w);
		float3 vel = Velocity[0]*pows(saturate(1-d/Feather),FeatherPow);
		if(sc>1)
		{
			for(uint i=1; i<sc; i++)
			{
				float ddd = sdBox(p+Spheres[i].xyz,Spheres[i].w);
				d = smin(d,ddd,mass);
				//d = min(d,sdSphere(p+Spheres[i].xyz,Spheres[i].w));
				//vel = smin(vel,Velocity[i]*pow(saturate(1-ddd/Feather),FeatherPow),-mass);
				vel += Velocity[i]*pows(saturate(1-ddd/Feather),FeatherPow);
			}
		}
		float dd = pows(saturate(1-d/Feather),FeatherPow);
		RWDistanceVolume[i] = float4(dd,vel);
	}
	//Do a simple distance field
	
}

[numthreads(8, 8, 8)]
void CSr( uint3 i : SV_DispatchThreadID)
{ 
	float3 p = i;
	p *= InvVolumeSize;
	p -= 0.5f;
	
	uint sc, str;
	Spheres.GetDimensions(sc,str);
	
	if(sc>0)
	{
		float d = sdBox(p,0.25);
		float3 vel = Velocity[0]*pows(saturate(1-d/Feather),FeatherPow);
		if(sc>1)
		{
			for(uint i=1; i<sc; i++)
			{
				float ddd = sdBox(p+Spheres[i].xyz,Spheres[i].w);
				//if((i%2)==0) d = smin(d,ddd,mass);
				d = smin(d,ddd,mass);
				//else d = smax(d,-ddd,1/mass);
				//d = min(d,sdSphere(p+Spheres[i].xyz,Spheres[i].w));
				//vel = smin(vel,Velocity[i]*pow(saturate(1-ddd/Feather),FeatherPow),-mass);
				vel += Velocity[i]*pows(saturate(1-ddd/Feather),FeatherPow);
			}
		}
		RWDistanceVolume[i] = float4(d,vel);
	}
	//Do a simple distance field
	
}

technique11 Filtered
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CSf() ) );
	}
}

technique11 Raw
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CSr() ) );
	}
}






