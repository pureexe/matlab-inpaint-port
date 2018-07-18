function u_tilde = uTildeSolver(u_tilde,w,u,b_u,b_w,theta_1,theta_2)
    theta = theta_2 / theta_1;
    G = (u+b_u) - theta* Divergence(w,b_w);
    [height,width] = size(u_tilde);
    zeta = FourierZeta(height,width,theta);
    u_tilde = real(ifft2(fft2(G)./zeta));
end