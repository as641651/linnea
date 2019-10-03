using LinearAlgebra.BLAS
using LinearAlgebra

function algorithm9(ml0::Array{Float64,2}, ml1::Array{Float64,2}, ml2::Array{Float64,2}, ml3::Array{Float64,2}, ml4::Array{Float64,2}, ml5::Array{Float64,2}, ml6::Array{Float64,2})
    # sizeArg ml0:(100, 100)
    # sizeArg ml1:(100, 1500)
    # sizeArg ml2:(200, 100)
    # sizeArg ml3:(200, 1500)
    # sizeArg ml4:(1500, 100)
    # sizeArg ml5:(1500, 100)
    # sizeArg ml6:(1500, 100)
    # cost 6.06e+07
    # M288: ml0, full, M289: ml1, full, M292: ml2, full, M293: ml3, full, M290: ml4, full, M291: ml5, full, M294: ml6, full

    # sizeArg ml7:(100,)
    ml7 = diag(ml0)
    # tmp1 = (M288 M289)
    # cost_K 1.5e+05 oprs_K ml7 ml1
    for i = 1:size(ml1, 2);
        view(ml1, :, i)[:] .*= ml7;
    end;        

    # M292: ml2, full, M293: ml3, full, M290: ml4, full, M291: ml5, full, M294: ml6, full, tmp1: ml1, full
    # tmp25 = (tmp1 + M291^T)
    # cost_K 1.5e+05 oprs_K ml1 ml5
    ml1 .+= transpose(ml5)

    # M292: ml2, full, M293: ml3, full, M290: ml4, full, M294: ml6, full, tmp25: ml1, full
    # tmp26 = (tmp25 + (M292^T M293))
    # cost_K 6e+07 oprs_K 1.0 1.0 ml2 ml3 ml1
    gemm!('T', 'N', 1.0, ml2, ml3, 1.0, ml1)

    # M290: ml4, full, M294: ml6, full, tmp26: ml1, full
    # tmp17 = (tmp26 + M294^T)
    # cost_K 1.5e+05 oprs_K ml1 ml6
    ml1 .+= transpose(ml6)

    # M290: ml4, full, tmp17: ml1, full
    # tmp6 = (tmp17 + M290^T)
    # cost_K 1.5e+05 oprs_K ml1 ml4
    ml1 .+= transpose(ml4)

    # tmp6: ml1, full
    # out = tmp6
    return (ml1)
end