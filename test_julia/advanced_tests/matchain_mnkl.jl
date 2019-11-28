using LinearAlgebra.BLAS
using LinearAlgebra
using MatrixGenerator
using Printf

BLAS.set_num_threads(8)

start = 0.0
finish = 0.0

batch = 20
#sizes=[200,300,1000]
sizes = Array{Int,1}(undef,10)
for j =1:10
  sizes[j] = 100*j
end


function preprocess()
	ps = 100
  cost = 2*ps*ps*ps
  D = rand(ps,ps)
	gemm!('N','N',1.0,rand(ps,ps),rand(ps,ps),0.0,D)
end


f = open("quantile_perf.txt","w")

function run()

	for m in sizes
    for n in sizes
      for k in sizes
        for l in sizes
          @printf "Size : %d\t%d\t%d\t%d\n" m n k l
          A = rand(m,n)
          B = rand(n,k)
          C = rand(k,l)
          tmp = Array{Float64}(undef,m,k)
		      D = Array{Float64}(undef,m,l)
      		times = Array{Float64,1}(undef,batch)
          flops = Array{Float64,1}(undef,batch)
      		cost = 2*m*n*k + 2*m*k*l

      		Benchmarker.cachescrub()
      		preprocess()

      		for i = 1:batch
            Benchmarker.cachescrub()
      		 	start = time_ns()
      	   	gemm!('N','N',1.0,A,B,0.0,tmp)
            gemm!('N','N',1.0,tmp,C,0.0,D)
      		 	finish = time_ns()
      		 	times[i] = (finish-start)*1e-9
            flops[i] = cost
      		end

          write_times(m,n,k,l,times,flops)
        end #l
       end #k
     end #n
 end #m
end

function write_times(m,n,k,l,times,flops)
  s = ""
	for i in 1:batch
	   s = s*string(m)*"\t"*string(n)*"\t"*string(k)*"\t"*string(l)*"\t"*string(times[i])*"\t"*string(flops[i])*"\n"
	end
	write(f,s)
end

run()

close(f)
