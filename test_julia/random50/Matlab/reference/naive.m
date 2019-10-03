function [res, time] = naive(M278, M279, M280, M281, M282)
    tic;
    out = M278*transpose(M279)*transpose(M280)*(M281+transpose(M282));    
    time = toc;
    res = {out};
end