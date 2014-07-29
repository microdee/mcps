//@author: vux
//@help: standard constant shader
//@tags: color
//@credits:

StructuredBuffer<float> BInput;
RWStructuredBuffer<float> BOutput : BACKBUFFER;
float count = 200;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(64, 1, 1)]
void CS_c64(csin input)
{
	if(input.DTID.x > count) return;
	uint ii=input.DTID.x;
	BOutput[ii] = BInput[ii];
}
technique11 Copy64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_c64() ) );} }