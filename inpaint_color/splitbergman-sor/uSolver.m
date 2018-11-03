% solve u subproblem using neuman bondary condition
% this code using clamping tecnique to implement neuman bondary condition
function u = uSolver(u,w,original_image,b,lambda,theta,omega,depth,max_gauss_seidel)
    [height,width] = size(u);
    divergence = Divergence(w-b,depth);
    for k = 1:max_gauss_seidel
        % top-left corner
        u(1,1) = uGaussKernel(u(1,1),original_image(1,1),lambda(1,1),theta,divergence(1,1),omega,depth,u(1,1),u(1,2),u(1,1),u(2,1));
        % top-bar line
        for i = 2:width-1
            u(1,i) = uGaussKernel(u(1,i),original_image(1,i),lambda(1,i),theta,divergence(1,i),omega,depth,u(1,i-1),u(1,i+1),u(1,i),u(2,i));
        end
        % top-right corner
        u(1,width) = uGaussKernel(u(1,width),original_image(1,width),lambda(1,width),theta,divergence(1,width),omega,depth,u(1,width-1),u(1,width),u(1,width),u(2,width));
        % body
        for i = 2:height-1
            %body-front
            u(i,1) = uGaussKernel(u(i,1),original_image(i,1),lambda(i,1),theta,divergence(i,1),omega,depth,u(i,1),u(i,2),u(i-1,1),u(i+1,1));
            %body-interior
            for j = 2:width-1
                u(i,j) = uGaussKernel(u(i,j),original_image(i,j),lambda(i,j),theta,divergence(i,j),omega,depth,u(i,j-1), u(i,j+1),u(i-1,j),u(i+1,j));
            end
            %body-rear
            u(i,width) = uGaussKernel(u(i,width),original_image(i,width),lambda(i,width),theta,divergence(i,width),omega,depth,u(i,width-1),u(i,width),u(i-1,width),u(i+1,width));
        end
        % bottom-left
        u(height,1) = uGaussKernel(u(height,1),original_image(height,1),lambda(height,1),theta,divergence(height,1),omega,depth,u(height,1),u(height,2),u(height-1,1),u(height,1));
        % bottom-bar line
        for i = 2:width-1
            u(height,i) = uGaussKernel(u(height,i),original_image(height,i),lambda(height,i),theta,divergence(height,i),omega,depth,u(height,i-1),u(height,i+1),u(height-1,i),u(height,i));
        end
        % bottom-right
        u(height,width) = uGaussKernel(u(height,width),original_image(height,width),lambda(height,width),theta,divergence(height,width),omega,depth,u(height,width -1),u(height,width),u(height-1,width),u(height,width));
    end
end