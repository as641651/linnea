using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm13(ml0::Array{Float64,2}, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,2}, ml4::Array{Float64,1})
    start::Float64 = 0.0
    finish::Float64 = 0.0
    Benchmarker.cachescrub()
    start = time_ns()

    # sizeArg ml0:(1150, 1300)
    # sizeArg ml1:(1150, 1150)
    # sizeArg ml2:(1150, 150)
    # sizeArg ml3:(150, 1150)
    # sizeArg ml4:(150,)
    # cost 3.68e+06
    # M109: ml0, full, M110: ml1, full, M111: ml2, full, M112: ml3, full, v113: ml4, full
    # tmp1 = (M111 + M112^T)
    # cost_K 1.72e+05 oprs_K ml2 ml3
    ml2 .+= transpose(ml3)

    # M109: ml0, full, M110: ml1, full, v113: ml4, full, tmp1: ml2, full

    # sizeArg ml5:(1150,)
    ml5 = diag(ml1)
    # tmp3 = (M110 tmp1)
    # cost_K 1.72e+05 oprs_K ml5 ml2
    for i = 1:size(ml2, 2);
        view(ml2, :, i)[:] .*= ml5;
    end;        

    # M109: ml0, full, v113: ml4, full, tmp3: ml2, full

    # sizeArg ml6:(1150,)
    ml6 = Array{Float64}(undef, 1150)
    # tmp6 = (tmp3 v113)
    # cost_K 3.45e+05 oprs_K 1.0 0.0 ml2 ml4 ml6
    gemv!('N', 1.0, ml2, ml4, 0.0, ml6)

    # M109: ml0, full, tmp6: ml6, full

    # sizeArg ml7:(1300,)
    ml7 = Array{Float64}(undef, 1300)
    # tmp7 = (M109^T tmp6)
    # cost_K 2.99e+06 oprs_K 1.0 0.0 ml0 ml6 ml7
    gemv!('T', 1.0, ml0, ml6, 0.0, ml7)

    # tmp7: ml7, full
    # out = tmp7

    finish = time_ns()
    return (tuple(ml7), (finish-start)*1e-9)
end