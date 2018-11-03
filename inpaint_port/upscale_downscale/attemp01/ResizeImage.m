function result = ResizeImage(image,height,width)
    result = 0:height*width-1;
    [imageHeight,imageWidth] = size(image);
    rowScale = height/imageHeight;
    colScale = width/imageWidth;
    position = @(pos) image(floor(1/rowScale * mod(pos,height))+1,floor(1/colScale * floor(pos/height))+1);
    result = arrayfun(position,result);
    result = reshape(result,height,width);
end