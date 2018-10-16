function quantizedImage = reduceIntensityLevel(originalImage, intensityLevel)
    % current level: 256
    % target level: intensityLevel
    factor = 256 / intensityLevel;
    % reduce the intensity level
    quantizedImage = idivide(originalImage, factor, 'floor');
    % rescale the intensity level
    quantizedImage = quantizedImage * factor;
end