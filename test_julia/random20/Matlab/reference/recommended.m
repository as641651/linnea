function [res, time] = recommended(M105, M106, M107, M108, M104)
    tic;
    out = (((M105)\transpose(M106))+((M107)\transpose(M108))+transpose(M104));    
    time = toc;
    res = {out};
end