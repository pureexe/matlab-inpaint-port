function[w]=rest1(u)
%full weighting
[n,m]=size(u);
v=extend(u,1);
for i=1:n/2,
    for j=1:m/2,
        w(i,j)=(9*(v(2*i+1,2*j+1)+v(2*i+1,2*j)+v(2*i,2*j+1)+v(2*i,2*j))+3*(v(2*i,2*j-1)...
            + v(2*i+1,2*j-1)+v(2*i+2,2*j)+v(2*i-1,2*j)+v(2*i+2,2*j+1)+...
            v(2*i-1,2*j+1)+v(2*i,2*j+2)+v(2*i+1,2*j+2))+v(2*i+2,2*j+2)+v(2*i+2,2*j-1)+...
            v(2*i-1,2*j+2)+v(2*i-1,2*j-1))/64;
    end
end
