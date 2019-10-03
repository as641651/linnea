using LinearAlgebra.BLAS
using LinearAlgebra
using MatrixGenerator
using Printf

BLAS.set_num_threads(1)

start = 0.0
finish = 0.0

k = 364

cost = (k*k*k)/3
@printf "Cost : %.2e\n" cost
@printf "FLOPs/Byte : %f\n" cost/(2*k*k)


function preprocess()
	ps = 100
        cost = 2*ps*ps*ps

        D = rand(ps,ps)

	gemm!('N','N',1.0,rand(ps,ps),rand(ps,ps),0.0,D)
	#LinearAlgebra.LAPACK.potrf!('L',D)
	#trsm!('L','L','N','N',1.0,rand(ps,ps),D)
end

function run()

        C = generate([k,k],[Shape.General, Properties.SPD])

	Benchmarker.cachescrub()

	preprocess()

	start = time_ns()

	LinearAlgebra.LAPACK.potrf!('L', C)

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
