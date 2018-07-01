%%
% Zero Padding Tecnique
%
function result = ZeroPadding(data,length)
[height,width] = size(data);
append_length = length*2;
result = zeros(height+append_length,width+append_length);
result(1+length:height+length,1+length:width+length) = data;
end