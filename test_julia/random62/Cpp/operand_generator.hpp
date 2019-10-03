#include <generator/generator.hpp>

template<typename Gen>
decltype(auto) operand_generator(Gen && gen)
{
    auto M345 = gen.generate({1650,1650}, generator::shape::self_adjoint{}, generator::property::spd{});
    auto M343 = gen.generate({1650,1700}, generator::property::random{}, generator::shape::not_square{});
    auto M344 = gen.generate({1700,1650}, generator::property::random{}, generator::shape::not_square{});
    auto M342 = gen.generate({1650,1650}, generator::shape::upper_triangular{}, generator::property::random{});
    return std::make_tuple(M345, M343, M344, M342);
}