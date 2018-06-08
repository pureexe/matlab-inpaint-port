%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A MATLAB code to demonstrate the GFP-SOR method for 
% Total Variation denoising model (ROF model)
%
% Min { Tv(u) + (1/2)*lambda*int(u-z)^2 } (*)
%  u
%
% This is equaivalent to solve the following PDE:
%
% -*div[Grad(u)/|Grad(u)|]+lambda*(u-z) = 0
%
% Here u is the image to be recovered 
%      z is the observed image corrupted by the Gaussian noise 
% and  
%      alpha > 0 is the regularization parameter.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [u] = GlobalFixedPointForInpainter(u,z,lambda,beta,omega,GSiter) 
    [n,m] = size(u);
    h = 1;
    D = ZeroPadding(CoefficientD(u,beta),1);
    G = ZeroPadding(z,1);
    u = ZeroPadding(u,1);
    lambda = ZeroPadding(lambda,1);
    for iter=1:GSiter
        for i=2:n+1
            for j=2:m+1
            u(i,j) = (1-omega)*u(i,j)+omega*(lambda(i,j)*G(i,j)+(1/h^2)*...
                (D(i,j)*(u(i+1,j)+u(i,j+1))+D(i-1,j)*u(i-1,j)+D(i,j-1)*u(i,j-1)))/...
                (lambda(i,j)+(1/h^2)*(2*D(i,j)+D(i-1,j)+D(i,j-1)));
            end
        end
    end
    u = UnPadding(u,1);    
end