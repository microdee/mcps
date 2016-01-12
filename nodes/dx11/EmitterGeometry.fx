
#include "../../../mp.fxh/ByteAddressBufferUtils.fxh"
#include "../../../mp.fxh/mupsWrite.fxh"
#include "../../../mp.fxh/CSThreadDefines.fxh"

//define DO_COLOR
//define DO_CTRLTEX
//define DO_ADDITIONAL

RWByteAddressBuffer Outbuf : BACKBUFFER;

ByteAddressBuffer GeomBuf;
StructuredBuffer<uint> TriangleID;
StructuredBuffer<float3> VertexWeight;
StructuredBuffer<float2> SrcDst;
Texture2D ColorTex;
Texture2D CtrlTex;

cbuffer cbuf
{
    float4x4 tW : WORLD;
    float4 CtrlTexDst;
    float NormalToVelocity = 0;
    float PrevPosToVelocity = 0;
    uint EmitterID = 0;
    uint emitcount = 100;
    uint NumOfFloats = 11;
    uint NormalOffset = 3;
    uint TexCdOffset = 6;
    uint PrevPosOffset = 8;
}

SamplerState s0 <string uiname="Sampler";>
	{Filter=MIN_MAG_MIP_LINEAR;AddressU=CLAMP;AddressV=CLAMP;};

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};
struct vertex
{
	float3 pos;
	float3 ppos;
	float3 norm;
	float2 txcd;
};

[numthreads(XTHREADS, YTHREADS, ZTHREADS)]
void CSMain(csin input)
{
	if(input.DTID.x > emitcount) return;
	// get dimensions
	uint TIDC, VWC, Str;
	TriangleID.GetDimensions(TIDC, Str);
	VertexWeight.GetDimensions(VWC, Str);

	// calculate ID's
	uint ii=input.DTID.x + WorldEmitOffset + EmitOffset[EmitterID];
	uint pii=input.DTID.x;
	uint trii = TriangleID[pii]*3;

    mupsAgeStore(Outbuf, ii, 0);
	// calculate barycentric
	float3 vweight = VertexWeight[pii];
	float vweightSum = vweight.x + vweight.y + vweight.z;

	// main thread
	if(input.DTID.y == 0)
	{
    	vertex vert[3];
    	for(uint i=0; i<3; i++)
    	{
    		vert[i].pos = BABLoad3(GeomBuf, (trii+i)*NumOfFloats);
    		vert[i].norm = BABLoad3(GeomBuf, (trii+i)*NumOfFloats+NormalOffset);
    		vert[i].txcd = BABLoad2(GeomBuf, (trii+i)*NumOfFloats+TexCdOffset);
    		vert[i].ppos = BABLoad3(GeomBuf, (trii+i)*NumOfFloats+PrevPosOffset);
    	}
    	float3 tpos = 0;
    	float3 tppos = 0;
    	float3 tnorm = 0;
    	float2 ttxcd = 0;
    	for(uint i=0; i<3; i++)
    	{
    		tpos += vert[i].pos * vweight[i];
    		tppos += vert[i].ppos * vweight[i];
    		tnorm += vert[i].norm * vweight[i];
    		ttxcd += vert[i].txcd * vweight[i];
    	}
    	tpos /= vweightSum;
    	tpos = mul(float4(tpos,1),tW).xyz;
    	tppos /= vweightSum;
    	tppos = mul(float4(tppos,1),tW).xyz;
    	tnorm /= vweightSum;
    	tnorm = mul(float4(tpos,0),tW).xyz;
    	ttxcd /= vweightSum;

        mupsPositionStore(Outbuf, ii, tpos);

        float4 vel = float4(0,0,0,1);

        if(NormalToVelocity > 0.0001)
            vel.xyz += tnorm * NormalToVelocity;
        if(PrevPosToVelocity > 0.0001)
            vel.xyz += (tpos-tppos) * PrevPosToVelocity;

        mupsVelocityStore(Outbuf, ii, vel);

        #if defined(KNOW_COLOR) && defined(DO_COLOR)
            float4 col = ColorTex.SampleLevel(s0, ttxcd, 0);
            mupsColorStore(Outbuf, ii, col);
        #endif

        #if defined(DO_CTRLTEX)
            float4 ctrl = CtrlTex.SampleLevel(s0, ttxcd, 0);
            for(uint i=0; i<4; i++)
            {
                if(CtrlTexDst[i] >= 0)
                {
                    mupsStore(Outbuf, ii, CtrlTexDst[i], ctrl[i]);
                }
            }
        #endif
	}

	// optional vertex data controlled
    #if defined(DO_ADDITIONAL)
    	if(DstC != 0)
    	{
    		if(input.DTID.y > 0)
    		{
    			uint oii = max(input.DTID.y-1,0);
    			float3 vertexprop;
    			for(uint i=0; i<3; i++)
    				vertexprop[i] = BABLoad(GeomBuf, (trii+i)*NumOfFloats+SrcDst[oii].x);
    			vertexprop *= vweight;
    			float prop = (vertexprop.x + vertexprop.y + vertexprop.z)/vweightSum;
                mupsStore(Outbuf, ii, SrcDst[oii].y, prop);
    		}
    	}
    #endif
}
technique11 csmain { pass P0{SetComputeShader( CompileShader( cs_5_0, CSMain() ) );} }
