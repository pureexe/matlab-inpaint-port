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
function image = SemiImplicitTimeMarchingDenoiser(original_image,lambda,beta,tau,tolerent,max_iteration)
    i = 0;
    image_norm = 999999;
    res_norm = 999999;
    image = original_image;
    original_res = TotalVariation(image,beta); 
    original_res_norm = norm(original_res(:),2);
    %Outer Loop
    while i < max_iteration && image_norm > tolerent && res_norm > tolerent 
        disp(i);
        last_image = image;
        image = InnerLoop(image,original_image,lambda,beta,tau);
        res = TotalVariation(image,beta)+(lambda*(image - original_image));
        image = image+tau*res;
        res_norm = norm(res(:),2) / original_res_norm;
        image_norm = norm(last_image(:) - image(:),2);
        i = i + 1;
    end
end
%% Inerloop
% The routine computing the standard SITM method over the image domain [1,N]x[1,N]

function result_image = InnerLoop(image,original_image,lambda,beta,tau)
    [height,width] = size(image);
    N = height*width;
    B = image + tau*original_image;
    Bv = reshape(B,N,1);
    A = TVoperatorForMatrixA(image,beta);
    pre_diagonal = (1+tau)*ones(N,1);
    A = spdiags([pre_diagonal],[0],N,N) + lambda*tau*A;
    uv = A\Bv;
    result_image = reshape(uv,height,width);
end

%% TVoperatorForMatrixA
% The routine computing the TV operator in a spasre matrix form,A=Ax+Ay, 
% over the image domain [1,N]x[1,N]

function Ax = TVoperatorForMatrixA(image,beta)
    h = 1;
    [height,width] = size(image);
    D = CoeffocientD(image,beta);
    N = height*width;
    a1 = zeros(N,1);
    a2 = zeros(N,1);
    a3 = zeros(N,3);
    for row = 1:height
        position = (row-1)*width;
        d = 1*D(1:width-1,row);
        a1(1+position:width-1+position) = -d;
        a3(2+position:width+position) = -d;
        a2(1+position:width-1+position) = d;
        a2(2+position:width+position) = a2(2+position:width+position)+d;
    end
    Ax = spdiags([a1,a2,a3],[-1,0,1],N,N)/(h^2);
end