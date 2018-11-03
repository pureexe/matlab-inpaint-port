function result = UpScale(data)
    [height,width] = size(data);
    result = zeros(height*2,width*2);
    result(1:end/2,1:end/2) = data;
    % result(2:2:end,2:2:end) = data;
end