function output = myIDFT2(input)
    [M, N] = size(input);
    % row 1D DFT
    fm = exp(-2j * pi * ((0:M-1)' * (0:M-1)) / M);
    % column 1D DFT
    fn = exp(-2j * pi * ((0:N-1)' * (0:N-1)) / N);
    % 2D IDFT
    output = fm' * (input / (M * N)) * fn';
end