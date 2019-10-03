using LinearAlgebra.BLAS
using LinearAlgebra

function recommended(M105::LowerTriangular{Float64,Array{Float64,2}}, M106::Array{Float64,2}, M107::Symmetric{Float64,Array{Float64,2}}, M108::Array{Float64,2}, M104::Array{Float64,2})
    start::Float64 = 0.0
    finish::Float64 = 0.0
    Benchmarker.cachescrub()
    start = time_ns()

    out = (((M105)\transpose(M106))+((M107)\transpose(M108))+transpose(M104));

    finish = time_ns()
    return (tuple(out), (finish-start)*1e-9)
end