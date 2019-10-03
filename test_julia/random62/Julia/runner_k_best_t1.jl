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
include("experiments/algorithm9.jl")
include("experiments/algorithm10.jl")
include("experiments/algorithm11.jl")
include("experiments/algorithm12.jl")
include("experiments/algorithm13.jl")
include("experiments/algorithm14.jl")
include("experiments/algorithm15.jl")
include("experiments/algorithm16.jl")
include("experiments/algorithm17.jl")
include("experiments/algorithm18.jl")
include("experiments/algorithm19.jl")
include("experiments/algorithm20.jl")
include("experiments/algorithm21.jl")
include("experiments/algorithm22.jl")
include("experiments/algorithm23.jl")
include("experiments/algorithm24.jl")
include("experiments/algorithm25.jl")
include("experiments/algorithm26.jl")
include("experiments/algorithm27.jl")
include("experiments/algorithm28.jl")
include("experiments/algorithm29.jl")
include("experiments/algorithm30.jl")
include("experiments/algorithm31.jl")
include("experiments/algorithm32.jl")
include("experiments/algorithm33.jl")
include("experiments/algorithm34.jl")
include("experiments/algorithm35.jl")
include("experiments/algorithm36.jl")
include("experiments/algorithm37.jl")
include("experiments/algorithm38.jl")
include("experiments/algorithm39.jl")
include("experiments/algorithm40.jl")
include("experiments/algorithm41.jl")
include("experiments/algorithm42.jl")
include("experiments/algorithm43.jl")
include("experiments/algorithm44.jl")
include("experiments/algorithm45.jl")
include("experiments/algorithm46.jl")
include("experiments/algorithm47.jl")
include("experiments/algorithm48.jl")
include("experiments/algorithm49.jl")
include("experiments/algorithm50.jl")
include("experiments/algorithm51.jl")
include("experiments/algorithm52.jl")
include("experiments/algorithm53.jl")
include("experiments/algorithm54.jl")
include("experiments/algorithm55.jl")
include("experiments/algorithm56.jl")
include("experiments/algorithm57.jl")
include("experiments/algorithm58.jl")
include("experiments/algorithm59.jl")
include("experiments/algorithm60.jl")
include("experiments/algorithm61.jl")
include("experiments/algorithm62.jl")
include("experiments/algorithm63.jl")
include("experiments/algorithm64.jl")
include("experiments/algorithm65.jl")
include("experiments/algorithm66.jl")
include("experiments/algorithm67.jl")
include("experiments/algorithm68.jl")
include("experiments/algorithm69.jl")
include("experiments/algorithm70.jl")
include("experiments/algorithm71.jl")
include("experiments/algorithm72.jl")
include("experiments/algorithm73.jl")
include("experiments/algorithm74.jl")
include("experiments/algorithm75.jl")
include("experiments/algorithm76.jl")
include("experiments/algorithm77.jl")
include("experiments/algorithm78.jl")
include("experiments/algorithm79.jl")
include("experiments/algorithm80.jl")
include("experiments/algorithm81.jl")
include("experiments/algorithm82.jl")
include("experiments/algorithm83.jl")
include("experiments/algorithm84.jl")
include("experiments/algorithm85.jl")
include("experiments/algorithm86.jl")
include("experiments/algorithm87.jl")
include("experiments/algorithm88.jl")
include("experiments/algorithm89.jl")
include("experiments/algorithm90.jl")
include("experiments/algorithm91.jl")
include("experiments/algorithm92.jl")
include("experiments/algorithm93.jl")
include("experiments/algorithm94.jl")
include("experiments/algorithm95.jl")
include("experiments/algorithm96.jl")
include("experiments/algorithm97.jl")
include("experiments/algorithm98.jl")
include("experiments/algorithm99.jl")
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
    result = collect(algorithm9(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm10(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm11(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm12(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm13(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm14(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm15(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm16(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm17(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm18(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm19(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm20(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm21(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm22(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm23(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm24(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm25(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm26(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm27(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm28(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm29(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm30(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm31(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm32(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm33(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm34(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm35(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm36(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm37(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm38(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm39(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm40(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm41(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm42(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm43(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm44(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm45(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm46(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm47(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm48(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm49(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm50(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm51(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm52(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm53(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm54(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm55(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm56(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm57(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm58(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm59(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm60(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm61(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm62(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm63(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm64(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm65(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm66(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm67(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm68(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm69(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm70(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm71(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm72(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm73(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm74(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm75(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm76(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm77(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm78(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm79(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm80(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm81(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm82(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm83(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm84(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm85(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm86(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm87(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm88(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm89(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm90(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm91(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm92(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm93(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm94(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm95(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm96(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm97(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm98(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
    test_result = isapprox(result, result_recommended, rtol=1e-3)
    @test test_result # this somehow avoids too much memory being used                                         
    result = collect(algorithm99(map(MatrixGenerator.unwrap, map(copy, matrices))...)[1])
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
    Benchmarker.add_data(plotter, ["algorithm9"; 1], Benchmarker.measure(3, algorithm9, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm10"; 1], Benchmarker.measure(3, algorithm10, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm11"; 1], Benchmarker.measure(3, algorithm11, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm12"; 1], Benchmarker.measure(3, algorithm12, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm13"; 1], Benchmarker.measure(3, algorithm13, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm14"; 1], Benchmarker.measure(3, algorithm14, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm15"; 1], Benchmarker.measure(3, algorithm15, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm16"; 1], Benchmarker.measure(3, algorithm16, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm17"; 1], Benchmarker.measure(3, algorithm17, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm18"; 1], Benchmarker.measure(3, algorithm18, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm19"; 1], Benchmarker.measure(3, algorithm19, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm20"; 1], Benchmarker.measure(3, algorithm20, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm21"; 1], Benchmarker.measure(3, algorithm21, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm22"; 1], Benchmarker.measure(3, algorithm22, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm23"; 1], Benchmarker.measure(3, algorithm23, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm24"; 1], Benchmarker.measure(3, algorithm24, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm25"; 1], Benchmarker.measure(3, algorithm25, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm26"; 1], Benchmarker.measure(3, algorithm26, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm27"; 1], Benchmarker.measure(3, algorithm27, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm28"; 1], Benchmarker.measure(3, algorithm28, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm29"; 1], Benchmarker.measure(3, algorithm29, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm30"; 1], Benchmarker.measure(3, algorithm30, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm31"; 1], Benchmarker.measure(3, algorithm31, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm32"; 1], Benchmarker.measure(3, algorithm32, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm33"; 1], Benchmarker.measure(3, algorithm33, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm34"; 1], Benchmarker.measure(3, algorithm34, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm35"; 1], Benchmarker.measure(3, algorithm35, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm36"; 1], Benchmarker.measure(3, algorithm36, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm37"; 1], Benchmarker.measure(3, algorithm37, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm38"; 1], Benchmarker.measure(3, algorithm38, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm39"; 1], Benchmarker.measure(3, algorithm39, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm40"; 1], Benchmarker.measure(3, algorithm40, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm41"; 1], Benchmarker.measure(3, algorithm41, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm42"; 1], Benchmarker.measure(3, algorithm42, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm43"; 1], Benchmarker.measure(3, algorithm43, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm44"; 1], Benchmarker.measure(3, algorithm44, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm45"; 1], Benchmarker.measure(3, algorithm45, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm46"; 1], Benchmarker.measure(3, algorithm46, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm47"; 1], Benchmarker.measure(3, algorithm47, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm48"; 1], Benchmarker.measure(3, algorithm48, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm49"; 1], Benchmarker.measure(3, algorithm49, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm50"; 1], Benchmarker.measure(3, algorithm50, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm51"; 1], Benchmarker.measure(3, algorithm51, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm52"; 1], Benchmarker.measure(3, algorithm52, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm53"; 1], Benchmarker.measure(3, algorithm53, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm54"; 1], Benchmarker.measure(3, algorithm54, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm55"; 1], Benchmarker.measure(3, algorithm55, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm56"; 1], Benchmarker.measure(3, algorithm56, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm57"; 1], Benchmarker.measure(3, algorithm57, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm58"; 1], Benchmarker.measure(3, algorithm58, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm59"; 1], Benchmarker.measure(3, algorithm59, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm60"; 1], Benchmarker.measure(3, algorithm60, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm61"; 1], Benchmarker.measure(3, algorithm61, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm62"; 1], Benchmarker.measure(3, algorithm62, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm63"; 1], Benchmarker.measure(3, algorithm63, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm64"; 1], Benchmarker.measure(3, algorithm64, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm65"; 1], Benchmarker.measure(3, algorithm65, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm66"; 1], Benchmarker.measure(3, algorithm66, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm67"; 1], Benchmarker.measure(3, algorithm67, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm68"; 1], Benchmarker.measure(3, algorithm68, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm69"; 1], Benchmarker.measure(3, algorithm69, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm70"; 1], Benchmarker.measure(3, algorithm70, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm71"; 1], Benchmarker.measure(3, algorithm71, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm72"; 1], Benchmarker.measure(3, algorithm72, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm73"; 1], Benchmarker.measure(3, algorithm73, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm74"; 1], Benchmarker.measure(3, algorithm74, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm75"; 1], Benchmarker.measure(3, algorithm75, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm76"; 1], Benchmarker.measure(3, algorithm76, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm77"; 1], Benchmarker.measure(3, algorithm77, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm78"; 1], Benchmarker.measure(3, algorithm78, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm79"; 1], Benchmarker.measure(3, algorithm79, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm80"; 1], Benchmarker.measure(3, algorithm80, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm81"; 1], Benchmarker.measure(3, algorithm81, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm82"; 1], Benchmarker.measure(3, algorithm82, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm83"; 1], Benchmarker.measure(3, algorithm83, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm84"; 1], Benchmarker.measure(3, algorithm84, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm85"; 1], Benchmarker.measure(3, algorithm85, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm86"; 1], Benchmarker.measure(3, algorithm86, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm87"; 1], Benchmarker.measure(3, algorithm87, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm88"; 1], Benchmarker.measure(3, algorithm88, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm89"; 1], Benchmarker.measure(3, algorithm89, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm90"; 1], Benchmarker.measure(3, algorithm90, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm91"; 1], Benchmarker.measure(3, algorithm91, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm92"; 1], Benchmarker.measure(3, algorithm92, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm93"; 1], Benchmarker.measure(3, algorithm93, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm94"; 1], Benchmarker.measure(3, algorithm94, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm95"; 1], Benchmarker.measure(3, algorithm95, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm96"; 1], Benchmarker.measure(3, algorithm96, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm97"; 1], Benchmarker.measure(3, algorithm97, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm98"; 1], Benchmarker.measure(3, algorithm98, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["algorithm99"; 1], Benchmarker.measure(3, algorithm99, map(MatrixGenerator.unwrap, matrices)...) );
    Benchmarker.add_data(plotter, ["naive_julia"; 1], Benchmarker.measure(3, naive, matrices...) );
    Benchmarker.add_data(plotter, ["recommended_julia"; 1], Benchmarker.measure(3, recommended, matrices...) );
    Benchmarker.finish(plotter);
    @info("Benchmarks complete")
end

main()
