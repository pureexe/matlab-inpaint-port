% solve u subproblem using neuman bondary condition
% this code using clamping tecnique to implement neuman bondary condition
function u = uSolver(u,w,original_image,b,lambda,theta)
    h = 1; % discrete lapacian
    [height,width] = size(u);
    divergence = Divergence(w-b);
    for i = 1:height
        for j = 1:width        
            u_left = Clamper(u,i,j-1);
            u_right = Clamper(u,i,j+1);
            u_above = Clamper(u,i-1,j);
            u_under = Clamper(u,i+1,j);
            lapacian = (1/h^2)*(u_left+u_right+u_above+u_under);
            if lambda(i,j) == 0 %avoid divied by zero
                coefficient = 0;
            else
                coefficient = theta / lambda(i,j);
            end            
            buffer = original_image(i,j) - (coefficient * (divergence(i,j)  -  lapacian)); 
            u(i,j) = (lambda(i,j)*h^2)/(lambda(i,j)*h^2 - 4*theta) * buffer;
        end
    end
end