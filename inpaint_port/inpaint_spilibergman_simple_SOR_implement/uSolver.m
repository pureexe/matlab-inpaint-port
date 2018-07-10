% solve u subproblem using neuman bondary condition
% this code using clamping tecnique to implement neuman bondary condition
function u = uSolver(u,w,original_image,b,lambda,theta,omega,max_gauss_seidel)
    h = 1; % discrete lapacian
    [height,width] = size(u);
    divergence = Divergence(w-b);
    for k = 1:max_gauss_seidel
        for i = 1:height
            for j = 1:width        
                u_left = Clamper(u,i,j-1);
                u_right = Clamper(u,i,j+1);
                u_above = Clamper(u,i-1,j);
                u_under = Clamper(u,i+1,j);
                lapacian = (1/h^2)*(u_left+u_right+u_above+u_under);
                buffer = lambda(i,j)*original_image(i,j) - theta*divergence(i,j)+theta*lapacian; 
                % u(i,j) = ((h^2)/(lambda(i,j)*h^2 + 4*theta))*buffer; % gauss-seidel
                u(i,j) = (1-omega)*u(i,j)+omega*(((h^2)/(lambda(i,j)*h^2 + 4*theta))*buffer); %SOR
            end
        end
    end
end