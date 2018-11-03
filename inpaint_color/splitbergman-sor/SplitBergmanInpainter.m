function u = SplitBergmanInpainter(original_image,inpaint_domain,lambda_value,theta,depth,tolerant,omega,max_gauss_seidel,max_iteration)
    image_norm = 99999999; 
    i = 1;
    u = original_image;
    lambda =  (inpaint_domain < 1)*lambda_value;
    [height,width] = size(original_image);
    b = zeros(height*2,width);
    w = zeros(height*2,width);
    while image_norm > tolerant && i < max_iteration
        last_image = u;
        w = wSolver(u,b,theta,depth); %solve w        
        u = uSolver(u,w,original_image,b,lambda,theta,omega,depth,max_gauss_seidel); %solve u
        b = b + Gradient(u,depth) - w; % update b
        image_norm = norm(last_image(:)-u(:),2)/norm(u(:),2);
        i = i + 1;
    end
    fprintf('processed with %d loops\n',i);
end