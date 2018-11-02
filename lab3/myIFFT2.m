function output = myIFFT2(input)
    [M, N] = size(input);
    output = myFFT2(input')' / (M * N);
end