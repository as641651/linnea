#include <generator/generator.hpp>

template<typename Gen>
decltype(auto) operand_generator(Gen && gen)
{
    auto M288 = gen.generate({100,100}, generator::shape::self_adjoint{}, generator::shape::diagonal{}, generator::shape::lower_triangular{}, generator::shape::upper_triangular{}, generator::property::random{});
    auto M289 = gen.generate({100,1500}, generator::property::random{}, generator::shape::not_square{});
    auto M292 = gen.generate({200,100}, generator::property::random{}, generator::shape::not_square{});
    auto M293 = gen.generate({200,1500}, generator::property::random{}, generator::shape::not_square{});
    auto M290 = gen.generate({1500,100}, generator::property::random{}, generator::shape::not_square{});
    auto M291 = gen.generate({1500,100}, generator::property::random{}, generator::shape::not_square{});
    auto M294 = gen.generate({1500,100}, generator::property::random{}, generator::shape::not_square{});
    return std::make_tuple(M288, M289, M292, M293, M290, M291, M294);
}