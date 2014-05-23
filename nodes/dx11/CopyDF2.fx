
Texture3D<float> TInput0;
Texture3D<float> TInput1;
bool sel = false;
RWTexture3D<float> BOutput : BACKBUFFER;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(8, 8, 8)]
void CS_c1(csin input) {
	uint3 ii=input.DTID;
	BOutput[ii] = lerp(TInput0.Load(int4(ii,0)), TInput1.Load(int4(ii,0)), sel);
}
technique11 Copy1 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c1() ) );} }