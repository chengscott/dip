function resizedImage = resizeImage_bilinear(originalImage, scalingFactor)
% original image size
[h, w] = size(originalImage);
% resized image size
nh = floor(h * scalingFactor);
nw = floor(w * scalingFactor);
% scaling factor
hs = h / nh;
ws = w / nw;
% allocate output
resizedImage = zeros(nh, nw);
for i = 1:nh
   % x (original) <-> i (resized) coordinate
   x = hs * (i - 1) + 1;
   % the x-axis of neighbors
   x1 = floor(x);
   x2 = min(ceil(x), h);
   dx = x - x1;
   for j = 1:nw
       % y (original) <-> j (resized) coordinate
       y = ws * (j - 1) + 1;
       % the y-axis of neighbors
       y1 = floor(y);
       y2 = min(ceil(y), w);
       dy = y - y1;
       % pixel of 4-neighbors
       orig = [originalImage(x1, y1), originalImage(x1, y2); ...
           originalImage(x2, y1), originalImage(x2, y2)];
       % bilinear interpolation
       resizedImage(i, j) = [1 - dx, dx] * double(orig) * [1 - dy; dy];
   end
end
resizedImage = uint8(resizedImage);
end