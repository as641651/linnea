using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm44(ml0::Array{Float64,2}, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,2}, ml4::Array{Float64,2}, ml5::Array{Float64,2}, ml6::Array{Float64,2})
    # sizeArg ml0:(400, 400)
    # sizeArg ml1:(400, 400)
    # sizeArg ml2:(400, 400)
    # sizeArg ml3:(150, 400)
    # sizeArg ml4:(150, 150)
    # sizeArg ml5:(150, 50)
    # sizeArg ml6:(50, 1300)
    # cost 1.39e+08
    # M237: ml0, full, M238: ml1, full, M239: ml2, full, M240: ml3, full, M241: ml4, full, M242: ml5, full, M243: ml6, full

    # sizeArg ml7:(150, 400)
    ml7 = Array{Float64}(undef, 150, 400)
    # tmp3 = (M240 M239)
    # cost_K 4.8e+07 oprs_K 1.0 0.0 ml2 ml3 ml7
    symm!('R', 'L', 1.0, ml2, ml3, 0.0, ml7)

    # M237: ml0, full, M238: ml1, full, M241: ml4, full, M242: ml5, full, M243: ml6, full, tmp3: ml7, full
    # tmp5 = (M241^-1 M242)
    # cost_K 1.12e+06 oprs_K 1.0 ml4 ml5
    trsm!('L', 'U', 'N', 'N', 1.0, ml4, ml5)

    # M237: ml0, full, M238: ml1, full, M243: ml6, full, tmp3: ml7, full, tmp5: ml5, full
    # tmp8 = (tmp3 M238^-T)
    # cost_K 2.4e+07 oprs_K 1.0 ml1 ml7
    trsm!('R', 'U', 'T', 'N', 1.0, ml1, ml7)

    # M237: ml0, full, M243: ml6, full, tmp5: ml5, full, tmp8: ml7, full

    # sizeArg ml8:(400, 50)
    ml8 = Array{Float64}(undef, 400, 50)
    # tmp17 = (tmp8^T tmp5)
    # cost_K 6e+06 oprs_K 1.0 0.0 ml7 ml5 ml8
    gemm!('T', 'N', 1.0, ml7, ml5, 0.0, ml8)

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