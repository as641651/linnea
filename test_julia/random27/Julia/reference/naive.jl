using LinearAlgebra.BLAS
using LinearAlgebra

function naive(s144::Float64, M141::LowerTriangular{Float64,Array{Float64,2}}, M142::Symmetric{Float64,Array{Float64,2}}, v143::Array{Float64,1}, v145::Array{Float64,1}, M146::Array{Float64,2}, M147::Array{Float64,2})
    start::Float64 = 0.0
    finish::Float64 = 0.0
    Benchmarker.cachescrub()
    start = time_ns()

    out = s144*inv(M141)*M142*v143*transpose(v145)*M146*transpose(M147);

    finish = time_ns()
    return (tuple(out), (finish-start)*1e-9)
end