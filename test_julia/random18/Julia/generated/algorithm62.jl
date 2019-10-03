using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm62(ml0::Array{Float64,2}, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,2}, ml4::Array{Float64,2})
    # sizeArg ml0:(100, 100)
    # sizeArg ml1:(100, 100)
    # sizeArg ml2:(100, 100)
    # sizeArg ml3:(100, 250)
    # sizeArg ml4:(250, 100)
    # cost 7.02e+06
    # M99: ml0, full, M96: ml1, full, M95: ml2, full, M97: ml3, full, M98: ml4, full

    # sizeArg ml5:(100, 100)
    ml5 = Array{Float64}(undef, 100, 100)
    # tmp7 = (M97 M98)
    # cost_K 5e+06 oprs_K 1.0 0.0 ml3 ml4 ml5
    gemm!('N', 'N', 1.0, ml3, ml4, 0.0, ml5)

    # M99: ml0, full, M96: ml1, full, M95: ml2, full, tmp7: ml5, full
    # tmp12 = (M95 M96^T)
    # cost_K 1e+06 oprs_K 1.0 ml1 ml2
    trmm!('R', 'U', 'T', 'N', 1.0, ml1, ml2)

    # M99: ml0, full, tmp7: ml5, full, tmp12: ml2, full
    # tmp10 = (tmp12^-1 tmp7)
    # cost_K 1e+06 oprs_K 1.0 ml2 ml5
    trsm!('L', 'L', 'N', 'N', 1.0, ml2, ml5)

    # M99: ml0, full, tmp10: ml5, full
    # tmp11 = (M99 + tmp10)
    # cost_K 2e+04 oprs_K 1.0 ml0 ml5
    axpy!(1.0, ml0, ml5) # matrices

    # tmp11: ml5, full
    # out = tmp11
    return (ml5)
end