struct naive_armadillo
{
template<typename Type_M105, typename Type_M106, typename Type_M107, typename Type_M108, typename Type_M104>
decltype(auto) operator()(Type_M105 && M105, Type_M106 && M106, Type_M107 && M107, Type_M108 && M108, Type_M104 && M104)
{
    auto out = (((M105).i()*(M106).t()+arma::inv_sympd(M107)*(M108).t()+(M104).t())).eval();
    
typedef std::remove_reference_t<decltype(out)> return_t;
return return_t(out);

}
};