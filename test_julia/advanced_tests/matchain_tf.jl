using LinearAlgebra.BLAS
using LinearAlgebra
using MatrixGenerator
using Printf

BLAS.set_num_threads(8)

start = 0.0
finish = 0.0

batch = 100
#sizes=[200,300,1000]
sizes = Array{Int,1}(undef,150)
for j =1:150
  sizes[j] = 10*j
end


function preprocess()
	ps = 100
  cost = 2*ps*ps*ps
  D = rand(ps,ps)
	gemm!('N','N',1.0,rand(ps,ps),rand(ps,ps),0.0,D)
end


f = open("quantile_perf.txt","w")

function run()

	for s in sizes
    @printf "Size : %d\n" s
    A = rand(s,s)
    B = rand(s,s)
    C = rand(s,s)
		D = Array{Float64}(undef,s,s)
		times = Array{Float64,1}(undef,batch)
    flops = Array{Float64,1}(undef,batch)
		cost = 4*s*s*s

		Benchmarker.cachescrub()
		preprocess()

		for i = 1:batch
      B = rand(s,s)
      Benchmarker.cachescrub()
		 	start = time_ns()
	   	gemm!('N','N',1.0,A,B,0.0,B)
      gemm!('N','N',1.0,B,C,0.0,D)
		 	finish = time_ns()
		 	times[i] = (finish-start)*1e-9
      flops[i] = cost
		end

		write_times(s,times,flops)
	end
end

function write_times(size,times,flops)
  s = ""
	for i in 1:batch
	   s = s*string(size)*"\t"*string(times[i])*"\t"*string(flops[i])*"\n"
	end
	write(f,s)
end

run()

close(f)
