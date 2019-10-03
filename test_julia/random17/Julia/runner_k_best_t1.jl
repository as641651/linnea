using Test
using Logging
using MatrixGenerator

using LinearAlgebra.BLAS
BLAS.set_num_threads(1)

include("operand_generator.jl")
include("experiments/algorithm0.jl")
include("experiments/algorithm1.jl")
include("experiments/algorithm2.jl")
include("experiments/algorithm3.jl")
include("experiments/algorithm4.jl")
include("experiments/algorithm5.jl")
include("experiments/algorithm6.jl")
include("experiments/algorithm7.jl")
include("experiments/algorithm8.jl")
include("reference/naive.jl")
include("reference/recommended.jl")

function main()
    matrices = operand_generator()

    @info("Performing Test run...")
    result_naive = collect(naive(map(copy, matrices)...)[1])
    result_recommended = collect(recommended(map(copy, matrices)...)[1])
    test_result = isapprox(result_naive, result_recommended, rtol=1e-3)
    @test test_result
    result = collect(algorithm0(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm1(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm2(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm3(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm4(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm5(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm6(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm7(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm8(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    @info("Test run performed successfully")

    n = 2000
    rand(n, n)*rand(n, n) # this seems to help to reduce some startup noise

    @info("Running Benchmarks...")
    plotter = Benchmarker.Plot("julia_results_tmp", ["algorithm"; "threads"]);
    Benchmarker.add_data(plotter, ["algorithm0"; 1], Benchmarker.measure(3, algorithm0, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm1"; 1], Benchmarker.measure(3, algorithm1, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm2"; 1], Benchmarker.measure(3, algorithm2, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm3"; 1], Benchmarker.measure(3, algorithm3, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm4"; 1], Benchmarker.measure(3, algorithm4, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm5"; 1], Benchmarker.measure(3, algorithm5, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm6"; 1], Benchmarker.measure(3, algorithm6, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm7"; 1], Benchmarker.measure(3, algorithm7, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm8"; 1], Benchmarker.measure(3, algorithm8, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["naive_julia"; 1], Benchmarker.measure(3, naive, matrices...) );
    Benchmarker.add_data(plotter, ["recommended_julia"; 1], Benchmarker.measure(3, recommended, matrices...) );
    Benchmarker.finish(plotter);
    @info("Benchmarks complete")
end

main()
