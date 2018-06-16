function u = uTildeGaussSidel(w,u,z,b,lambda,theta,omega,GSiter)
    [height,width] = size(u);
    h = 1;
    D = ZeroPadding(ones(height,width),1);
    G = ZeroPadding(z,1);
    u = ZeroPadding(u,1);
    lambda = ZeroPadding(lambda,1);
    theta_dot_grad_w_b = theta*(Divergence(w,b)); 
    theta_dot_grad_w_b = ZeroPadding(theta_dot_grad_w_b,1);
    for iter=1:GSiter
        for i=2:width+1
            for j=2:height+1
            u(i,j) = (1-omega)*u(i,j)+omega*((lambda(i,j)*G(i,j)-theta_dot_grad_w_b(i,j))+(1/h^2)*...
                (D(i,j)*(u(i+1,j)+u(i,j+1))+D(i-1,j)*u(i-1,j)+D(i,j-1)*u(i,j-1)))/...
                (lambda(i,j)+(1/h^2)*(2*D(i,j)+D(i-1,j)+D(i,j-1)));
            end
        end
    end
    u = UnPadding(u,1); 
end