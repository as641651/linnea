using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm90(ml0::Array{Float64,2}, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,2}, ml4::Array{Float64,2})
    # sizeArg ml0:(1800, 1800)
    # sizeArg ml1:(300, 1800)
    # sizeArg ml2:(1950, 300)
    # sizeArg ml3:(1950, 200)
    # sizeArg ml4:(200, 1950)
    # cost 2.2e+09
    # M278: ml0, full, M279: ml1, full, M280: ml2, full, M281: ml3, full, M282: ml4, full

    # sizeArg ml5:(300, 200)
    ml5 = Array{Float64}(undef, 300, 200)
    # tmp8 = (M280^T M281)
    # cost_K 2.34e+08 oprs_K 1.0 0.0 ml2 ml3 ml5
    gemm!('T', 'N', 1.0, ml2, ml3, 0.0, ml5)

    # M278: ml0, full, M279: ml1, full, M280: ml2, full, M282: ml4, full, tmp8: ml5, full

    # sizeArg ml6:(300, 200)
    ml6 = Array{Float64}(undef, 300, 200)
    # tmp10 = (M280^T M282^T)
    # cost_K 2.34e+08 oprs_K 1.0 0.0 ml2 ml4 ml6
    gemm!('T', 'T', 1.0, ml2, ml4, 0.0, ml6)

    # M278: ml0, full, M279: ml1, full, tmp8: ml5, full, tmp10: ml6, full

    # sizeArg ml7:(1800, 200)
    ml7 = Array{Float64}(undef, 1800, 200)
    # tmp13 = (M279^T tmp10)
    # cost_K 2.16e+08 oprs_K 1.0 0.0 ml1 ml6 ml7
    gemm!('T', 'N', 1.0, ml1, ml6, 0.0, ml7)

    # M278: ml0, full, M279: ml1, full, tmp8: ml5, full, tmp13: ml7, full
    # tmp6 = (tmp13 + (M279^T tmp8))
    # cost_K 2.16e+08 oprs_K 1.0 1.0 ml1 ml5 ml7
    gemm!('T', 'N', 1.0, ml1, ml5, 1.0, ml7)

    # M278: ml0, full, tmp6: ml7, full

    # sizeArg ml8:(1800, 200)
    ml8 = Array{Float64}(undef, 1800, 200)
    # tmp7 = (M278 tmp6)
    # cost_K 1.3e+09 oprs_K 1.0 0.0 ml0 ml7 ml8
    symm!('L', 'L', 1.0, ml0, ml7, 0.0, ml8)

    # tmp7: ml8, full
    # out = tmp7
    return (ml8)
end