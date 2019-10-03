#include <generator/generator.hpp>

template<typename Gen>
decltype(auto) operand_generator(Gen && gen)
{
    auto M231 = gen.generate({1500,1300}, generator::property::random{}, generator::shape::not_square{});
    auto M232 = gen.generate({1300,1500}, generator::property::random{}, generator::shape::not_square{});
    auto M233 = gen.generate({1600,1300}, generator::property::random{}, generator::shape::not_square{});
    auto M235 = gen.generate({1600,1500}, generator::property::random{}, generator::shape::not_square{});
    auto M234 = gen.generate({1500,1600}, generator::property::random{}, generator::shape::not_square{});
    auto M236 = gen.generate({1500,1600}, generator::property::random{}, generator::shape::not_square{});
    return std::make_tuple(M231, M232, M233, M235, M234, M236);
}