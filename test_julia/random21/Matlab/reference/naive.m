function [res, time] = naive(M109, M110, M111, M112, v113)
    tic;
    out = transpose(M109)*M110*(M111+transpose(M112))*v113;    
    time = toc;
    res = {out};
end