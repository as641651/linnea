struct recommended_eigen
{
template<typename Type_M231, typename Type_M232, typename Type_M233, typename Type_M235, typename Type_M234, typename Type_M236>
decltype(auto) operator()(Type_M231 && M231, Type_M232 && M232, Type_M233 && M233, Type_M235 && M235, Type_M234 && M234, Type_M236 && M236)
{
    auto out = ((M231+(M232).transpose())*(M233).transpose()*(M235+(M234).transpose()+(M236).transpose())).eval();
    
typedef std::remove_reference_t<decltype(out)> return_t;
return return_t(out);

}
};