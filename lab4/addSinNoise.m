function output_s = addSinNoise(input_s, A, u0, v0)
[M, N] = size(input_s);
noise = A * sin(2 * pi * (u0 * (0:M-1)' / M + v0 * (0:N-1) / N));
output_s = input_s + noise;
end