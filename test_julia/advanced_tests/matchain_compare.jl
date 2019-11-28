using LinearAlgebra.BLAS
using LinearAlgebra
using MatrixGenerator
using Printf

BLAS.set_num_threads(8)

start = 0.0
finish = 0.0

batch = 5000
s = 100

function preprocess()
	ps = 100
  cost = 2*ps*ps*ps
  D = rand(ps,ps)
	gemm!('N','N',1.0,rand(ps,ps),rand(ps,ps),0.0,D)
end


f = open("quantile_perf.txt","w")

function run()

  @printf "Size : %d\n" s
	A = rand(s,s)
	B = rand(s,s)
  C = rand(s,Int(s/2))
	D = Array{Float64}(undef,s,Int(s/2))
	timesA = Array{Float64,1}(undef,batch)
  timesB = Array{Float64,1}(undef,batch)
	#cost = 3*s*s*s

	Benchmarker.cachescrub()
	preprocess()

	for i = 1:batch
    Benchmarker.cachescrub()
	 	start = time_ns()
   	gemm!('N','N',1.0,B,C,0.0,C)
    gemm!('N','N',1.0,A,C,0.0,D)
	 	finish = time_ns()
	 	timesA[i] = (finish-start)*1e-9
	end

  for i = 1:batch
    Benchmarker.cachescrub()
    start = time_ns()

    gemm!('N','N',1.0,A,B,0.0,B)
    gemm!('N','N',1.0,B,C,0.0,D)
    finish = time_ns()
    timesB[i] = (finish-start)*1e-9
  end

	#for i = 1:batch
	#	perfs[i] = (cost/times[i])*1e-9
	#end

	write_times(timesA,timesB)

end

function write_times(times,perfs)
  s = ""
	for i in 1:batch
	   s = s*string(times[i])*"\t"*string(perfs[i])*"\n"
	end
	write(f,s)
end

run()

close(f)
