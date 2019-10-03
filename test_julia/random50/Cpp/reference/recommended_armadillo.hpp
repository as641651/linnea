struct recommended_armadillo
{
template<typename Type_M278, typename Type_M279, typename Type_M280, typename Type_M281, typename Type_M282>
decltype(auto) operator()(Type_M278 && M278, Type_M279 && M279, Type_M280 && M280, Type_M281 && M281, Type_M282 && M282)
{
    auto out = (M278*(M279).t()*(M280).t()*(M281+(M282).t())).eval();
    
typedef std::remove_reference_t<decltype(out)> return_t;
return return_t(out);

}
};