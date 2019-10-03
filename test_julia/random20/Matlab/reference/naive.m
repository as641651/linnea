function [res, time] = naive(M105, M106, M107, M108, M104)
    tic;
    out = (inv(M105)*transpose(M106)+inv(M107)*transpose(M108)+transpose(M104));    
    time = toc;
    res = {out};
end