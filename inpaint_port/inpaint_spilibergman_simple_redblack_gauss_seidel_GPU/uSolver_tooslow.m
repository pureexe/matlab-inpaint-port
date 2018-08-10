% solve u subproblem using neuman bondary condition
% this code using jacobi technique
function u = uSolver(u,w,original_image,b,lambda,theta,max_jacobi_loop)

    function data = gauss_kernel(position,state)
        data = (1 ./ (lambda(position) + 4*theta)) .* (lambda(position) .*original_image(position) - theta .* divergence(position) + theta .* lapacian(position));     
    end

    function data = red(position)
        data = gauss_kernel(position,1);
    end

    function data = black(position)
        data = gauss_kernel(position,0);
    end

    [height,width] = size(original_image);
    count_node = width*height;   
    divergence = Divergence(w-b);  
    u = reshape(u,count_node,1);
    iteration_vector = [1:count_node];
    lambda = reshape(lambda,count_node,1);
    original_image = reshape(original_image,count_node,1);
    divergence = reshape(divergence,count_node,1);
    for k = 1:max_jacobi_loop
        % red state
        u_laplace = reshape(u,height,width);
        lapacian = imfilter(u_laplace,[0,1,0;1,0,1;0,1,0],'replicate');
        lapacian = reshape(lapacian,count_node,1);
        u = arrayfun(@red, iteration_vector);
        %black state
        u_laplace = reshape(u,height,width);
        lapacian = imfilter(u_laplace,[0,1,0;1,0,1;0,1,0],'replicate');
        lapacian = reshape(lapacian,count_node,1);
        u = arrayfun(@black, iteration_vector);
    end
    u = reshape(u,height,width);
end