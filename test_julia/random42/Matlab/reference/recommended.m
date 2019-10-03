function [res, time] = recommended(M231, M232, M233, M235, M234, M236)
    tic;
    out = (M231+transpose(M232))*transpose(M233)*(M235+transpose(M234)+transpose(M236));    
    time = toc;
    res = {out};
end