using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm36(ml0::Array{Float64,2}, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,2})
    start::Float64 = 0.0
    finish::Float64 = 0.0
    Benchmarker.cachescrub()
    start = time_ns()

    # sizeArg ml0:(1650, 1650)
    # sizeArg ml1:(1650, 1700)
    # sizeArg ml2:(1700, 1650)
    # sizeArg ml3:(1650, 1650)
    # cost 3.17e+10
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

    # sizeArg ml5:(1650,)
    ml5 = Array{Float64}(undef, 1650)
    # (P36^T L34 U35) = tmp17
    # cost_K 2.99e+09 oprs_K ml4 ml5
    (ml4, ml5, info) = LinearAlgebra.LAPACK.getrf!(ml4)

    # M342: ml3, full, L1: ml0, lower_triangular, P36: ml5, ipiv, L34: ml4, lower_triangular_udiag, U35: ml4, upper_triangular

    # sizeArg ml6:(1650,)
    # sizeArg ml7:(1650, 1650)
    ml6 = [1:length(ml5);]
    @inbounds for i in 1:length(ml5)
        ml6[i], ml6[ml5[i]] = ml6[ml5[i]], ml6[i];
    end;
    ml7 = Array{Float64}(undef, 1650, 1650)
    # tmp42 = (P36 M342)
    # cost_K 2.72e+06 oprs_K ml6 ml3 ml7
    ml7 = ml3[ml6,:]

    # L1: ml0, lower_triangular, L34: ml4, lower_triangular_udiag, U35: ml4, upper_triangular, tmp42: ml7, full
    # tmp43 = (L34^-1 tmp42)
    # cost_K 4.49e+09 oprs_K 1.0 ml4 ml7
    trsm!('L', 'L', 'N', 'U', 1.0, ml4, ml7)

    # L1: ml0, lower_triangular, U35: ml4, upper_triangular, tmp43: ml7, full
    # tmp44 = (U35^-1 tmp43)
    # cost_K 4.49e+09 oprs_K 1.0 ml4 ml7
    trsm!('L', 'U', 'N', 'N', 1.0, ml4, ml7)

    # L1: ml0, lower_triangular, tmp44: ml7, full
    # tmp45 = (L1^-1 tmp44)
    # cost_K 4.49e+09 oprs_K 1.0 ml0 ml7
    trsm!('L', 'L', 'N', 'N', 1.0, ml0, ml7)

    # L1: ml0, lower_triangular, tmp45: ml7, full
    # tmp15 = (L1^-T tmp45)
    # cost_K 4.49e+09 oprs_K 1.0 ml0 ml7
    trsm!('L', 'L', 'T', 'N', 1.0, ml0, ml7)

    # tmp15: ml7, full
    # out = tmp15

    finish = time_ns()
    return (tuple(ml7), (finish-start)*1e-9)
end