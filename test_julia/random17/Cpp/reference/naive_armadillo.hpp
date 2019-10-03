struct naive_armadillo
{
template<typename Type_M90, typename Type_M92, typename Type_M91, typename Type_M93, typename Type_M94>
decltype(auto) operator()(Type_M90 && M90, Type_M92 && M92, Type_M91 && M91, Type_M93 && M93, Type_M94 && M94)
{
    auto out = ((M90+M92*M91*M93*(M94).t())).eval();
    
typedef std::remove_reference_t<decltype(out)> return_t;
return return_t(out);

}
};