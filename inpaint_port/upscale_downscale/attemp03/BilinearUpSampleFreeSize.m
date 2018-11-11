function result = BilinearUpSampleFreeSize(image,height,width)
    result = uint8(zeros(height,width));
    Upscaled = BilinearUpSample(image);
    if(mod(height,2) == 0 && mod(width,2) == 0)
        result = Upscaled;
    elseif(mod(height,2) == 1 && mod(width,2) == 1)
            result(1:height-1,1:width-1) = Upscaled;
            result(height,1:width-1) = Upscaled(height-1,:);
            result(1:height-1,width) = Upscaled(:,width-1);
            result(height,width) = Upscaled(height-1,width-1);
    elseif(mod(height,2) == 1)
            result(1:height-1,:) = Upscaled;
            result(height,1:width-1) = Upscaled(height,:);
            result(height,width) = Upscaled(height-1,width-1);
    elseif(mod(width,2) == 1)
            result(:,width-1) = Upscaled;
            result(1:height-1,width) = Upscaled(height-1,:);
            result(height,width) = Upscaled(height-1,width-1);
    end
end