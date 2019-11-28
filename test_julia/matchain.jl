using LinearAlgebra.BLAS
using LinearAlgebra
using MatrixGenerator
using Printf

BLAS.set_num_threads(8)

start = 0.0
finish = 0.0

batch = 100
#sizes=[200,300,1000]
sizes = Array{Int,1}(undef,200)
for j =1:200
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
		cost = 4*s*s*s

		Benchmarker.cachescrub()
		preprocess()

		for i = 1:batch
      Benchmarker.cachescrub()
		 	start = time_ns()
	   	gemm!('N','N',1.0,A,B,0.0,B)
      gemm!('N','N',1.0,B,C,0.0,D)
		 	finish = time_ns()
		 	times[i] = (finish-start)*1e-9
		end

		#for i = 1:batch
		#	times[i] = (cost/times[i])*1e-9
		#end

		write_times(s,times)
	end
end

function write_times(size,times)
  s = ""
	for i in 1:batch
	   s = s*string(size)*"\t"*string(times[i])*"\n"
	end
	write(f,s)
end

run()

close(f)
