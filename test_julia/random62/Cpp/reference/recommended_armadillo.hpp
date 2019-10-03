struct recommended_armadillo
{
template<typename Type_M345, typename Type_M343, typename Type_M344, typename Type_M342>
decltype(auto) operator()(Type_M345 && M345, Type_M343 && M343, Type_M344 && M344, Type_M342 && M342)
{
    auto out = (arma::solve(M345, arma::solve(M343*M344, M342, arma::solve_opts::fast), arma::solve_opts::fast)).eval();
    
typedef std::remove_reference_t<decltype(out)> return_t;
return return_t(out);

}
};