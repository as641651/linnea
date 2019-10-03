using LinearAlgebra.BLAS
using LinearAlgebra
using MatrixGenerator
using Printf

BLAS.set_num_threads(8)

start = 0.0
finish = 0.0

batch = 1
size = 2000

n = size
m = size
k = 2000

cost = batch*2*m*n*k
@printf "Cost : %.2e\n" cost
@printf "FLOPs/Byte : %f\n" cost/(batch*(n*m+m*k + n*k))

A = rand(n,m)
B = rand(m,k)
C = Array{Float64}(undef,n,k)

function preprocess()
	ps = 100
        cost = 2*ps*ps*ps

        D = rand(ps,ps)

	gemm!('N','N',1.0,rand(ps,ps),rand(ps,ps),0.0,D)
	#LinearAlgebra.LAPACK.potrf!('L',D)
	#trsm!('L','L','N','N',1.0,rand(ps,ps),D)
end

function run()

	Benchmarker.cachescrub()

	preprocess()

	start = time_ns()

	for i = 1:batch
	   gemm!('N','N',1.0,A,B,0.0,C)
	end

	finish = time_ns()

	t = (finish-start)*1e-9
	perf = (cost/t)*1e-9

	println("Time : ", t)
	println("GFLOPS/SEC : ", perf)
	println()
	sleep(3)
end

preprocess()
run()
run()
run()
run()
run()
