function [output_f, H] = addMotionBlur(input_f, T, a, b)
[M, N] = size(input_f);
aubv = a * ((0:M-1) - M/2)' + b * ((0:N-1) - N/2);
H = T .* sinc(aubv) .* exp(-1j * pi * aubv);
output_f = input_f .* H;
end