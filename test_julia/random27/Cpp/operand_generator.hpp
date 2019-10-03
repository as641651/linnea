#include <generator/generator.hpp>

template<typename Gen>
decltype(auto) operand_generator(Gen && gen)
{
    double s144 = std::uniform_real_distribution<double>()(gen.rng());
    auto M141 = gen.generate({1700,1700}, generator::shape::lower_triangular{}, generator::property::random{});
    auto M142 = gen.generate({1700,1700}, generator::shape::self_adjoint{}, generator::property::random{});
    auto v143 = gen.generate({1700,1}, generator::property::random{}, generator::shape::col_vector{}, generator::shape::not_square{});
    auto v145 = gen.generate({100,1}, generator::property::random{}, generator::shape::col_vector{}, generator::shape::not_square{});
    auto M146 = gen.generate({100,50}, generator::property::random{}, generator::shape::not_square{});
    auto M147 = gen.generate({500,50}, generator::property::random{}, generator::shape::not_square{});
    return std::make_tuple(s144, M141, M142, v143, v145, M146, M147);
}