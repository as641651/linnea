struct recommended_armadillo
{
template<typename Type_M237, typename Type_M238, typename Type_M239, typename Type_M240, typename Type_M241, typename Type_M242, typename Type_M243>
decltype(auto) operator()(Type_M237 && M237, Type_M238 && M238, Type_M239 && M239, Type_M240 && M240, Type_M241 && M241, Type_M242 && M242, Type_M243 && M243)
{
    auto out = (M237*arma::solve(arma::trimatu(M238), M239, arma::solve_opts::fast)*(M240).t()*arma::solve(arma::trimatu(M241), M242, arma::solve_opts::fast)*M243).eval();
    
typedef std::remove_reference_t<decltype(out)> return_t;
return return_t(out);

}
};