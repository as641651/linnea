struct naive_armadillo
{
template<typename Type_s144, typename Type_M141, typename Type_M142, typename Type_v143, typename Type_v145, typename Type_M146, typename Type_M147>
decltype(auto) operator()(Type_s144 && s144, Type_M141 && M141, Type_M142 && M142, Type_v143 && v143, Type_v145 && v145, Type_M146 && M146, Type_M147 && M147)
{
    auto out = (s144*(M141).i()*M142*v143*(v145).t()*M146*(M147).t()).eval();
    
typedef std::remove_reference_t<decltype(out)> return_t;
return return_t(out);

}
};