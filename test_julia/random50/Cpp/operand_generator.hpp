#include <generator/generator.hpp>

template<typename Gen>
decltype(auto) operand_generator(Gen && gen)
{
    auto M278 = gen.generate({1800,1800}, generator::shape::self_adjoint{}, generator::property::random{});
    auto M279 = gen.generate({300,1800}, generator::property::random{}, generator::shape::not_square{});
    auto M280 = gen.generate({1950,300}, generator::property::random{}, generator::shape::not_square{});
    auto M281 = gen.generate({1950,200}, generator::property::random{}, generator::shape::not_square{});
    auto M282 = gen.generate({200,1950}, generator::property::random{}, generator::shape::not_square{});
    return std::make_tuple(M278, M279, M280, M281, M282);
}