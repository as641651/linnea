using LinearAlgebra.BLAS
using LinearAlgebra

function recommended(M345::Symmetric{Float64,Array{Float64,2}}, M343::Array{Float64,2}, M344::Array{Float64,2}, M342::UpperTriangular{Float64,Array{Float64,2}})
    start::Float64 = 0.0
    finish::Float64 = 0.0
    Benchmarker.cachescrub()
    start = time_ns()

    out = ((M345)\((M343*M344)\M342));

    finish = time_ns()
    return (tuple(out), (finish-start)*1e-9)
end