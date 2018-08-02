% solve u subproblem using neuman bondary condition
% this code using clamping tecnique to implement neuman bondary condition
function u = uSolver(u,w,original_image,b,lambda,theta,max_gauss_seidel)
    divergence = Divergence(w-b);    
    for k = 1:max_gauss_seidel
        lapacian = imfilter(u,[0,1,0;1,0,1;0,1,0],'replicate');
        u = (1 ./ (lambda + 4*theta)) .* (lambda .*original_image - theta .* divergence + theta .* lapacian);  % remove h^2 for speed improve   
    end
end