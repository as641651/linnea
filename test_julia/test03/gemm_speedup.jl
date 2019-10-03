using LinearAlgebra.BLAS
using LinearAlgebra
using MatrixGenerator
using Printf

BLAS.set_num_threads(2)

start = 0.0
finish = 0.0

# AB

# A = m x k; B=k x n

m=300
k=1950
n=100

function get_matrices()
  A = rand(m,k)
  B = rand(k,n)
  return [A,B]
end

function preprocess()
	ps = 2000;
	D = rand(ps,ps)
	trsm!('L','L','N','N',1.0,rand(ps,ps),D)
end

function run(f)
  Benchmarker.set_cachescrub_size(804000)
  Benchmarker.cachescrub()
  preprocess()

  A,B = get_matrices()

  cost, finish, start = f(A,B)

  t = (finish-start)*1e-9
  perf = (cost/t)*1e-9

  @printf "Cost : %.4e\n" cost
  println("Time : ", t)
  println("GFLOPS/SEC : ", perf)
  println()
  sleep(3)
end

function f1(A::Array{Float64,2}, B::Array{Float64,2})
  Z = Array{Float64}(undef,m,n)
  start = time_ns()
  gemm!('N','N',1.0,A,B,0.0,Z)
  finish = time_ns()
  return  [2*m*k*n,finish,start]
end

function f2(A::Array{Float64,2}, B::Array{Float64,2})
  Z = Array{Float64}(undef,m,n)
  Z1 = Array{Float64}(undef,m,n)

  gemm!('N','N',1.0,A,B,0.0,Z)
  start = time_ns()
  gemm!('N','N',1.0,A,B,0.0,Z1)
  finish = time_ns()

  return [4*m*k*n,finish,start]
end


preprocess()
run(f2)
run(f2)
run(f2)
run(f2)
run(f2)
