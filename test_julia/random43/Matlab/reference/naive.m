function [res, time] = naive(M237, M238, M239, M240, M241, M242, M243)
    tic;
    out = M237*inv(M238)*M239*transpose(M240)*inv(M241)*M242*M243;    
    time = toc;
    res = {out};
end