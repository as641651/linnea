using LinearAlgebra.BLAS
using LinearAlgebra

function naive(M237::LowerTriangular{Float64,Array{Float64,2}}, M238::UpperTriangular{Float64,Array{Float64,2}}, M239::Symmetric{Float64,Array{Float64,2}}, M240::Array{Float64,2}, M241::UpperTriangular{Float64,Array{Float64,2}}, M242::Array{Float64,2}, M243::Array{Float64,2})
    start::Float64 = 0.0
    finish::Float64 = 0.0
    Benchmarker.cachescrub()
    start = time_ns()

    out = M237*inv(M238)*M239*transpose(M240)*inv(M241)*M242*M243;

    finish = time_ns()
    return (tuple(out), (finish-start)*1e-9)
end