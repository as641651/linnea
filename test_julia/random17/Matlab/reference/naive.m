function [res, time] = naive(M90, M92, M91, M93, M94)
    tic;
    out = (M90+M92*M91*M93*transpose(M94));    
    time = toc;
    res = {out};
end