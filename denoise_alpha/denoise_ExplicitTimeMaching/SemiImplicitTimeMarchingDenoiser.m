function image = SemiImplicitTimeMarchingDenoiser(original_image,alpha,beta,tau,tolerent,max_iteration)
    i = 0;
    image_norm = 999999;
    res_norm = 999999;
    image = original_image;
    original_res = alpha*TotalVariation(image,beta); 
    original_res_norm = norm(original_res(:),2);
    % outer loop
    while  i < max_iteration && image_norm > tolerent && res_norm > tolerent 
        last_image = image;
        image = InnerLoop(image,original_image,alpha,tau,beta);
        res = alpha*TotalVariation(image,beta)+(original_image-image);
        res_norm = norm(res(:),2)/original_res_norm;
        image_norm = norm(last_image(:)-image(:),2)/norm(image(:),2); 
        i = i+1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The routine computing the TV operator in a spasre matrix form,A=Ax+Ay, 
% over the image domain [1,N]x[1,N]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [A,Ax,Ay]=MAtv(image,beta)
[height,width] = size(image);
D = CoefficientD(image,beta);
h = 1;
N = height*width;
a1=zeros(N,1);
a2=zeros(N,1);
a3=zeros(N,1);
for j=1:width
    j0=(j-1)*height;
    d=1*D(1:height-1,j);
    a1(1+j0:height-1+j0)=-d;
    a3(2+j0:height+j0)=-d;
    a2(1+j0:height-1+j0)=d;
    a2(2+j0:height+j0)=a2(2+j0:height+j0)+d;
end
Ax = spdiags([a1,a2,a3],[-1,0,1],N,N)/(h^2);
b1 = zeros(N,1);
b2 = zeros(N,1);
b3 = zeros(N,1);
d1 = -1*reshape(D(:,1:width-1),(width-1)*height,1);

b1(1:(width-1)*height)=d1;
b3(height+1:N)=d1;
b2(height+1:N,1)=-d1;
b2(1:height*(width-1),1)=b2(1:height*(width-1),1)-d1;
Ay = spdiags([b1,b2,b3],[-height,0,height],N,N)/(h^2);
 A = (Ax+Ay);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The routine computing the standard SITM method over the image domain 
% [1,N]x[1,N]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
function [u] = InnerLoop(u,z,alpha,tau,beta)
    [height,width] = size(u);
    B = u + tau*z;
   Bv = reshape(B,height*width,1);
    A = MAtv(u,beta);
 Dia0 = (1+tau)*ones(height*width,1);
    A = spdiags([Dia0],[0],height*width,height*width) + alpha*tau*A;
   uv = A\Bv;
    u = reshape(uv,height,width); 
end