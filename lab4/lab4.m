% Proj05-03
A = imread('Fig0526(a)(original_DIP).tif');
A = im2single(A);
% (2) add sinusoidal noises
B = addSinNoise(A, 0.5, 150, 150);
imwrite(im2uint8(B), 'Proj05-03/2.tif');
% (3) image in frequency domain
F = fftshift(fft2(B));
Fs = Fspectrum(F);
imwrite(Fs, 'Proj05-03/3.tif');
% (4) notch filter
[Fn, notch] = notchFiltering(F, 5, 150, 150);
imwrite(im2uint8(notch), 'Proj05-03/4.tif');
% (5) iamge applied filter in frequency domain
Fns = Fspectrum(Fn);
imwrite(Fns, 'Proj05-03/5.tif');
% (6) denoised image
D = ifft2(ifftshift(Fn));
D = real(D);
imwrite(im2uint8(D), 'Proj05-03/6.tiff');
% (7) psnr
computePSNR(A, D)

% Proj05-04
A = imread('Fig0526(a)(original_DIP).tif');
A = im2single(A);
% (b) motion blur
F = fftshift(fft2(A));
[Fb, H] = addMotionBlur(F, 1, 0.1, 0.1);
B = ifft2(ifftshift(Fb));
B = real(B);
imwrite(im2uint8(B), 'Proj05-04/b.tif');
% (c) add sinusoidal noises
[M, N] = size(B);
C = addSinNoise(B, 0.5, 150, 150);
imwrite(im2uint8(C), 'Proj05-04/c.tif');
% (d) apply wiener filter
F = fftshift(fft2(C));
w1 = wienerFiltering(F, H, 0.0001);
f1 = real(ifft2(ifftshift(w1)));
w2 = wienerFiltering(F, H, 0.001);
f2 = real(ifft2(ifftshift(w2)));
w3 = wienerFiltering(F, H, 0.01);
f3 = real(ifft2(ifftshift(w3)));
imwrite(im2uint8(f1), 'Proj05-04/d1.tif');
imwrite(im2uint8(f2), 'Proj05-04/d2.tif');
imwrite(im2uint8(f3), 'Proj05-04/d3.tif');
computePSNR(f1, A)
computePSNR(f2, A)
computePSNR(f3, A)

function Fs = Fspectrum(F)
    % return the Fourier specturm of F
    % down scale frequency F by taking log
    Fs = log(1 + abs(F));
    mFs = max(Fs(:));
    Fs = im2uint8(Fs / mFs);
end