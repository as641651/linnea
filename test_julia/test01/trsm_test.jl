using LinearAlgebra.BLAS
using LinearAlgebra
using MatrixGenerator
using Printf

BLAS.set_num_threads(1)

start = 0.0
finish = 0.0

# AC-1 ;A = m x k; C = k x k;

m = 200
k = 200

function get_matrices()
	A = rand(m,k)
	C = generate([k,k],[Shape.General, Properties.SPD])
	Z = Array{Float64}(undef,m,k)
	return [A,C,Z]
end

# L-tL-1 = C-1
cost_chol = (k*k*k)/3

#tmp = AL-t
cost_trsm1 = m*k*k

#tmp = tmpL-1
cost_trsm2 = m*k*k

cost = cost_chol + cost_trsm1 + cost_trsm2

@printf "Cost : %.6e\n" cost_trsm2

function preprocess()
	ps = 2000;
	D = rand(ps,ps)
	trsm!('L','L','N','N',1.0,rand(ps,ps),D)
end

function run()
	Benchmarker.cachescrub()
	preprocess()
	A,C,Z = get_matrices()

	LinearAlgebra.LAPACK.potrf!('L', C)
	trsm!('R', 'L', 'T', 'N', 1.0, C, A)

	#Benchmarker.set_cachescrub_size(36000)
	#Benchmarker.cachescrub()
	#preprocess()

	start = time_ns()
	trsm!('R', 'L', 'N', 'N', 1.0, C, A)
	finish = time_ns()


	t = (finish-start)*1e-9
	perf = (cost_trsm2/t)*1e-9

	println("Time : ", t)
	println("GFLOPS/SEC : ", perf)
	println()
	sleep(3)
end

function run1()
	Benchmarker.cachescrub()
	preprocess()
	A,C,Z = get_matrices()

	P = rand(m,m)

	LinearAlgebra.LAPACK.potrf!('L', C)
	trsm!('R', 'L', 'T', 'N', 1.0, C, A)

	gemm!('N', 'N', 1.0, P, A, 0.0, A)

	start = time_ns()
	trsm!('R', 'L', 'N', 'N', 1.0, C, A)
	finish = time_ns()


	t = (finish-start)*1e-9
	perf = (cost_trsm2/t)*1e-9

	println("Time : ", t)
	println("GFLOPS/SEC : ", perf)
	println()
	sleep(3)
end


run()
run()
run()
run()
run()
