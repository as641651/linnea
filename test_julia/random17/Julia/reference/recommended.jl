using LinearAlgebra.BLAS
using LinearAlgebra

function recommended(M90::Array{Float64,2}, M92::LowerTriangular{Float64,Array{Float64,2}}, M91::Symmetric{Float64,Array{Float64,2}}, M93::Symmetric{Float64,Array{Float64,2}}, M94::Array{Float64,2})
    start::Float64 = 0.0
    finish::Float64 = 0.0
    Benchmarker.cachescrub()
    start = time_ns()

    out = (M90+M92*M91*M93*transpose(M94));

    finish = time_ns()
    return (tuple(out), (finish-start)*1e-9)
end