using LinearAlgebra.BLAS
using LinearAlgebra
using MatrixGenerator
using Printf

BLAS.set_num_threads(8)

start = 0.0
finish = 0.0

# AB^tC^t(D+E^t)

# A = m x k; B=k x n

m=1800
k=300
j=200
n=20

function get_matrices()
  A = generate([m,m],[Shape.General, Properties.SPD])
  B = rand(k,m)
  C = rand(j,k)
  D = rand(j,n)
  E = rand(n,j)
  return [A,B,C,D,E]
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

  A,B,C,D,E = get_matrices()

  cost, finish, start = f(A,B,C,D,E)

  t = (finish-start)*1e-9
  perf = (cost/t)*1e-9

  @printf "Cost : %.4e\n" cost
  println("Time : ", t)
  println("GFLOPS/SEC : ", perf)
  println()
  sleep(3)
end

function f1(A::Array{Float64,2}, B::Array{Float64,2}, C::Array{Float64,2}, D::Array{Float64,2}, E::Array{Float64,2})
  start = time_ns()

  D .+= transpose(E)
  T1 = Array{Float64}(undef,k,n)
  gemm!('T','N',1.0,C,D,0.0,T1)
  T2 = Array{Float64}(undef,m,n)
  gemm!('T','N',1.0,B,T1,0.0,T2)
  Z = Array{Float64}(undef,m,n)
  symm!('L','L',1.0,A,T2,0.0,Z)

  finish = time_ns()
  cost = j*n + 2*j*k*n + 2*m*k*n +2*m*m*n
  return  [cost,finish,start]
end

function f2(A::Array{Float64,2}, B::Array{Float64,2}, C::Array{Float64,2}, D::Array{Float64,2}, E::Array{Float64,2})
  start = time_ns()

  T1 = Array{Float64}(undef,k,n)
  gemm!('T','T',1.0,C,E,0.0,T1)
  T2 = Array{Float64}(undef,k,n)
  gemm!('T','N',1.0,C,D,0.0,T2)
  axpy!(1.0,T1,T2)
  T3 = Array{Float64}(undef,m,n)
  gemm!('T','N',1.0,B,T2,0.0,T3)
  Z = Array{Float64}(undef,m,n)
  symm!('L','L',1.0,A,T3,0.0,Z)

  finish = time_ns()
  cost = 4*j*k*n + 2*k*n + 2*m*k*n +2*m*m*n
  return  [cost,finish,start]
end

function f3(A::Array{Float64,2}, B::Array{Float64,2}, C::Array{Float64,2}, D::Array{Float64,2}, E::Array{Float64,2})
  start = time_ns()

  T1 = Array{Float64}(undef,k,n)
  gemm!('T','T',1.0,C,E,0.0,T1)
  gemm!('T','N',1.0,C,D,1.0,T1)
  T3 = Array{Float64}(undef,m,n)
  gemm!('T','N',1.0,B,T1,0.0,T3)
  Z = Array{Float64}(undef,m,n)
  symm!('L','L',1.0,A,T3,0.0,Z)

  finish = time_ns()
  cost = 4*j*k*n + 2*k*n + 2*m*k*n +2*m*m*n
  return  [cost,finish,start]
end

preprocess()
run(f2)
run(f2)
run(f2)
run(f2)
run(f2)
