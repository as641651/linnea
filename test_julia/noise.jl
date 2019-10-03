using LinearAlgebra.BLAS
using LinearAlgebra
using MatrixGenerator
using Printf

BLAS.set_num_threads(8)

start = 0.0
finish = 0.0

batch = 50000
size = 200

n = size
m = size
k = size

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

times = Array{Float64,1}(undef,batch)
sample_times = Array{Float64,1}(undef,batch)


function run()

	Benchmarker.cachescrub()

	preprocess()

	for i = 1:batch
		 start = time_ns()
	   gemm!('N','N',1.0,A,B,0.0,C)
		 finish = time_ns()
		 times[i] = (finish-start)*1e-9
		 sample_times[i] = finish*1e-9
	end

	t_min = minimum(times)
	s_min = minimum(sample_times)
	perf = (cost/t_min)*1e-9

	for i = 1:batch
		times[i] = times[i]-t_min
		sample_times[i] = sample_times[i]-s_min
	end

	println(t_min)
	sleep(3)
end

run()

open("log_noise.txt","w") do f
  s = ""
	for i in 1:batch
	   s = s*string(sample_times[i])*"\t"*string(times[i])*"\n"
	end
	write(f,s)
end
