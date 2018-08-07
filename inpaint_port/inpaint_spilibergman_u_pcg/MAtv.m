function [A,Ax,Ay]=MAtv(u)
[m,n] = size(u);
D = ones(m,n);
h = 1;
N = n*m;
a1=zeros(N,1);
a2=zeros(N,1);
a3=zeros(N,1);
for j=1:m
    j0=(j-1)*n;
    d=1*D(1:n-1,j);
    a1(1+j0:n-1+j0)=-d;
    a3(2+j0:n+j0)=-d;
    a2(1+j0:n-1+j0)=d;
    a2(2+j0:n+j0)=a2(2+j0:n+j0)+d;
end
Ax = spdiags([a1,a2,a3],[-1,0,1],N,N)/(h^2);
b1 = zeros(N,1);
b2 = zeros(N,1);
b3 = zeros(N,1);
d1 = -1*reshape(D(:,1:m-1),(m-1)*n,1);

b1(1:(m-1)*n)=d1;
b3(n+1:N)=d1;
b2(n+1:N,1)=-d1;
b2(1:n*(m-1),1)=b2(1:n*(m-1),1)-d1;
Ay = spdiags([b1,b2,b3],[-n,0,n],N,N)/(h^2);
 A = (Ax+Ay);