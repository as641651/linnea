using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm21(ml0::Float64, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,1}, ml4::Array{Float64,1}, ml5::Array{Float64,2}, ml6::Array{Float64,2})
    start::Float64 = 0.0
    finish::Float64 = 0.0
    Benchmarker.cachescrub()
    start = time_ns()

    # sizeArg ml0:(1, 1)
    # sizeArg ml1:(1700, 1700)
    # sizeArg ml2:(1700, 1700)
    # sizeArg ml3:(1700,)
    # sizeArg ml4:(100,)
    # sizeArg ml5:(100, 50)
    # sizeArg ml6:(500, 50)
    # cost 1.04e+07
    # s144: ml0, full, M141: ml1, full, M142: ml2, full, v143: ml3, full, v145: ml4, full, M146: ml5, full, M147: ml6, full

    # sizeArg ml7:(1700,)
    ml7 = Array{Float64}(undef, 1700)
    # tmp4 = (M142 v143)
    # cost_K 5.78e+06 oprs_K 1.0 0.0 ml2 ml3 ml7
    symv!('L', 1.0, ml2, ml3, 0.0, ml7)

    # s144: ml0, full, M141: ml1, full, v145: ml4, full, M146: ml5, full, M147: ml6, full, tmp4: ml7, full
    # tmp9 = (M141^-1 tmp4)
    # cost_K 2.89e+06 oprs_K ml1 ml7
    trsv!('L', 'N', 'N', ml1, ml7)

    # s144: ml0, full, v145: ml4, full, M146: ml5, full, M147: ml6, full, tmp9: ml7, full

    # sizeArg ml8:(50,)
    ml8 = Array{Float64}(undef, 50)
    # tmp6 = (M146^T v145)
    # cost_K 1e+04 oprs_K 1.0 0.0 ml5 ml4 ml8
    gemv!('T', 1.0, ml5, ml4, 0.0, ml8)

    # s144: ml0, full, M147: ml6, full, tmp9: ml7, full, tmp6: ml8, full
    # tmp13 = (s144 tmp9)
    # cost_K 1.7e+03 oprs_K ml0 ml7
    scal!(1700, ml0, ml7, 1)

    # M147: ml6, full, tmp6: ml8, full, tmp13: ml7, full

    # sizeArg ml9:(500,)
    ml9 = Array{Float64}(undef, 500)
    # tmp12 = (M147 tmp6)
    # cost_K 5e+04 oprs_K 1.0 0.0 ml6 ml8 ml9
    gemv!('N', 1.0, ml6, ml8, 0.0, ml9)

    # tmp13: ml7, full, tmp12: ml9, full

    # sizeArg ml10:(1700, 500)
    ml10 = Array{Float64}(undef, 1700, 500)
    # tmp22 = (tmp13 tmp12^T)
    # cost_K 1.7e+06 oprs_K 1.0 ml7 ml9 ml10
    ml10 .= 1.0.*ml7.*transpose(ml9)

    # tmp22: ml10, full
    # out = tmp22

    finish = time_ns()
    return (tuple(ml10), (finish-start)*1e-9)
end