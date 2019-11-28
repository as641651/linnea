using LinearAlgebra.BLAS
using LinearAlgebra
using MatrixGenerator
using Printf
using Random

BLAS.set_num_threads(8)

start = 0.0
finish = 0.0

batch = 1000
#sizes=[200,300,1000]
sizes = Array{Int,1}(undef,20)
for j =1:20
  sizes[j] = 50*j
end

data = [(m,m,m) for i in 1:batch for m in sizes]
data = shuffle(data)
num_runs = size(data)[1]

function preprocess()
	ps = 100
  cost = 2*ps*ps*ps
  D = rand(ps,ps)
	gemm!('N','N',1.0,rand(ps,ps),rand(ps,ps),0.0,D)
end


f = open("quantile_perf.txt","w")


function run()

  c = 0
  for x in data
    c = c+1

    m = x[1]
    n = x[2]
    k = x[3]
    #@printf "Size : %d\t%d\t%d\n" x[1] x[2] x[3]
    A = rand(m,n)
    B = rand(n,k)
    C = Array{Float64}(undef,m,k)
    cost = 2*m*n*k

    gemm!('N','N',1.0,A,B,0.0,C)
    start = time_ns()
    gemm!('N','N',1.0,A,B,0.0,C)
    finish = time_ns()
    times = (finish-start)*1e-9
    flops = cost

    write_times(m,n,k,times,flops)

    if c%100 == 0
      @printf "Completed %d/%d\n" c num_runs
    end
  end
end


function write_times(m,n,k,times,flops)
  s = ""
	s = s*string(m)*"\t"*string(n)*"\t"*string(k)*"\t"*string(times)*"\t"*string(flops)*"\n"
	write(f,s)
end

run()

close(f)
