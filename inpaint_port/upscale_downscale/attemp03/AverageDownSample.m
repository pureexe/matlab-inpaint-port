function result = AverageDownSample(u)
    [n,m]=size(u);
    u = double(u);
    height = floor(n/2);
    width = floor(m/2);
    w=zeros(height,width);
    for i=1:height
        for j=1:width
            w(i,j)=(u(2*i,2*j)+u(2*i,2*j-1)+u(2*i-1,2*j)+u(2*i-1,2*j-1))/4;
        end
    end
    result = uint8(w);
end
