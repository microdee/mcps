//@author: vux
//@help: standard constant shader
//@tags: color
//@credits:

Texture3D<float> TInput;
RWTexture3D<float> BOutput : BACKBUFFER;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(8, 8, 8)]
void CS_c1(csin input) { uint3 ii=input.DTID; BOutput[ii] = TInput.Load(int4(ii,0)); }
technique11 Copy1 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c1() ) );} }