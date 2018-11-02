function output = myGLPF(D0, M, N)
    % (m, n) center
    m = int32(M / 2);
    n = int32(N / 2);
    % M * N: filter size
    M = int32(M);
    N = int32(N);
    output = zeros(M, N, 'single');
    k = 2 * D0 * D0;
    for u = 1:M
        for v = 1:N
            d2 = single((u - m) ^ 2 + (v - n) ^ 2);
            output(u, v) = exp(-d2 / k);
        end
    end
end