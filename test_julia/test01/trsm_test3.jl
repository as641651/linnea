using LinearAlgebra.BLAS
using LinearAlgebra
using MatrixGenerator
using Printf

BLAS.set_num_threads(1)

start = 0.0
finish = 0.0

# PAC-1 ;P = n x m ; A = m x k; C = k x k;

n = 190
m = 192
k = 192

function get_matrices()
  P = rand(n,m)
	A = rand(m,k)
	C = generate([k,k],[Shape.General, Properties.SPD])
	Z = Array{Float64}(undef,n,k)
	return [P,A,C,Z]
end


cost_trsm1 = (k*k*k)/3 + 2*m*k*k + 2*n*m*k

cost_trsm2 = 2*n*m*k + (k*k*k)/3 + 2*n*k*k


function preprocess()
	ps = 2000;
	D = rand(ps,ps)
	trsm!('L','L','N','N',1.0,rand(ps,ps),D)
end

function run()
	Benchmarker.cachescrub()
	preprocess()
	P,A,C,Z = get_matrices()

	start = time_ns()

	LinearAlgebra.LAPACK.potrf!('L', C)
	trsm!('R', 'L', 'T', 'N', 1.0, C, A)

	trsm!('R', 'L', 'N', 'N', 1.0, C, A)

	gemm!('N', 'N', 1.0, P, A, 0.0, Z)

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
	P,A,C,Z = get_matrices()

	start = time_ns()

	gemm!('N', 'N', 1.0, P, A, 0.0, Z)

	LinearAlgebra.LAPACK.potrf!('L', C)
	trsm!('R', 'L', 'T', 'N', 1.0, C, Z)

	trsm!('R', 'L', 'N', 'N', 1.0, C, Z)

	finish = time_ns()

	t = (finish-start)*1e-9
	perf = (cost_trsm2/t)*1e-9

	println("Time : ", t)
	println("GFLOPS/SEC : ", perf)
	println()
	sleep(3)
end

@printf "Cost : %.6e\n" cost_trsm2
run1()
run1()
run1()
run1()
run1()
