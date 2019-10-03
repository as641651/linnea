#include <generator/generator.hpp>

template<typename Gen>
decltype(auto) operand_generator(Gen && gen)
{
    auto M237 = gen.generate({400,400}, generator::shape::lower_triangular{}, generator::property::random{});
    auto M238 = gen.generate({400,400}, generator::shape::upper_triangular{}, generator::property::random{});
    auto M239 = gen.generate({400,400}, generator::shape::self_adjoint{}, generator::property::spd{});
    auto M240 = gen.generate({150,400}, generator::property::random{}, generator::shape::not_square{});
    auto M241 = gen.generate({150,150}, generator::shape::upper_triangular{}, generator::property::random{});
    auto M242 = gen.generate({150,50}, generator::property::random{}, generator::shape::not_square{});
    auto M243 = gen.generate({50,1300}, generator::property::random{}, generator::shape::not_square{});
    return std::make_tuple(M237, M238, M239, M240, M241, M242, M243);
}