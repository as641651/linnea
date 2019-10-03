using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm85(ml0::Array{Float64,2}, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,2})
    # sizeArg ml0:(1650, 1650)
    # sizeArg ml1:(1650, 1700)
    # sizeArg ml2:(1700, 1650)
    # sizeArg ml3:(1650, 1650)
    # cost 4.07e+10
    # M345: ml0, full, M343: ml1, full, M344: ml2, full, M342: ml3, full

    # sizeArg ml4:(1650, 1650)
    ml4 = Array{Float64}(undef, 1650, 1650)
    # tmp17 = (M343 M344)
    # cost_K 9.26e+09 oprs_K 1.0 0.0 ml1 ml2 ml4
    gemm!('N', 'N', 1.0, ml1, ml2, 0.0, ml4)

    # M345: ml0, full, M342: ml3, full, tmp17: ml4, full
    # (L1 L1^T) = M345
    # cost_K 1.5e+09 oprs_K ml0
    LinearAlgebra.LAPACK.potrf!('L', ml0)

    # M342: ml3, full, tmp17: ml4, full, L1: ml0, lower_triangular
    # (Q37 R38) = tmp17
    # cost_K 1.2e+10 oprs_K ml4
    ml4 = qr!(ml4)

    # M342: ml3, full, L1: ml0, lower_triangular, Q37: ml4, QRfact_Q, R38: ml4, QRfact_R

    # sizeArg ml5:(1650, 1650)
    ml5 = Array(ml4.Q)
    # tmp47 = (M342^T Q37)
    # cost_K 4.49e+09 oprs_K 1.0 ml3 ml5
    trmm!('L', 'U', 'T', 'N', 1.0, ml3, ml5)

    # L1: ml0, lower_triangular, R38: ml4, QRfact_R, tmp47: ml5, full

    # sizeArg ml6:(1650, 1650)
    ml6 = ml4.R
    # tmp48 = (tmp47 R38^-T)
    # cost_K 4.49e+09 oprs_K 1.0 ml6 ml5
    trsm!('R', 'U', 'T', 'N', 1.0, ml6, ml5)

    # L1: ml0, lower_triangular, tmp48: ml5, full
    # tmp49 = (tmp48 L1^-T)
    # cost_K 4.49e+09 oprs_K 1.0 ml0 ml5
    trsm!('R', 'L', 'T', 'N', 1.0, ml0, ml5)

    # L1: ml0, lower_triangular, tmp49: ml5, full
    # tmp50 = (tmp49 L1^-1)
    # cost_K 4.49e+09 oprs_K 1.0 ml0 ml5
    trsm!('R', 'L', 'N', 'N', 1.0, ml0, ml5)

    # tmp50: ml5, full

    # sizeArg ml7:(1650, 1650)
    ml7 = Array{Float64}(undef, 1650, 1650)
    # tmp15 = tmp50^T
    # cost_K 1 oprs_K ml5 ml7
    transpose!(ml7, ml5)

    # tmp15: ml7, full
    # out = tmp15
    return (ml7)
end