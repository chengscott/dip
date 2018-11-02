function histVector= imageHist(input)
    histVector = zeros(256, 1, 'single');
    for i = 0:255
        histVector(i + 1) = sum(input(:) == i);
    end
end