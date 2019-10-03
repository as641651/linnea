#include <generator/generator.hpp>

template<typename Gen>
decltype(auto) operand_generator(Gen && gen)
{
    auto M109 = gen.generate({1150,1300}, generator::property::random{}, generator::shape::not_square{});
    auto M110 = gen.generate({1150,1150}, generator::shape::self_adjoint{}, generator::shape::diagonal{}, generator::shape::lower_triangular{}, generator::shape::upper_triangular{}, generator::property::random{});
    auto M111 = gen.generate({1150,150}, generator::property::random{}, generator::shape::not_square{});
    auto M112 = gen.generate({150,1150}, generator::property::random{}, generator::shape::not_square{});
    auto v113 = gen.generate({150,1}, generator::property::random{}, generator::shape::col_vector{}, generator::shape::not_square{});
    return std::make_tuple(M109, M110, M111, M112, v113);
}