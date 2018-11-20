function [output_f, Notch] = notchFiltering(input_f, D0, u0, v0)
[M, N] = size(input_f);
Notch = ones(M, N, 'single');
for u = 1:M
    for v = 1:N
        d1 = (u - M / 2 - u0) ^ 2 + (v - N / 2 - v0) ^ 2;
        d2 = (u - M / 2 + u0) ^ 2 + (v - N / 2 + v0) ^ 2;
        if d1 <= D0 ^2 || d2 <= D0 ^ 2
            Notch(u, v) = 0;
        end
    end
end
output_f = input_f .* Notch;
end