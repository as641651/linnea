using LinearAlgebra.BLAS
using LinearAlgebra
using MatrixGenerator
using Printf

BLAS.set_num_threads(8)

start = 0.0
finish = 0.0

# A(B+C) vs AB + AC

# A = m x k; B,C=k x n

m=300
k=1950
n=100

function get_matrices()
  A = rand(m,k)
  B = rand(k,n)
  C = rand(k,n)
  return [A,B,C]
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

  A,B,C = get_matrices()

  start = time_ns()
  cost = f(A,B,C)
  finish = time_ns()


  t = (finish-start)*1e-9
  perf = (cost/t)*1e-9

  @printf "Cost : %.4e\n" cost
  println("Time : ", t)
  println("GFLOPS/SEC : ", perf)
  println()
  sleep(3)
end

function f1(A::Array{Float64,2}, B::Array{Float64,2}, C::Array{Float64,2})
  axpy!(1.0,B,C)
  Z = Array{Float64}(undef,m,n)
  gemm!('N','N',1.0,A,C,0.0,Z)
  return 2*k*n + 2*m*k*n
end

function f2(A::Array{Float64,2}, B::Array{Float64,2}, C::Array{Float64,2})
  C .+= B
  Z = Array{Float64}(undef,m,n)
  gemm!('N','N',1.0,A,C,0.0,Z)
  return k*n + 2*m*k*n
end

function f3(A::Array{Float64,2}, B::Array{Float64,2}, C::Array{Float64,2})
  T1 = Array{Float64}(undef,m,n)
  gemm!('N','N',1.0,A,B,0.0,T1)
  T2 = Array{Float64}(undef,m,n)
  gemm!('N','N',1.0,A,C,0.0,T2)
  axpy!(1.0,T1,T2)
  return 4*m*k*n + 2*m*n
end

preprocess()
run(f1)
run(f1)
run(f1)
run(f1)
run(f1)
