function result = ResizeImage(inputImage,height,width)
    result = 0:height*width-1;
    [imageHeight,imageWidth] = size(inputImage);
    rowScale = height/imageHeight;
    colScale = width/imageWidth;
    position = @(pos) inputImage(floor(1/rowScale * mod(pos,height))+1,floor(1/colScale * floor(pos/height))+1);
    result = arrayfun(position,result);
    result = reshape(result,height,width);
end