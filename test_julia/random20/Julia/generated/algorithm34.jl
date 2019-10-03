using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm34(ml0::Array{Float64,2}, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,2}, ml4::Array{Float64,2})
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
    # cost_K 1.28e+06 oprs_K 1.0 ml4 ml1
    axpy!(1.0, ml4, ml1) # matrices

    # M107: ml2, full, M108: ml3, full, tmp8: ml1, full

    # sizeArg ml5:(1600, 400)
    ml5 = Array{Float64}(undef, 1600, 400)
    # tmp11 = tmp8^T
    # cost_K 1 oprs_K ml1 ml5
    transpose!(ml5, ml1)

    # M107: ml2, full, M108: ml3, full, tmp11: ml5, full
    # (L1 L1^T) = M107
    # cost_K 1.37e+09 oprs_K ml2
    LinearAlgebra.LAPACK.potrf!('L', ml2)

    # M108: ml3, full, tmp11: ml5, full, L1: ml2, lower_triangular
    # tmp13 = (M108 L1^-T)
    # cost_K 1.02e+09 oprs_K 1.0 ml2 ml3
    trsm!('R', 'L', 'T', 'N', 1.0, ml2, ml3)

    # tmp11: ml5, full, L1: ml2, lower_triangular, tmp13: ml3, full
    # tmp14 = (tmp13 L1^-1)
    # cost_K 1.02e+09 oprs_K 1.0 ml2 ml3
    trsm!('R', 'L', 'N', 'N', 1.0, ml2, ml3)

    # tmp11: ml5, full, tmp14: ml3, full
    # tmp16 = (tmp11 + tmp14^T)
    # cost_K 6.4e+05 oprs_K ml5 ml3
    ml5 .+= transpose(ml3)

    # tmp16: ml5, full
    # out = tmp16
    return (ml5)
end