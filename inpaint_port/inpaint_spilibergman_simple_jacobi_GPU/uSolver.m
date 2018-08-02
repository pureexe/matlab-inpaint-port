% solve u subproblem using neuman bondary condition
% this code using jacobi technique
function u = uSolver(u,w,original_image,b,lambda,theta,max_jacobi_loop)
    divergence = Divergence(w-b);    
    for k = 1:max_jacobi_loop
        lapacian = imfilter(u,[0,1,0;1,0,1;0,1,0],'replicate');
        u = (1 ./ (lambda + 4*theta)) .* (lambda .*original_image - theta .* divergence + theta .* lapacian);  % remove h^2 for speed improve   
    end
end