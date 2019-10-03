#include <generator/generator.hpp>

template<typename Gen>
decltype(auto) operand_generator(Gen && gen)
{
    auto M99 = gen.generate({100,100}, generator::shape::self_adjoint{}, generator::property::spd{});
    auto M96 = gen.generate({100,100}, generator::shape::upper_triangular{}, generator::property::random{});
    auto M95 = gen.generate({100,100}, generator::shape::lower_triangular{}, generator::property::random{});
    auto M97 = gen.generate({100,250}, generator::property::random{}, generator::shape::not_square{});
    auto M98 = gen.generate({250,100}, generator::property::random{}, generator::shape::not_square{});
    return std::make_tuple(M99, M96, M95, M97, M98);
}