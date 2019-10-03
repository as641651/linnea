using LinearAlgebra.BLAS
using LinearAlgebra

function recommended(M231::Array{Float64,2}, M232::Array{Float64,2}, M233::Array{Float64,2}, M235::Array{Float64,2}, M234::Array{Float64,2}, M236::Array{Float64,2})
    start::Float64 = 0.0
    finish::Float64 = 0.0
    Benchmarker.cachescrub()
    start = time_ns()

    out = (M231+transpose(M232))*transpose(M233)*(M235+transpose(M234)+transpose(M236));

    finish = time_ns()
    return (tuple(out), (finish-start)*1e-9)
end