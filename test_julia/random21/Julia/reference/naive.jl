using LinearAlgebra.BLAS
using LinearAlgebra

function naive(M109::Array{Float64,2}, M110::Diagonal{Float64,Array{Float64,1}}, M111::Array{Float64,2}, M112::Array{Float64,2}, v113::Array{Float64,1})
    start::Float64 = 0.0
    finish::Float64 = 0.0
    Benchmarker.cachescrub()
    start = time_ns()

    out = transpose(M109)*M110*(M111+transpose(M112))*v113;

    finish = time_ns()
    return (tuple(out), (finish-start)*1e-9)
end