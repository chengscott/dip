function psnr = computePSNR(input1_s, input2_s)
[M, N] = size(input1_s);
S = sum(sum((input1_s - input2_s) .^ 2));
psnr = 10 * log10(M * N / S);
end