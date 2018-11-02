% Proj03-01
input = imread('Fig0338(a)(blurry_moon).tif');
input = single(input) ./ 255;
% a) logTransform.m
output_a = logTransform(input);
imwrite(uint8(output_a .* 255), 'Proj03-01/log.tif');
% b) powerlawTransform.m
g = [0.25 0.5 1 1.25 2 4];
for i = 1:size(g, 2)
    output_b = powerlawTransform(input, g(i));
    filename = strcat('Proj03-01/power-', num2str(g(i)), '.tif');
    imwrite(uint8(output_b .* 255), filename);
end

% Proj03-02
input = imread('Fig0338(a)(blurry_moon).tif');
% a) imageHist.m
input_hist = imageHist(input);
p = plot(input_hist);
xlim([1, 256]);
saveas(p, 'Proj03-02/histogram.jpg');
% b) histEqualization.m
[output, T] = histEqualization(input);
imwrite(output, 'Proj03-02/enhanced.tif');
output_hist = imageHist(output);
p = plot(output_hist);
xlim([1, 256]);
saveas(p, 'Proj03-02/enhanced_histogram.jpg');
p = stairs(T);
xlim([1, 256]);
ylim([0, 255]);
saveas(p, 'Proj03-02/transform.jpg');

% Proj03-03, Proj03-04
input = imread('Fig0338(a)(blurry_moon).tif');
input = single(input) ./ 255;
% laplacianFiltering.m
lap1 = [0 1 0; 1 -4 1; 0 1 0];
lap2 = [1 1 1; 1 -8 1; 1 1 1];
lap3 = [0 -1 0; -1 4 -1; 0 -1 0];
lap4 = [-1 -1 -1; -1 8 -1; -1 -1 -1];
[output, lp] = laplacianFiltering(input, lap1, -1);
imwrite(uint8(lp .* 255), 'Proj03-03/b.jpg');
imwrite(uint8(output .* 255), 'Proj03-03/c.jpg');
[output, ~] = laplacianFiltering(input, lap2, -1);
imwrite(uint8(output .* 255), 'Proj03-03/d.jpg');
