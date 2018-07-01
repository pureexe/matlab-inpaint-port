function w = wSolver(u_tilde,b_w,theta_2)
    grad_u_tilde = Gradiant(u_tilde);
    gradB = grad_u_tilde+b_w;
    w = max(abs(gradB)-1./theta_2,0).*sign(gradB);
end