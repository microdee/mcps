
#include "../../../mp.fxh/mcpsWrite.fxh"
#include "../../../mp.fxh/CSThreadDefines.fxh"

RWByteAddressBuffer Outbuf : BACKBUFFER;
StructuredBuffer<float3> Position;
StructuredBuffer<float4> VelAndInfl;
StructuredBuffer<float3> RadiusStrengthPow;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(XTHREADS, YTHREADS, ZTHREADS)]
void CSMain(csin input)
{
	if(input.DTID.x > PCOUNT) return;

	uint velc, rspc, Str;
	RadiusStrengthPow.GetDimensions(rspc, Str);
	VelAndInfl.GetDimensions(velc, Str);

	uint ii=input.DTID.x;
	uint aii=input.DTID.y;

	float3 pos = mcpsPositionLoad(Outbuf, ii);

	float4 avel = VelAndInfl[aii%velc];

	float3 dir = Position[aii]-pos;
	float ad = length(dir);
	dir = normalize(dir);
	float r = RadiusStrengthPow[aii%rspc].x;
	float s = RadiusStrengthPow[aii%rspc].y;
	float p = (RadiusStrengthPow[aii%rspc].z == 0) ? 1 : RadiusStrengthPow[aii%rspc].z;
	if(ad < r)
	{
		float attr = max(r - ad, 0);
		attr = pow(attr, p);
		float3 cvel = avel.xyz * avel.w * attr;
		attr *= s;
		float3 force = dir * attr;
		force += cvel;

        float3 absforce = mcpsForceLoad(Outbuf, ii) + force;
        mcpsForceStore(Outbuf, ii, absforce);
	}
}
technique11 csmain { pass P0{SetComputeShader( CompileShader( cs_5_0, CSMain() ) );} }
