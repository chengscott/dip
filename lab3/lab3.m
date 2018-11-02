% Proj04-01
% (a) Original
A = imread('Fig0429(a)(blown_ic).tif');
imwrite(A, 'Proj04-01/a.tif');
% (b) padding zero
[M, N] = size(A);
B = zeros(2 * M, 2 * N, 'uint8');
B(1:M, 1:N) = A;
imwrite(B, 'Proj04-01/b.tif');
% (c) (-1)^(x + y) mask
[M, N] = size(B);
B = im2single(B);
Bmask = ((-1) .^ (0:M-1))' * (-1) .^ (0:N-1);
C = B .* Bmask;
imwrite(im2uint8(C), 'Proj04-01/c.tif');
% (d) 2D DFT
D = myDFT2(C);
imwrite(Fspectrum(D), 'Proj04-01/d.tif');
% (e) Gaussian lowpass filter
E = myGLPF(40, M, N);
imwrite(im2uint8(E), 'Proj04-01/e.tif');
% (f) apply GLPF
F = D .* E;
imwrite(im2uint8(F), 'Proj04-01/f.tif');
% (g) (-1)^(x + y) unmask
G = myIDFT2(F);
G = G .* Bmask;
imwrite(im2uint8(G), 'Proj04-01/g.tif');
% (h) unpadding
H = im2uint8(G);
H = H(1:M/2, 1:N/2);
imwrite(H, 'Proj04-01/h.tif');

% Proj04-02
% (b) Fourier spectrum
A = imread('Fig0441(a)(characters_test_pattern).tif');
[M, N] = size(A);
[B, ~] = fwdDFT(A);
imwrite(Fspectrum(B), 'Proj04-02/b.tif');
% (c) mean vs DC coefficient
originalMean = mean2(A);
dftMean = abs(B(M + 1, N + 1)) / M / N * 255;

% Proj04-03
A = imread('Fig0441(a)(characters_test_pattern).tif');
% perform 2D DFT on A
[F, mask] = fwdmDFT(A);
[M, N] = size(F);
% apply GLPF on F
glfp = myGLPF(100, M, N);
F = F .* glfp;
% (b)
B = bwdDFT(F .* ILPF(10, M, N), mask);
imwrite(B, 'Proj04-03/b.tif');
% (c)
C = bwdDFT(F .* ILPF(30, M, N), mask);
imwrite(C, 'Proj04-03/c.tif');
% (d)
D = bwdDFT(F .* ILPF(60, M, N), mask);
imwrite(D, 'Proj04-03/d.tif');
% (e)
E = bwdDFT(F .* ILPF(160, M, N), mask);
imwrite(E, 'Proj04-03/e.tif');
% (f)
F = bwdDFT(F .* ILPF(460, M, N), mask);
imwrite(F, 'Proj04-03/f.tif');

% Proj04-04
A = imread('Fig0441(a)(characters_test_pattern).tif');
% perform 2D DFT
[F, mask] = fwdDFT(A);
[M, N] = size(F);
% (b)
B = bwdDFT(F .* myGHPF(60, M, N), mask);
imwrite(B, 'Proj04-04/b.tif');
% (e)
E = bwdDFT(F .* myGHPF(160, M, N), mask);
imwrite(E, 'Proj04-04/e.tif');

% Proj04-05
A = imread('Fig0457(a)(thumb_print).tif');
% perform 2D DFT
[F, mask] = fwdDFT(A);
[M, N] = size(F);
% (b) apply GHPF and perform 2D IDFT
B = bwdDFT(F .* myGHPF(60, M, N), mask);
imwrite(B, 'Proj04-05/b.tif');
% (c)
imwrite(B > 0, 'Proj04-05/c.tif');

function Fs = Fspectrum(F)
    % return the Fourier specturm of F
    % down scale frequency F by taking log
    Fs = log(1 + abs(F));
    mFs = max(Fs(:));
    Fs = im2uint8(Fs / mFs);
end

% 2D DFT helper function
% with padding zero and (-1) mask
function [F, mask] = fwdDFT(f)
    [M, N] = size(f);
    % padding zero
    F = zeros(2 * M, 2 * N, 'uint8');
    F(1:M, 1:N) = f;
    F = im2single(F);
    % (-1) mask
    mask = ((-1) .^ (0:2*M-1))' * (-1) .^ (0:2*N-1);
    % DFT
    F = myDFT2(F .* mask);
end

% 2D DFT helper function
% with padding mirror and (-1) mask
function [F, mask] = fwdmDFT(f)
    [M, N] = size(f);
    % padding mirror
    F = [f f; f f];
    F = im2single(F);
    % (-1) mask
    mask = ((-1) .^ (0:2*M-1))' * (-1) .^ (0:2*N-1);
    % DFT
    F = myDFT2(F .* mask);
end

% 2D IDFT helper function
% with (-1) unmask and unpadding
function f = bwdDFT(F, mask)
    [M, N] = size(F);
    % (-1) unmask
    f = myIDFT2(F) .* mask;
    % unpadding
    f = f(1:M/2, 1:N/2);
    f = im2uint8(f);
end

% Ideal Low-Pass Filter helper function
% r: radius
% M * N: filter size
function mask = ILPF(r, M, N)
    % (m, n) center
    m = int32(M / 2);
    n = int32(N / 2);
    % M * N filter size
    M = int32(M);
    N = int32(N);
    mask = zeros(M, N, 'single');
    r2 = r * r;
    for u = 1:M
        for v = 1:N
            d2 = single((u - m) ^ 2 + (v - n) ^ 2);
            % if distance square < radius square
            if d2 <= r2
                mask(u, v) = 1;
            end
        end
    end
end