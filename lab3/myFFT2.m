function output = myFFT2(input)
    [M, N] = size(input);
    lgM = int32(log2(M));
    lgN = int32(log2(N));
    lgMN = max(lgM, lgN);
    % bit reversal permutation matrix
    Pm = eye(M);
    Pm = Pm(bitrevorder(1:M), :);
    Pn = eye(N);
    Pn = Pn(bitrevorder(1:N), :);
    % factorization
    AMN = cell(1, lgMN);
    A = eye(M);
    for m = 1:lgMN
        n = double(2 ^ m);
        Im = eye(n / 2);
        Om = diag(exp(-2j * pi * (0:n/2-1) / n));
        Am = kron(eye(M / n), [Im Om; Im -Om]);
        A = Am * A;
        AMN{m} = A;
    end
    % row 1D FFT
    FM = AMN{lgM} * Pm;
    % column 1D FFT
    FN = AMN{lgN} * Pn;
    % 2D FFT
    output = FM * input * FN;
end
