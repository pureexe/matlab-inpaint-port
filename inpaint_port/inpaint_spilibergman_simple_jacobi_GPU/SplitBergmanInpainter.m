%%%%
% inpaint image by using split bergman
% @method SplitBergmanInpainter
% @params Image original_image
% @params Matrix lambda - inpaint domain matrix dot with lambda
% @params double tolerent - break if two image isn't difference too much
% @params int max_iteration - prevent forever loop by force stop if exceed
% @return Image u - Inpainted image 
function u = SplitBergmanInpainter(original_image,lambda,theta,tolerant,max_gauss_seidel,max_iteration)
    original_image = gpuArray(original_image);
    lambda = gpuArray(lambda);
    image_norm = 99999999; 
    i = 1;
    u = original_image;
    [height,width] = size(original_image);
    b = zeros(height*2,width,'gpuArray');
    w = zeros(height*2,width,'gpuArray');
    prev_norm = 0;
    while image_norm > tolerant && i < max_iteration
        last_image = u;
        w = wSolver(u,b,theta); %solve w        
        u = uSolver(u,w,original_image,b,lambda,theta,max_gauss_seidel); %solve u
        b = b + Gradient(u) - w; % update b
        prev_norm = image_norm;
        image_norm = norm(last_image(:)-u(:),2)/norm(u(:),2);
        i = i + 1;
    end
    fprintf('processed with %d loops',i);
    u = gather(u);
end