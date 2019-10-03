function [res, time] = naive(M288, M289, M292, M293, M290, M291, M294)
    tic;
    out = (M288*M289+transpose(M292)*M293+transpose(M290)+transpose(M291)+transpose(M294));    
    time = toc;
    res = {out};
end