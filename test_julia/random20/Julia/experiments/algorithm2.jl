using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm2(ml0::Array{Float64,2}, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,2}, ml4::Array{Float64,2})
    start::Float64 = 0.0
    finish::Float64 = 0.0
    Benchmarker.cachescrub()
    start = time_ns()

    # sizeArg ml0:(1600, 1600)
    # sizeArg ml1:(400, 1600)
    # sizeArg ml2:(1600, 1600)
    # sizeArg ml3:(400, 1600)
    # sizeArg ml4:(400, 1600)
    # cost 4.44e+09
    # M105: ml0, full, M106: ml1, full, M107: ml2, full, M108: ml3, full, M104: ml4, full
    # tmp7 = (M106 M105^-T)
    # cost_K 1.02e+09 oprs_K 1.0 ml0 ml1
    trsm!('R', 'L', 'T', 'N', 1.0, ml0, ml1)

    # M107: ml2, full, M108: ml3, full, M104: ml4, full, tmp7: ml1, full
    # tmp8 = (M104 + tmp7)
    # cost_K 1.28e+06 oprs_K 1.0 ml1 ml4
    axpy!(1.0, ml1, ml4) # matrices

    # M107: ml2, full, M108: ml3, full, tmp8: ml4, full

    # sizeArg ml5:(1600, 400)
    ml5 = Array{Float64}(undef, 1600, 400)
    # tmp10 = M108^T
    # cost_K 1 oprs_K ml3 ml5
    transpose!(ml5, ml3)

    # M107: ml2, full, tmp8: ml4, full, tmp10: ml5, full
    # (L1 L1^T) = M107
    # cost_K 1.37e+09 oprs_K ml2
    LinearAlgebra.LAPACK.potrf!('L', ml2)

    # tmp8: ml4, full, tmp10: ml5, full, L1: ml2, lower_triangular
    # tmp12 = (L1^-1 tmp10)
    # cost_K 1.02e+09 oprs_K 1.0 ml2 ml5
    trsm!('L', 'L', 'N', 'N', 1.0, ml2, ml5)

    # tmp8: ml4, full, L1: ml2, lower_triangular, tmp12: ml5, full
    # tmp6 = (L1^-T tmp12)
    # cost_K 1.02e+09 oprs_K 1.0 ml2 ml5
    trsm!('L', 'L', 'T', 'N', 1.0, ml2, ml5)

    # tmp8: ml4, full, tmp6: ml5, full
    # tmp9 = (tmp6 + tmp8^T)
    # cost_K 6.4e+05 oprs_K ml5 ml4
    ml5 .+= transpose(ml4)

    # tmp9: ml5, full
    # out = tmp9

    finish = time_ns()
    return (tuple(ml5), (finish-start)*1e-9)
end