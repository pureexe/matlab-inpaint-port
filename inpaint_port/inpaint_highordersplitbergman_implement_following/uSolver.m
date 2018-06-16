function u = uSolver(f,u_tilde,lambda,theta_1,b_u)
    [height,width] = size(f);
    u = (1 ./ ((-theta_1*ones(height,width)) - lambda)) .* (lambda .* f + theta_1.*(b_u - u_tilde));
end