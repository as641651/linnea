using MatrixGenerator
include("operand_generator.jl")
using LinearAlgebra.BLAS
using LinearAlgebra

BLAS.set_num_threads(24)

NUM_REPS = 20
THRESH = 0.8

matrices = operand_generator()

function compare(f1, f2)
  count = 0
  for i = 1:NUM_REPS
    if rand()>0.5
      t1 = run(f1)
      t2 = run(f2)
    else
      t2 = run(f2)
      t1 = run(f1)
    end

    if t1 > t2
      count += 1
    end
    println((t1-t2))
  end
  prob = count/NUM_REPS
  best = f1
  if prob >=0.8
    best = f2
  end
  println(prob)
  return best
end


function run(f)
  Benchmarker.set_cachescrub_size(804000)
  Benchmarker.cachescrub()

  start = time_ns()
  f(map(MatrixGenerator.unwrap, map(copy, matrices))...)
  finish = time_ns()
  t = (finish - start)*1e-9
  println(f, " Time : ", t)
  #sleep(1)
  return t
end

include("experiments/algorithm0.jl")
include("experiments/algorithm12.jl")

best = compare(algorithm0, algorithm12)
println(best)
