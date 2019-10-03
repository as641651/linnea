function [res, time] = recommended(M345, M343, M344, M342)
    tic;
    out = ((M345)\((M343*M344)\M342));    
    time = toc;
    res = {out};
end