using LinearAlgebra.BLAS
using LinearAlgebra

function naive(M99::Symmetric{Float64,Array{Float64,2}}, M96::UpperTriangular{Float64,Array{Float64,2}}, M95::LowerTriangular{Float64,Array{Float64,2}}, M97::Array{Float64,2}, M98::Array{Float64,2})
    start::Float64 = 0.0
    finish::Float64 = 0.0
    Benchmarker.cachescrub()
    start = time_ns()

    out = (M99+inv(transpose(M96))*inv(M95)*M97*M98);

    finish = time_ns()
    return (tuple(out), (finish-start)*1e-9)
end