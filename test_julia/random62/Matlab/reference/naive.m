function [res, time] = naive(M345, M343, M344, M342)
    tic;
    out = inv(M345)*inv(M343*M344)*M342;    
    time = toc;
    res = {out};
end