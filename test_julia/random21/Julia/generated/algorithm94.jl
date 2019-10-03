using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm94(ml0::Array{Float64,2}, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,2}, ml4::Array{Float64,1})
    # sizeArg ml0:(1150, 1300)
    # sizeArg ml1:(1150, 1150)
    # sizeArg ml2:(1150, 150)
    # sizeArg ml3:(150, 1150)
    # sizeArg ml4:(150,)
    # cost 3.68e+06
    # M109: ml0, full, M110: ml1, full, M111: ml2, full, M112: ml3, full, v113: ml4, full

    # sizeArg ml5:(1150,)
    ml5 = Array{Float64}(undef, 1150)
    # tmp12 = (M112^T v113)
    # cost_K 3.45e+05 oprs_K 1.0 0.0 ml3 ml4 ml5
    gemv!('T', 1.0, ml3, ml4, 0.0, ml5)

    # M109: ml0, full, M110: ml1, full, M111: ml2, full, v113: ml4, full, tmp12: ml5, full

    # sizeArg ml6:(1150,)
    ml6 = Array{Float64}(undef, 1150)
    # tmp9 = (M111 v113)
    # cost_K 3.45e+05 oprs_K 1.0 0.0 ml2 ml4 ml6
    gemv!('N', 1.0, ml2, ml4, 0.0, ml6)

    # M109: ml0, full, M110: ml1, full, tmp12: ml5, full, tmp9: ml6, full

    # sizeArg ml7:(1150,)
    ml7 = diag(ml1)
    # tmp16 = (M110 tmp9)
    # cost_K 1.15e+03 oprs_K ml7 ml6
    ml6 .*= ml7

    # M109: ml0, full, M110: ml7, diagonal_vector, tmp12: ml5, full, tmp16: ml6, full
    # tmp18 = (M110 tmp12)
    # cost_K 1.15e+03 oprs_K ml7 ml5
    ml5 .*= ml7

    # M109: ml0, full, tmp16: ml6, full, tmp18: ml5, full
    # tmp6 = (tmp16 + tmp18)
    # cost_K 1.15e+03 oprs_K 1.0 ml5 ml6
    axpy!(1.0, ml5, ml6) # vectors

    # M109: ml0, full, tmp6: ml6, full

    # sizeArg ml8:(1300,)
    ml8 = Array{Float64}(undef, 1300)
    # tmp7 = (M109^T tmp6)
    # cost_K 2.99e+06 oprs_K 1.0 0.0 ml0 ml6 ml8
    gemv!('T', 1.0, ml0, ml6, 0.0, ml8)

    # tmp7: ml8, full
    # out = tmp7
    return (ml8)
end