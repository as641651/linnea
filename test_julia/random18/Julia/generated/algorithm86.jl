using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm86(ml0::Array{Float64,2}, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,2}, ml4::Array{Float64,2})
    # sizeArg ml0:(100, 100)
    # sizeArg ml1:(100, 100)
    # sizeArg ml2:(100, 100)
    # sizeArg ml3:(100, 250)
    # sizeArg ml4:(250, 100)
    # cost 1e+07
    # M99: ml0, full, M96: ml1, full, M95: ml2, full, M97: ml3, full, M98: ml4, full
    # tmp6 = (M95^-1 M97)
    # cost_K 2.5e+06 oprs_K 1.0 ml2 ml3
    trsm!('L', 'L', 'N', 'N', 1.0, ml2, ml3)

    # M99: ml0, full, M96: ml1, full, M98: ml4, full, tmp6: ml3, full
    # tmp8 = (M96^-T tmp6)
    # cost_K 2.5e+06 oprs_K 1.0 ml1 ml3
    trsm!('L', 'U', 'T', 'N', 1.0, ml1, ml3)

    # M99: ml0, full, M98: ml4, full, tmp8: ml3, full
    # tmp11 = (M99 + (tmp8 M98))
    # cost_K 5e+06 oprs_K 1.0 1.0 ml3 ml4 ml0
    gemm!('N', 'N', 1.0, ml3, ml4, 1.0, ml0)

    # tmp11: ml0, full
    # out = tmp11
    return (ml0)
end