% Proj02-02
% (a) reduceIntensityLevel.m
% (b)
A = imread('Fig0221(a)(ctskull-256).tif');
for i = 1:8
    filename = strcat('Proj02-02/', char('i' - i), '.tif');
    imwrite(reduceIntensityLevel(A, 2 ^ i), filename);
end

% Proj02-03
% (a) resizeImage_replication.m
% (b)
B = imread('Fig0220(a)(chronometer 3692x2812  2pt25 inch 1250 dpi).tif');
imwrite(resizeImage_replication(B, 1 / 10), 'Proj02-03/b.tif');
% (c)
C = imread('Proj02-03/b.tif');
imwrite(resizeImage_replication(C, 10), 'Proj02-03/c.tif');

% Proj02-04
% (a) resizeImage_bilinear.m
% (b)
B = imread('Fig0220(a)(chronometer 3692x2812  2pt25 inch 1250 dpi).tif');
imwrite(resizeImage_bilinear(B, 1 / 12.5), 'Proj02-04/b.tif');
% (c)
C = imread('Proj02-04/b.tif');
imwrite(resizeImage_bilinear(C, 12.5), 'Proj02-04/c.tif');