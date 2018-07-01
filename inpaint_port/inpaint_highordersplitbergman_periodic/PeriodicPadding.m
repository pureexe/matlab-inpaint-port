% Padding
function result = PeriodicPadding(data,n)
    [height,width] = size(data);
    result = zeros(height+2*n,width+2*n);
    result(n+1:height+n,n+1:width+n) = data;
    result(n+1:height+n,1:n) = data(:,width - n + 1:width); % [W]
    result(n+1:height+n,width+n+1:width+2*n) = data(:,1:n); %[E]
    result(1:n,1:n) = data(height - n + 1:height,width - n + 1:width); %[NW]
    result(1:n,n+1:width+n) = data(height - n + 1:height,:);  %[N]
    result(1:n,width+n+1:width+2*n) = data(height - n + 1:height,1:n);  %[NE]
    result(height+n+1:height+2*n,1:n) = data(1:n,width - n + 1:width); %[SW]
    result(height+n+1:height+2*n,n+1:width+n) = data(1:n,:); %[S]
    result(height+n+1:height+2*n,width+n+1:width+2*n) = data(1:n,1:n); %[SE]
end