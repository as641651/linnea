struct naive_armadillo
{
template<typename Type_M288, typename Type_M289, typename Type_M292, typename Type_M293, typename Type_M290, typename Type_M291, typename Type_M294>
decltype(auto) operator()(Type_M288 && M288, Type_M289 && M289, Type_M292 && M292, Type_M293 && M293, Type_M290 && M290, Type_M291 && M291, Type_M294 && M294)
{
    auto out = ((M288*M289+(M292).t()*M293+(M290).t()+(M291).t()+(M294).t())).eval();
    
typedef std::remove_reference_t<decltype(out)> return_t;
return return_t(out);

}
};