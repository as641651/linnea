using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm67(ml0::Float64, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,1}, ml4::Array{Float64,1}, ml5::Array{Float64,2}, ml6::Array{Float64,2})
    # sizeArg ml0:(1, 1)
    # sizeArg ml1:(1700, 1700)
    # sizeArg ml2:(1700, 1700)
    # sizeArg ml3:(1700,)
    # sizeArg ml4:(100,)
    # sizeArg ml5:(100, 50)
    # sizeArg ml6:(500, 50)
    # cost 1.55e+07
    # s144: ml0, full, M141: ml1, full, M142: ml2, full, v143: ml3, full, v145: ml4, full, M146: ml5, full, M147: ml6, full

    # sizeArg ml7:(1700,)
    ml7 = Array{Float64}(undef, 1700)
    # tmp4 = (M142 v143)
    # cost_K 5.78e+06 oprs_K 1.0 0.0 ml2 ml3 ml7
    symv!('L', 1.0, ml2, ml3, 0.0, ml7)

    # s144: ml0, full, M141: ml1, full, v145: ml4, full, M146: ml5, full, M147: ml6, full, tmp4: ml7, full

    # sizeArg ml8:(100, 500)
    ml8 = Array{Float64}(undef, 100, 500)
    # tmp7 = (M146 M147^T)
    # cost_K 5e+06 oprs_K 1.0 0.0 ml5 ml6 ml8
    gemm!('N', 'T', 1.0, ml5, ml6, 0.0, ml8)

    # s144: ml0, full, M141: ml1, full, v145: ml4, full, tmp4: ml7, full, tmp7: ml8, full

    # sizeArg ml9:(500,)
    ml9 = Array{Float64}(undef, 500)
    # tmp12 = (tmp7^T v145)
    # cost_K 1e+05 oprs_K 1.0 0.0 ml8 ml4 ml9
    gemv!('T', 1.0, ml8, ml4, 0.0, ml9)

    # s144: ml0, full, M141: ml1, full, tmp4: ml7, full, tmp12: ml9, full
    # tmp9 = (M141^-1 tmp4)
    # cost_K 2.89e+06 oprs_K ml1 ml7
    trsv!('L', 'N', 'N', ml1, ml7)

    # s144: ml0, full, tmp12: ml9, full, tmp9: ml7, full

    # sizeArg ml10:(1700, 500)
    ml10 = Array{Float64}(undef, 1700, 500)
    # tmp22 = (s144 tmp9 tmp12^T)
    # cost_K 1.7e+06 oprs_K ml0 ml7 ml9 ml10
    ml10 .= ml0.*ml7.*transpose(ml9)

    # tmp22: ml10, full
    # out = tmp22
    return (ml10)
end