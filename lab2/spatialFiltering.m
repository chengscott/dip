function output = spatialFiltering(input, mask)
    [w, h] = size(input);
    [mw, mh] = size(mask);
    mwc = floor(mw / 2);
    mwh = floor(mh / 2);
    output = zeros(w, h, 'single');
    for x = 1:w
        for y = 1:h
            for s = -mwc:(mw - mwc - 1)
                for t = -mwh:(mh - mwh - 1)
                    v = 0;
                    if (x - s) >= 1 && (y - t) >= 1 && (x - s) <= w && (y - t) <= h
                        v = input(x - s, y - t);
                    end
                    output(x, y) = output(x,y) + mask(s + mwc + 1, t + mwh + 1) * v;
                end
            end
        end
    end
end