using LinearAlgebra.BLAS
using LinearAlgebra

function naive(M278::Symmetric{Float64,Array{Float64,2}}, M279::Array{Float64,2}, M280::Array{Float64,2}, M281::Array{Float64,2}, M282::Array{Float64,2})
    start::Float64 = 0.0
    finish::Float64 = 0.0
    Benchmarker.cachescrub()
    start = time_ns()

    out = M278*transpose(M279)*transpose(M280)*(M281+transpose(M282));

    finish = time_ns()
    return (tuple(out), (finish-start)*1e-9)
end