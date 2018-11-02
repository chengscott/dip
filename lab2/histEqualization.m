function [output, T] = histEqualization(input)
    % histogram
    his = imageHist(input);
    % probability mass function
    p = his / sum(his);
    % transform function (cdf)
    T = zeros(256, 1);
    ti = 0;
    for i = 1:256
        T(i) = ti + 255 * p(i);
        ti = T(i);
    end
    % transform input image
    [w, h] = size(input);
    output = zeros(w, h, 'uint8');
    for i = 1:w
        for j = 1:h
            output(i, j) = round(T(input(i, j) + 1));
        end
    end
    T = uint8(T);
end