using LinearAlgebra.BLAS
using LinearAlgebra

function naive(M288::Diagonal{Float64,Array{Float64,1}}, M289::Array{Float64,2}, M292::Array{Float64,2}, M293::Array{Float64,2}, M290::Array{Float64,2}, M291::Array{Float64,2}, M294::Array{Float64,2})
    start::Float64 = 0.0
    finish::Float64 = 0.0
    Benchmarker.cachescrub()
    start = time_ns()

    out = (M288*M289+transpose(M292)*M293+transpose(M290)+transpose(M291)+transpose(M294));

    finish = time_ns()
    return (tuple(out), (finish-start)*1e-9)
end