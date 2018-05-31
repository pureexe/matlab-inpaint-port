%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Model: Min { Tv(u) + (1/2)*lambda*(u-f)^2 }
%
% This is equaivalent to solve the following PDE:
%
% -div[Grad(u)/|Grad(u)|]+lambda(u-f) = 0
%
% Here u is the image to be recovered 
%      f is the observed image corrupted by the Gaussian noise 
% and  
%      lambda > 0 is the regularization parameter.
function image = ExplicitTimeMarchingDenoiser(original_image,lambda,beta,tau,tolerent,max_iteration)
    i = 0;
    image_norm = 999999;
    res_norm = 999999;
    image = original_image;
    original_res = TotalVariation(image,beta);  %another path is cancled itself;
    original_res_norm = norm(original_res(:),2);
    while i < max_iteration && image_norm > tolerent && res_norm > tolerent 
        last_image = image;
        res = TotalVariation(image,beta)+(lambda*(image - original_image));
        image = image+tau*res;
        res_norm = norm(res(:),2) / original_res_norm;
        image_norm = norm(last_image(:) - image(:),2);
        i = i + 1;
    end
end
    