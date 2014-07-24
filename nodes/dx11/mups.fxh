float pcount : PS_PARTICLECOUNT;
float pelsize : PS_ELEMENTSIZE;
float sysvalcount : PS_SYSVALCOUNT;
float bufsize : PS_BUFFERSIZE;
float2 Time : PS_TIME;
float EmitCounter : PS_EMITTERCOUNTER;
StructuredBuffer<uint> EmitCountOffs : PS_EMITTERCOUNTEROFFSET;

float3 mups_position_load(RWByteAddressBuffer mupsb, uint i) {return asfloat(mupsb.Load3( i*pelsize ));}
float4 mups_velocity_load(RWByteAddressBuffer mupsb, uint i) {return asfloat(mupsb.Load4( i*pelsize + 12 ));}
float3 mups_force_load(RWByteAddressBuffer mupsb, uint i) {return asfloat(mupsb.Load3( i*pelsize + 28 ));}
float4 mups_color_load(RWByteAddressBuffer mupsb, uint i) {return asfloat(mupsb.Load4( i*pelsize + 40 ));}
float mups_size_load(RWByteAddressBuffer mupsb, uint i) {return asfloat(mupsb.Load( i*pelsize + 56 ));}
float2 mups_age_load(RWByteAddressBuffer mupsb, uint i) {return asfloat(mupsb.Load2( i*pelsize + 60 ));}

float mups_load(RWByteAddressBuffer mupsb, uint i, uint offset) {return asfloat(mupsb.Load( i*pelsize + offset ));}
float2 mups_load2(RWByteAddressBuffer mupsb, uint i, uint offset) {return asfloat(mupsb.Load2( i*pelsize + offset ));}
float3 mups_load3(RWByteAddressBuffer mupsb, uint i, uint offset) {return asfloat(mupsb.Load3( i*pelsize + offset ));}
float4 mups_load4(RWByteAddressBuffer mupsb, uint i, uint offset) {return asfloat(mupsb.Load4( i*pelsize + offset ));}
float4x4 mups_load4x4(RWByteAddressBuffer mupsb, uint i, uint offset)
{
	float4x4 tmp = 0;
	[unroll]
	for(uint i=0; i<4; i++)
	{
		[unroll]
		for(uint j=0; j<4; j++)
		{
			tmp[i][j] = asfloat(mupsb.Load( i*pelsize + offset + i*16+j*4 ));
		}
	}
	return tmp;
}

float3 mups_position_load(ByteAddressBuffer mupsb, uint i) {return asfloat(mupsb.Load3( i*pelsize ));}
float4 mups_velocity_load(ByteAddressBuffer mupsb, uint i) {return asfloat(mupsb.Load4( i*pelsize + 12 ));}
float3 mups_force_load(ByteAddressBuffer mupsb, uint i) {return asfloat(mupsb.Load3( i*pelsize + 28 ));}
float4 mups_color_load(ByteAddressBuffer mupsb, uint i) {return asfloat(mupsb.Load4( i*pelsize + 40 ));}
float mups_size_load(ByteAddressBuffer mupsb, uint i) {return asfloat(mupsb.Load( i*pelsize + 56 ));}
float2 mups_age_load(ByteAddressBuffer mupsb, uint i) {return asfloat(mupsb.Load2( i*pelsize + 60 ));}

float mups_load(ByteAddressBuffer mupsb, uint i, uint offset) {return asfloat(mupsb.Load( i*pelsize + offset ));}
float2 mups_load2(ByteAddressBuffer mupsb, uint i, uint offset) {return asfloat(mupsb.Load2( i*pelsize + offset ));}
float3 mups_load3(ByteAddressBuffer mupsb, uint i, uint offset) {return asfloat(mupsb.Load3( i*pelsize + offset ));}
float4 mups_load4(ByteAddressBuffer mupsb, uint i, uint offset) {return asfloat(mupsb.Load4( i*pelsize + offset ));}
float4x4 mups_load4x4(ByteAddressBuffer mupsb, uint i, uint offset)
{
	float4x4 tmp = 0;
	[unroll]
	for(uint i=0; i<4; i++)
	{
		[unroll]
		for(uint j=0; j<4; j++)
		{
			tmp[i][j] = asfloat(mupsb.Load( i*pelsize + offset + i*16+j*4 ));
		}
	}
	return tmp;
}

void mups_position_store(RWByteAddressBuffer mupsb, uint i, float3 In) { mupsb.Store3( i*pelsize , asuint(In) ); }
void mups_velocity_store(RWByteAddressBuffer mupsb, uint i, float4 In) { mupsb.Store4( i*pelsize + 12 , asuint(In) ); }
void mups_velocity_store(RWByteAddressBuffer mupsb, uint i, float3 In) { mupsb.Store3( i*pelsize + 12 , asuint(In) ); }
void mups_velocity_store(RWByteAddressBuffer mupsb, uint i, float In) { mupsb.Store( i*pelsize + 24 , asuint(In) ); }
void mups_force_store(RWByteAddressBuffer mupsb, uint i, float3 In) { mupsb.Store3( i*pelsize + 28 , asuint(In) ); }
void mups_color_store(RWByteAddressBuffer mupsb, uint i, float4 In) { mupsb.Store4( i*pelsize + 40 , asuint(In) ); }
void mups_size_store(RWByteAddressBuffer mupsb, uint i, float In) { mupsb.Store( i*pelsize + 56 , asuint(In) ); }
void mups_age_store(RWByteAddressBuffer mupsb, uint i, float2 In) { mupsb.Store2( i*pelsize + 60 , asuint(In) ); }

void mups_store(RWByteAddressBuffer mupsb, uint i, uint offset, float In) { mupsb.Store( i*pelsize + offset , asuint(In) ); }
void mups_store(RWByteAddressBuffer mupsb, uint i, uint offset, float2 In) { mupsb.Store2( i*pelsize + offset , asuint(In) ); }
void mups_store(RWByteAddressBuffer mupsb, uint i, uint offset, float3 In) { mupsb.Store3( i*pelsize + offset , asuint(In) ); }
void mups_store(RWByteAddressBuffer mupsb, uint i, uint offset, float4 In) { mupsb.Store4( i*pelsize + offset , asuint(In) ); }
void mups_store(RWByteAddressBuffer mupsb, uint i, uint offset, float4x4 In)
{
	[unroll]
	for(uint i=0; i<4; i++)
	{
		[unroll]
		for(uint j=0; j<4; j++)
		{
			mupsb.Store( i*pelsize + offset + i*16+j*4 , asuint(In[i][j]));
		}
	}
}