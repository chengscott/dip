function output_f = wienerFiltering(input_f, H, K)
W = conj(H) ./ (conj(H) .* H + K);
output_f = input_f .* W;
end