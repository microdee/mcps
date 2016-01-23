
#include "../../../mp.fxh/ByteAddressBufferUtils.fxh"
#include "../../../mp.fxh/RWByteAddressBufferUtils.fxh"

ByteAddressBuffer src;
RWByteAddressBuffer ef : EVENFRAME;
RWByteAddressBuffer of : ODDFRAME;
RWByteAddressBuffer res : DELAYED;

#if !defined(XTHREADS)
#define XTHREADS 1
#endif
#if !defined(YTHREADS)
#define YTHREADS 1
#endif
#if !defined(ZTHREADS)
#define ZTHREADS 1
#endif

cbuffer cbuf
{
	uint nof = 256;
	bool odd = false;
};

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
	uint FID : SV_GroupIndex;
};

[numthreads(XTHREADS, YTHREADS, ZTHREADS)]
void CS(csin input)
{
	if(input.DTID.x > nof) return;
	uint ii = input.DTID.x;
	float c = BABLoad(src, ii);
	if(odd)
	{
		RWBABStore(of, ii, c);
		float p = RWBABLoad(ef, ii);
		RWBABStore(res, ii, p);
	}
	else
	{
		RWBABStore(ef, ii, c);
		float p = RWBABLoad(of, ii);
		RWBABStore(res, ii, p);
	}
}
technique11 cst { pass P0{SetComputeShader( CompileShader( cs_5_0, CS() ) );} }