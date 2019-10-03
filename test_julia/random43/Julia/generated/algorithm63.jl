using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm63(ml0::Array{Float64,2}, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,2}, ml4::Array{Float64,2}, ml5::Array{Float64,2}, ml6::Array{Float64,2})
    # sizeArg ml0:(400, 400)
    # sizeArg ml1:(400, 400)
    # sizeArg ml2:(400, 400)
    # sizeArg ml3:(150, 400)
    # sizeArg ml4:(150, 150)
    # sizeArg ml5:(150, 50)
    # sizeArg ml6:(50, 1300)
    # cost 1.47e+08
    # M237: ml0, full, M238: ml1, full, M239: ml2, full, M240: ml3, full, M241: ml4, full, M242: ml5, full, M243: ml6, full
    # tmp5 = (M241^-1 M242)
    # cost_K 1.12e+06 oprs_K 1.0 ml4 ml5
    trsm!('L', 'U', 'N', 'N', 1.0, ml4, ml5)

    # M237: ml0, full, M238: ml1, full, M239: ml2, full, M240: ml3, full, M243: ml6, full, tmp5: ml5, full
    # tmp2 = (M238^-1 M239)
    # cost_K 6.4e+07 oprs_K 1.0 ml1 ml2
    trsm!('L', 'U', 'N', 'N', 1.0, ml1, ml2)

    # M237: ml0, full, M240: ml3, full, M243: ml6, full, tmp5: ml5, full, tmp2: ml2, full

    # sizeArg ml7:(400, 50)
    ml7 = Array{Float64}(undef, 400, 50)
    # tmp10 = (M240^T tmp5)
    # cost_K 6e+06 oprs_K 1.0 0.0 ml3 ml5 ml7
    gemm!('T', 'N', 1.0, ml3, ml5, 0.0, ml7)

    # M237: ml0, full, M243: ml6, full, tmp2: ml2, full, tmp10: ml7, full

    # sizeArg ml8:(400, 50)
    ml8 = Array{Float64}(undef, 400, 50)
    # tmp17 = (tmp2 tmp10)
    # cost_K 1.6e+07 oprs_K 1.0 0.0 ml2 ml7 ml8
    gemm!('N', 'N', 1.0, ml2, ml7, 0.0, ml8)

    # M237: ml0, full, M243: ml6, full, tmp17: ml8, full
    # tmp19 = (M237 tmp17)
    # cost_K 8e+06 oprs_K 1.0 ml0 ml8
    trmm!('L', 'L', 'N', 'N', 1.0, ml0, ml8)

    # M243: ml6, full, tmp19: ml8, full

    # sizeArg ml9:(400, 1300)
    ml9 = Array{Float64}(undef, 400, 1300)
    # tmp21 = (tmp19 M243)
    # cost_K 5.2e+07 oprs_K 1.0 0.0 ml8 ml6 ml9
    gemm!('N', 'N', 1.0, ml8, ml6, 0.0, ml9)

    # tmp21: ml9, full
    # out = tmp21
    return (ml9)
end