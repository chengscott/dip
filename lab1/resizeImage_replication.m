function resizedImage = resizeImage_replication(originalImage, scalingFactor)
% if scalingFactor is integer use faster matrix method
if scalingFactor == floor(scalingFactor) || ...
        (1 / scalingFactor) == floor(1 / scalingFactor)
    % shrink
    if scalingFactor < 1
        s = floor(1 / scalingFactor);
        % matrix indexing
        resizedImage = originalImage(1:s:end, 1:s:end);
    % zoom
    else
        % tensor product method (is explained in the report)
        resizedImage = kron(originalImage, ones(scalingFactor, 'uint8'));
    end
else
    % original image size
    [h, w] = size(originalImage);
    % resized image size
    nh = floor(h * scalingFactor);
    nw = floor(w * scalingFactor);
    resizedImage = zeros(nh, nw);
    for i = 1:nh
        x = ceil(i / scalingFactor);
        for j = 1:nw
            y = ceil(j / scalingFactor);
            resizedImage(i, j) = originalImage(x, y);
        end
    end
    resizedImage = uint8(resizedImage);
end
end