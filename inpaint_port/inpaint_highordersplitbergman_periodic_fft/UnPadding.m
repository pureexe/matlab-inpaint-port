%%
% Remove Padding of matrix
%
function result = UnPadding(data,length)
[height,width] = size(data);
result = data(1+length:height-length,1+length:width-length);
end