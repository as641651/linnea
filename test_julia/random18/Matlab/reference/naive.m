function [res, time] = naive(M99, M96, M95, M97, M98)
    tic;
    out = (M99+inv(transpose(M96))*inv(M95)*M97*M98);    
    time = toc;
    res = {out};
end