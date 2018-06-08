%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A MATLAB code to demonstrate the GFP method for Total Variation denoising 
% model (ROF model)
%
% Min { alpha*Tv(u) + (1/2)*int(u-z)^2 } (*)
%  u
%
% This is equaivalent to solve the following PDE:
%
% -alpha*div[Grad(u)/|Grad(u)|]+(u-z) = 0
%
% Here u is the image to be recovered 
%      z is the observed image corrupted by the Gaussian noise 
% and  
%      alpha is the regularization parameter.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [image]=FixedPointDenoiser(original_image,lambda,beta,omega,GSiter,tolerent,max_iteration)
    i = 0;
    image_norm = 999999;
    res_norm = 999999;
    image = original_image;
    original_res = TotalVariation(image,beta); 
    original_res_norm = norm(original_res(:),2);
    while i < max_iteration && image_norm > tolerent && res_norm > tolerent 
        last_image = image;
        image = GlobalFixedPointForInpainter(image,original_image,lambda,beta,omega,GSiter); 
        res = TotalVariation(image,beta)+(original_image - image);
        res_norm = norm(res(:),2)/original_res_norm;
        image_norm = norm(last_image(:)-image(:),2)/norm(image(:),2); 
        i = i + 1;
    end
end
