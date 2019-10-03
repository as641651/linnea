struct recommended_armadillo
{
template<typename Type_M109, typename Type_M110, typename Type_M111, typename Type_M112, typename Type_v113>
decltype(auto) operator()(Type_M109 && M109, Type_M110 && M110, Type_M111 && M111, Type_M112 && M112, Type_v113 && v113)
{
    auto out = ((M109).t()*M110*(M111+(M112).t())*v113).eval();
    
typedef std::remove_reference_t<decltype(out)> return_t;
return return_t(out);

}
};