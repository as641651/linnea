using LinearAlgebra.BLAS
using LinearAlgebra
using MatrixGenerator
using Printf


BLAS.set_num_threads(1)

start = 0.0
finish = 0.0

# AB(inv(C)) where C is SPD

n = 1
m = 1
k = 3000

function get_matrices()
  A = rand(n,m)
  B = rand(m,k)
  C = generate([k,k],[Shape.General, Properties.SPD])

  Z = Array{Float64}(undef,n,k)

  return [A,B,C,Z]
end

#ABC-1

# L-tL-1 = C-1
cost_chol = (k*k*k)/3

#tmp = BL-t
cost_trsm1 = m*k*k

#tmp = tmpL-1
cost_trsm2 = m*k*k

#Atmp
cost_gemm = 2*m*n*k

cost = cost_chol + cost_trsm1 + cost_trsm2 + cost_gemm

@printf "Cost : %.6e\n" cost



function preprocess()
	ps = 100
  costk = 2*ps*ps*ps

  D = rand(ps,ps)

	gemm!('N','N',1.0,rand(ps,ps),rand(ps,ps),0.0,D)
	#LinearAlgebra.LAPACK.potrf!('L',D)
	#trsm!('L','L','N','N',1.0,rand(ps,ps),D)
end

function run()

	Benchmarker.cachescrub()

	preprocess()

  A,B,C,Z = get_matrices()

	start = time_ns()

	LinearAlgebra.LAPACK.potrf!('L', C)
  trsm!('R', 'L', 'T', 'N', 1.0, C, B)
  trsm!('R', 'L', 'N', 'N', 1.0, C, B)
  gemm!('N', 'N', 1.0, A, B, 0.0, Z)

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
