using LinearAlgebra.BLAS
using LinearAlgebra
using MatrixGenerator
using Printf

BLAS.set_num_threads(1)

start = 0.0
finish = 0.0

# A_mn B_nk C_kl D_lg = Z_mg

m = 1009
n = 1013
k = 1049
l = 1037
g = 1321

cost = 0

A = rand(m,n)
B = rand(n,k)
C = rand(k,l)
D = rand(l,g)

Z = Array{Float64}(undef,m,g)

function preprocess()
	ps = 100
  R = rand(ps,ps)
	gemm!('N','N',1.0,rand(ps,ps),rand(ps,ps),0.0,R)
	#LinearAlgebra.LAPACK.potrf!('L',R)
	#trsm!('L','L','N','N',1.0,rand(ps,ps),R)
end

function AB_CD()
  global cost = 2*(m*n*k + k*l*g + m*k*g)

	println("AB_CD")
	tmp1 = Array{Float64}(undef,m,k)
	gemm!('N','N',1.0,A,B,0.0,tmp1)

	tmp2 = Array{Float64}(undef,k,g)
	gemm!('N','N',1.0,C,D,0.0,tmp2)

	gemm!('N','N',1.0,tmp1,tmp2,0.0,Z)
end

function A_BCD()
  global cost = 2*(k*l*g + n*k*g + m*n*g)
	println("A_BCD")
	tmp1 = Array{Float64}(undef,k,g)
	gemm!('N','N',1.0,C,D,0.0,tmp1)

	tmp2 = Array{Float64}(undef,n,g)
	gemm!('N','N',1.0,B,tmp1,0.0,tmp2)

	gemm!('N','N',1.0,A,tmp2,0.0,Z)
end

function ABC_D()
	global cost = 2*(m*n*k + m*k*l + m*l*g)
	println("ABC_D")
	tmp1 = Array{Float64}(undef,m,k)
	gemm!('N','N',1.0,A,B,0.0,tmp1)

	tmp2 = Array{Float64}(undef,m,l)
	gemm!('N','N',1.0,tmp1,C,0.0,tmp2)

	gemm!('N','N',1.0,tmp2,D,0.0,Z)
end


function run(f)

	Benchmarker.cachescrub()

	preprocess()

	start = time_ns()

	f()

	finish = time_ns()

	t = (finish-start)*1e-9
	perf = (cost/t)*1e-9

	@printf "Cost : %.2e\n" cost
	println("Time : ", t)
	println("GFLOPS/SEC : ", perf)
	println()
	sleep(3)
end

preprocess()
run(ABC_D)
run(AB_CD)

run(ABC_D)
run(AB_CD)

run(ABC_D)
run(AB_CD)

run(ABC_D)
run(AB_CD)
