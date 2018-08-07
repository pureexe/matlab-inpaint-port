% solve u subproblem using neuman bondary condition
% this code using clamping tecnique to implement neuman bondary condition
function u = uSolver(u,w,original_image,b,lambda,theta,max_gauss_seidel)
    [height,width] = size(u);
    A = MAtv(u);
    %keyboard
    divergence = Divergence(w-b);  
    %lapacian = imfilter(u,[0,1,0;1,0,1;0,1,0],'replicate');
    lambda_spare = spdiags([lambda(:)],[0],height*width,height*width);
    
    A = lambda_spare - (theta .* A);
    B = lambda.*original_image - theta.*divergence;
    B = B(:);
    u = pcg(A,B,1e-4,1000,[],[],u(:));
    u = reshape(u,[height,width]);
end