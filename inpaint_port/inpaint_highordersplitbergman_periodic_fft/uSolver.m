function u = uSolver(f,u_tilde,lambda,theta_1,b_u)
    [height,width] = size(f);
     u = (1 ./ (lambda+(theta_1*ones(height,width)))) .* ((lambda .* f) + (theta_1 .* (u_tilde - b_u)));
end