function w = wSolver(u_tilde,b_w,theta_2)
    grad_u_tilde = Gradiant(u_tilde);
    grad_norm = norm(grad_u_tilde+b_w,2);
    w = max(grad_norm-1/theta_2,0)*(grad_u_tilde+b_w)/grad_norm;
end