using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm2(ml0::Array{Float64,2}, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,2}, ml4::Array{Float64,2})
    start::Float64 = 0.0
    finish::Float64 = 0.0
    Benchmarker.cachescrub()
    start = time_ns()

    # sizeArg ml0:(1000, 50)
    # sizeArg ml1:(1000, 1000)
    # sizeArg ml2:(1000, 1000)
    # sizeArg ml3:(1000, 1000)
    # sizeArg ml4:(50, 1000)
    # cost 2.5e+08
    # M90: ml0, full, M92: ml1, full, M91: ml2, full, M93: ml3, full, M94: ml4, full

    # sizeArg ml5:(50, 1000)
    ml5 = Array{Float64}(undef, 50, 1000)
    # tmp3 = (M94 M93)
    # cost_K 1e+08 oprs_K 1.0 0.0 ml3 ml4 ml5
    symm!('R', 'L', 1.0, ml3, ml4, 0.0, ml5)

    # M90: ml0, full, M92: ml1, full, M91: ml2, full, tmp3: ml5, full

    # sizeArg ml6:(50, 1000)
    ml6 = Array{Float64}(undef, 50, 1000)
    # tmp5 = (tmp3 M91)
    # cost_K 1e+08 oprs_K 1.0 0.0 ml2 ml5 ml6
    symm!('R', 'L', 1.0, ml2, ml5, 0.0, ml6)

    # M90: ml0, full, M92: ml1, full, tmp5: ml6, full
    # tmp6 = (tmp5 M92^T)
    # cost_K 5e+07 oprs_K 1.0 ml1 ml6
    trmm!('R', 'L', 'T', 'N', 1.0, ml1, ml6)

    # M90: ml0, full, tmp6: ml6, full
    # tmp7 = (M90 + tmp6^T)
    # cost_K 5e+04 oprs_K ml0 ml6
    ml0 .+= transpose(ml6)

    # tmp7: ml0, full
    # out = tmp7

    finish = time_ns()
    return (tuple(ml0), (finish-start)*1e-9)
end