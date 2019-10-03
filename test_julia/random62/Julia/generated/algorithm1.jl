using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm1(ml0::Array{Float64,2}, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,2})
    # sizeArg ml0:(1650, 1650)
    # sizeArg ml1:(1650, 1700)
    # sizeArg ml2:(1700, 1650)
    # sizeArg ml3:(1650, 1650)
    # cost 3.02e+10
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

    # sizeArg ml6:(1650,)
    ml6 = Array{Float64}(undef, 1650)
    # (P22^T L20 U21) = tmp19
    # cost_K 2.99e+09 oprs_K ml5 ml6
    (ml5, ml6, info) = LinearAlgebra.LAPACK.getrf!(ml5)

    # M342: ml3, full, P22: ml6, ipiv, L20: ml5, lower_triangular_udiag, U21: ml5, upper_triangular

    # sizeArg ml7:(1650,)
    # sizeArg ml8:(1650, 1650)
    ml7 = [1:length(ml6);]
    @inbounds for i in 1:length(ml6)
        ml7[i], ml7[ml6[i]] = ml7[ml6[i]], ml7[i];
    end;
    ml8 = Array{Float64}(undef, 1650, 1650)
    # tmp28 = (P22 M342)
    # cost_K 2.72e+06 oprs_K ml7 ml3 ml8
    ml8 = ml3[ml7,:]

    # L20: ml5, lower_triangular_udiag, U21: ml5, upper_triangular, tmp28: ml8, full
    # tmp29 = (L20^-1 tmp28)
    # cost_K 4.49e+09 oprs_K 1.0 ml5 ml8
    trsm!('L', 'L', 'N', 'U', 1.0, ml5, ml8)

    # U21: ml5, upper_triangular, tmp29: ml8, full
    # tmp15 = (U21^-1 tmp29)
    # cost_K 4.49e+09 oprs_K 1.0 ml5 ml8
    trsm!('L', 'U', 'N', 'N', 1.0, ml5, ml8)

    # tmp15: ml8, full
    # out = tmp15
    return (ml8)
end