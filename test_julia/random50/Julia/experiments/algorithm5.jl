using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm5(ml0::Array{Float64,2}, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,2}, ml4::Array{Float64,2})
    start::Float64 = 0.0
    finish::Float64 = 0.0
    Benchmarker.cachescrub()
    start = time_ns()

    # sizeArg ml0:(1800, 1800)
    # sizeArg ml1:(300, 1800)
    # sizeArg ml2:(1950, 300)
    # sizeArg ml3:(1950, 200)
    # sizeArg ml4:(200, 1950)
    # cost 1.75e+09
    # M278: ml0, full, M279: ml1, full, M280: ml2, full, M281: ml3, full, M282: ml4, full
    # tmp1 = (M281 + M282^T)
    # cost_K 3.9e+05 oprs_K ml3 ml4
    ml3 .+= transpose(ml4)

    # M278: ml0, full, M279: ml1, full, M280: ml2, full, tmp1: ml3, full

    # sizeArg ml5:(300, 200)
    ml5 = Array{Float64}(undef, 300, 200)
    # tmp4 = (M280^T tmp1)
    # cost_K 2.34e+08 oprs_K 1.0 0.0 ml2 ml3 ml5
    gemm!('T', 'N', 1.0, ml2, ml3, 0.0, ml5)

    # M278: ml0, full, M279: ml1, full, tmp4: ml5, full

    # sizeArg ml6:(1800, 200)
    ml6 = Array{Float64}(undef, 1800, 200)
    # tmp6 = (M279^T tmp4)
    # cost_K 2.16e+08 oprs_K 1.0 0.0 ml1 ml5 ml6
    gemm!('T', 'N', 1.0, ml1, ml5, 0.0, ml6)

    # M278: ml0, full, tmp6: ml6, full

    # sizeArg ml7:(1800, 200)
    ml7 = Array{Float64}(undef, 1800, 200)
    # tmp7 = (M278 tmp6)
    # cost_K 1.3e+09 oprs_K 1.0 0.0 ml0 ml6 ml7
    symm!('L', 'L', 1.0, ml0, ml6, 0.0, ml7)

    # tmp7: ml7, full
    # out = tmp7

    finish = time_ns()
    return (tuple(ml7), (finish-start)*1e-9)
end