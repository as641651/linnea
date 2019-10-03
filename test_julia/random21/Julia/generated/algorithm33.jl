using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm33(ml0::Array{Float64,2}, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,2}, ml4::Array{Float64,1})
    # sizeArg ml0:(1150, 1300)
    # sizeArg ml1:(1150, 1150)
    # sizeArg ml2:(1150, 150)
    # sizeArg ml3:(150, 1150)
    # sizeArg ml4:(150,)
    # cost 3.68e+06
    # M109: ml0, full, M110: ml1, full, M111: ml2, full, M112: ml3, full, v113: ml4, full

    # sizeArg ml5:(1150,)
    ml5 = Array{Float64}(undef, 1150)
    # tmp9 = (M111 v113)
    # cost_K 3.45e+05 oprs_K 1.0 0.0 ml2 ml4 ml5
    gemv!('N', 1.0, ml2, ml4, 0.0, ml5)

    # M109: ml0, full, M110: ml1, full, M112: ml3, full, v113: ml4, full, tmp9: ml5, full

    # sizeArg ml6:(1150,)
    ml6 = Array{Float64}(undef, 1150)
    # tmp12 = (M112^T v113)
    # cost_K 3.45e+05 oprs_K 1.0 0.0 ml3 ml4 ml6
    gemv!('T', 1.0, ml3, ml4, 0.0, ml6)

    # M109: ml0, full, M110: ml1, full, tmp9: ml5, full, tmp12: ml6, full
    # tmp4 = (tmp12 + tmp9)
    # cost_K 1.15e+03 oprs_K 1.0 ml6 ml5
    axpy!(1.0, ml6, ml5) # vectors

    # M109: ml0, full, M110: ml1, full, tmp4: ml5, full

    # sizeArg ml7:(1150,)
    ml7 = diag(ml1)
    # tmp6 = (M110 tmp4)
    # cost_K 1.15e+03 oprs_K ml7 ml5
    ml5 .*= ml7

    # M109: ml0, full, tmp6: ml5, full

    # sizeArg ml8:(1300,)
    ml8 = Array{Float64}(undef, 1300)
    # tmp7 = (M109^T tmp6)
    # cost_K 2.99e+06 oprs_K 1.0 0.0 ml0 ml5 ml8
    gemv!('T', 1.0, ml0, ml5, 0.0, ml8)

    # tmp7: ml8, full
    # out = tmp7
    return (ml8)
end