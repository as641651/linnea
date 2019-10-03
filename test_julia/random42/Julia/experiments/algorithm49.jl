using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm49(ml0::Array{Float64,2}, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,2}, ml4::Array{Float64,2}, ml5::Array{Float64,2})
    start::Float64 = 0.0
    finish::Float64 = 0.0
    Benchmarker.cachescrub()
    start = time_ns()

    # sizeArg ml0:(1500, 1300)
    # sizeArg ml1:(1300, 1500)
    # sizeArg ml2:(1600, 1300)
    # sizeArg ml3:(1600, 1500)
    # sizeArg ml4:(1500, 1600)
    # sizeArg ml5:(1500, 1600)
    # cost 1.21e+10
    # M231: ml0, full, M232: ml1, full, M233: ml2, full, M235: ml3, full, M234: ml4, full, M236: ml5, full
    # tmp31 = (M235 + M234^T)
    # cost_K 2.4e+06 oprs_K ml3 ml4
    ml3 .+= transpose(ml4)

    # M231: ml0, full, M232: ml1, full, M233: ml2, full, M236: ml5, full, tmp31: ml3, full
    # tmp1 = (M231 + M232^T)
    # cost_K 1.95e+06 oprs_K ml0 ml1
    ml0 .+= transpose(ml1)

    # M233: ml2, full, M236: ml5, full, tmp31: ml3, full, tmp1: ml0, full
    # tmp3 = (tmp31 + M236^T)
    # cost_K 2.4e+06 oprs_K ml3 ml5
    ml3 .+= transpose(ml5)

    # M233: ml2, full, tmp1: ml0, full, tmp3: ml3, full

    # sizeArg ml6:(1300, 1500)
    ml6 = Array{Float64}(undef, 1300, 1500)
    # tmp5 = (M233^T tmp3)
    # cost_K 6.24e+09 oprs_K 1.0 0.0 ml2 ml3 ml6
    gemm!('T', 'N', 1.0, ml2, ml3, 0.0, ml6)

    # tmp1: ml0, full, tmp5: ml6, full

    # sizeArg ml7:(1500, 1500)
    ml7 = Array{Float64}(undef, 1500, 1500)
    # tmp6 = (tmp1 tmp5)
    # cost_K 5.85e+09 oprs_K 1.0 0.0 ml0 ml6 ml7
    gemm!('N', 'N', 1.0, ml0, ml6, 0.0, ml7)

    # tmp6: ml7, full
    # out = tmp6

    finish = time_ns()
    return (tuple(ml7), (finish-start)*1e-9)
end