function [res, time] = recommended(M99, M96, M95, M97, M98)
    tic;
    out = (M99+((transpose(M96))\((M95)\M97))*M98);    
    time = toc;
    res = {out};
end