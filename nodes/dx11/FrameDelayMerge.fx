//@author: vux
//@help: standard constant shader
//@tags: color
//@credits:

StructuredBuffer<float> BInput1;
StructuredBuffer<float> BInput2;
RWStructuredBuffer<float> BOutput : BACKBUFFER;
bool sel = false;
float count = 100;
struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(64, 1, 1)]
void CS_m64(csin input)
{
	if(input.DTID.x > count) return;
	uint ii=input.DTID.x;
	if(sel) BOutput[ii]=BInput1[ii];
	else BOutput[ii] = BInput2[ii];
}
technique11 Merge64 { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_m64() ) );} }