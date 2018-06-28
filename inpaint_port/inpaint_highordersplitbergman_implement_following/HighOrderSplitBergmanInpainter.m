function u = HighOrderSplitBergmanInpainter(original_image,lambda,theta_1,theta_2,tolerant,max_iteration)
    image_norm = 99999999;
    i = 0;
    u = original_image;
    [height,width] = size(original_image);
    u_tilde = zeros(height,width);
    b_u = zeros(height,width);
    b_w = zeros(height*2,width);
    while image_norm > tolerant && i < max_iteration
        disp(i);
        last_image = u;
        u = uSolver(original_image,u_tilde,lambda,theta_1,b_u);
        w = wSolver(u_tilde,b_w,theta_2);
        u_tilde = uTildeGaussSidel(w,u_tilde,u+b_u,b_w,lambda,theta_2/theta_1,1.6,3);%uTildeSolver(u_tilde,w,u,b_u,b_w,theta_1,theta_2);
        b_u = b_u + u_tilde - u;
        b_w = b_w + w - Gradiant(u_tilde);
        image_norm = norm(last_image(:)-u(:),2)/norm(u(:),2);
        i = i + 1;
    end
    disp('exit norm')
    disp(image_norm)
end