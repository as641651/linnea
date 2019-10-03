function [res, time] = recommended(s144, M141, M142, v143, v145, M146, M147)
    tic;
    out = s144*((M141)\M142)*v143*transpose(v145)*M146*transpose(M147);    
    time = toc;
    res = {out};
end