#include <generator/generator.hpp>

template<typename Gen>
decltype(auto) operand_generator(Gen && gen)
{
    auto M90 = gen.generate({1000,50}, generator::property::random{}, generator::shape::not_square{});
    auto M92 = gen.generate({1000,1000}, generator::shape::lower_triangular{}, generator::property::random{});
    auto M91 = gen.generate({1000,1000}, generator::shape::self_adjoint{}, generator::property::spd{});
    auto M93 = gen.generate({1000,1000}, generator::shape::self_adjoint{}, generator::property::random{});
    auto M94 = gen.generate({50,1000}, generator::property::random{}, generator::shape::not_square{});
    return std::make_tuple(M90, M92, M91, M93, M94);
}