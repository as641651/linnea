struct recommended_armadillo
{
template<typename Type_M99, typename Type_M96, typename Type_M95, typename Type_M97, typename Type_M98>
decltype(auto) operator()(Type_M99 && M99, Type_M96 && M96, Type_M95 && M95, Type_M97 && M97, Type_M98 && M98)
{
    auto out = ((M99+arma::solve(trimatl((M96).t()), arma::solve(trimatl(M95), M97, arma::solve_opts::fast), arma::solve_opts::fast)*M98)).eval();
    
typedef std::remove_reference_t<decltype(out)> return_t;
return return_t(out);

}
};