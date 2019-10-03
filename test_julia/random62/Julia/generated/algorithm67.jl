using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm67(ml0::Array{Float64,2}, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,2})
    # sizeArg ml0:(1650, 1650)
    # sizeArg ml1:(1650, 1700)
    # sizeArg ml2:(1700, 1650)
    # sizeArg ml3:(1650, 1650)
    # cost 3.92e+10
    # M345: ml0, full, M343: ml1, full, M344: ml2, full, M342: ml3, full

    # sizeArg ml4:(1650, 1650)
    ml4 = Array{Float64}(undef, 1650, 1650)
    # tmp17 = (M343 M344)
    # cost_K 9.26e+09 oprs_K 1.0 0.0 ml1 ml2 ml4
    gemm!('N', 'N', 1.0, ml1, ml2, 0.0, ml4)

    # M345: ml0, full, M342: ml3, full, tmp17: ml4, full

    # sizeArg ml5:(1650, 1650)
    ml5 = Array{Float64}(undef, 1650, 1650)
    # tmp19 = (tmp17 M345)
    # cost_K 8.98e+09 oprs_K 1.0 0.0 ml0 ml4 ml5
    symm!('R', 'L', 1.0, ml0, ml4, 0.0, ml5)

    # M342: ml3, full, tmp19: ml5, full
    # (Q23 R24) = tmp19
    # cost_K 1.2e+10 oprs_K ml5
    ml5 = qr!(ml5)

    # M342: ml3, full, Q23: ml5, QRfact_Q, R24: ml5, QRfact_R

    # sizeArg ml6:(1650, 1650)
    ml6 = Array(ml5.Q)
    # tmp31 = (M342^T Q23)
    # cost_K 4.49e+09 oprs_K 1.0 ml3 ml6
    trmm!('L', 'U', 'T', 'N', 1.0, ml3, ml6)

    # R24: ml5, QRfact_R, tmp31: ml6, full

    # sizeArg ml7:(1650, 1650)
    ml7 = ml5.R
    # tmp32 = (tmp31 R24^-T)
    # cost_K 4.49e+09 oprs_K 1.0 ml7 ml6
    trsm!('R', 'U', 'T', 'N', 1.0, ml7, ml6)

    # tmp32: ml6, full

    # sizeArg ml8:(1650, 1650)
    ml8 = Array{Float64}(undef, 1650, 1650)
    # tmp15 = tmp32^T
    # cost_K 1 oprs_K ml6 ml8
    transpose!(ml8, ml6)

    # tmp15: ml8, full
    # out = tmp15
    return (ml8)
end