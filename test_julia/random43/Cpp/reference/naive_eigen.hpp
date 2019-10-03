struct naive_eigen
{
template<typename Type_M237, typename Type_M238, typename Type_M239, typename Type_M240, typename Type_M241, typename Type_M242, typename Type_M243>
decltype(auto) operator()(Type_M237 && M237, Type_M238 && M238, Type_M239 && M239, Type_M240 && M240, Type_M241 && M241, Type_M242 && M242, Type_M243 && M243)
{
    auto out = (M237*(M238).inverse()*M239*(M240).transpose()*(M241).inverse()*M242*M243).eval();
    
typedef std::remove_reference_t<decltype(out)> return_t;
return return_t(out);

}
};