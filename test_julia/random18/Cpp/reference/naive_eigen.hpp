struct naive_eigen
{
template<typename Type_M99, typename Type_M96, typename Type_M95, typename Type_M97, typename Type_M98>
decltype(auto) operator()(Type_M99 && M99, Type_M96 && M96, Type_M95 && M95, Type_M97 && M97, Type_M98 && M98)
{
    auto out = ((M99+(M96).transpose().inverse()*(M95).inverse()*M97*M98)).eval();
    
typedef std::remove_reference_t<decltype(out)> return_t;
return return_t(out);

}
};