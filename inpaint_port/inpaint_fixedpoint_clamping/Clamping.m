%%
% Zero Padding Tecnique
%
function result = Clamping(data,length)
[height,width] = size(data);
append_length = length*2;
result = zeros(height+append_length,width+append_length);
result(1+length:height+length,1+length:width+length) = data;
result(0:append_length,)
end