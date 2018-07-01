% This is U solver of SB1 using gauss-saidel, but by chaning input
% Parameter, it equal with u-tilde solver;
function u = uTildeGaussSidel(w,u,z,b,lambda,theta,omega,GSiter)
    u = PeriodicPadding(u,1);
    z = PeriodicPadding(z,1);
    lambda = PeriodicPadding(lambda,1);
    [n,m] = size(u);
    h = 1;
    D = ones(n,m);
    G = z;
	theta_dot_grad_w_b = theta*(Divergence(w,b)); 
    theta_dot_grad_w_b = PeriodicPadding(theta_dot_grad_w_b,1);
    for iter=1:GSiter
        for j=2:m-1
            for i=2:n-1    
                u(i,j) = (1-omega)*u(i,j)+omega*((lambda(i,j)*G(i,j)-theta_dot_grad_w_b(i,j))+(1/h^2)*...
                        (D(i,j)*(u(i+1,j)+u(i,j+1))+D(i-1,j)*u(i-1,j)+D(i,j-1)*u(i,j-1)))/...
                        (lambda(i,j)+(1/h^2)*(2*D(i,j)+D(i-1,j)+D(i,j-1)));
            end
       end
    end
    u = UnPadding(u,1);
end