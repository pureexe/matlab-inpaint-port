D=Dga(u,n,m,beta,lambda);
%keyboard;
lambda2=lambda^2;
for iter=1:3
uold=u;
un(1,1)=(z(1,1)+alpha*(D(1,1)*(u(2,1)+lambda2*u(1,2))...
))/(1+alpha*((1+lambda2)*D(1,1)));
if n>2
for i=2:n-1
un(i,1)=(z(i,1)+alpha*(D(i,1)*(u(i+1,1)+lambda2*u(i,2))+D(i-1,1)*u(i-1,1)))...
/(1+alpha*((1+lambda2)*D(i,1)+D(i-1,1)));
end
end
un(n,1)=(z(n,1)+alpha*(D(n,1)*(lambda2*u(n,2))+D(n-1,1)*u(n-1,1)))...
/(1+alpha*(lambda2*D(n,1)+D(n-1,1)));
if m>2
for j=2:m-1
un(1,j)=(z(1,j)+alpha*(D(1,j)*(u(2,j)+lambda2*u(1,j+1))+D(1,j-1)...
*lambda2*u(1,j-1)))/(1+alpha*((1+lambda2)*D(1,j)+lambda2*D(1,j-1)));
for i=2:n-1
un(i,j)=(z(i,j)+alpha*(D(i,j)*(u(i+1,j)+lambda2*u(i,j+1))+D(i-1,j)*u(i-1,j)+D(i,j-1)...
*lambda2*u(i,j-1)))/(1+alpha*((1+lambda2)*D(i,j)+D(i-1,j)+lambda2*D(i,j-1)));
end
un(n,j)=(z(n,j)+alpha*(D(n,j)*(lambda2*u(n,j+1))+D(n-1,j)*u(n-1,j)+D(n,j-1)...
*lambda2*u(n,j-1)))/(1+alpha*(lambda2*D(n,j)+D(n-1,j)+lambda2*D(n,j-1)));
end
end
un(1,m)=(z(1,m)+alpha*(D(1,m)*(u(2,m))+D(1,m-1)...
*lambda2*u(1,m-1)))/(1+alpha*(D(1,m)+lambda2*D(1,m-1)));
if n>2
for i=2:n-1
un(i,m)=(z(i,m)+alpha*(D(i,m)*(u(i+1,m))+D(i-1,m)*u(i-1,m)+D(i,m-1)...
*lambda2*u(i,m-1)))/(1+alpha*(D(i,m)+D(i-1,m)+lambda2*D(i,m-1)));
end
end
un(n,m)=(z(n,m)+alpha*(D(n-1,m)*u(n-1,m)+D(n,m-1)...
*lambda2*u(n,m-1)))/(1+alpha*(D(n-1,m)+lambda2*D(n,m-1)));

%udiff=norm(reshape(uold-u,n*m,1));
%fprintf('dyn res(%2d)=%6.3e\n',iter,udiff);
%if udiff<2
%break
%end
u=.7*un+.3*u;

end%%%%%%%%%%%%%it