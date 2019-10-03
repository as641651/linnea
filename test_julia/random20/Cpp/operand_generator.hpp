#include <generator/generator.hpp>

template<typename Gen>
decltype(auto) operand_generator(Gen && gen)
{
    auto M105 = gen.generate({1600,1600}, generator::shape::lower_triangular{}, generator::property::random{});
    auto M106 = gen.generate({400,1600}, generator::property::random{}, generator::shape::not_square{});
    auto M107 = gen.generate({1600,1600}, generator::shape::self_adjoint{}, generator::property::spd{});
    auto M108 = gen.generate({400,1600}, generator::property::random{}, generator::shape::not_square{});
    auto M104 = gen.generate({400,1600}, generator::property::random{}, generator::shape::not_square{});
    return std::make_tuple(M105, M106, M107, M108, M104);
}