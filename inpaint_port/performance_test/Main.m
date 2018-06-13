clc;clear;close all;
%[image,inpaint_domain] =  createInpaintBar2(64,64,20,10,2);
%[image,inpaint_domain] =  createInpaintBar2(1024,1024,400,100,30);
[image,inpaint_domain] =  createInpaintBar2(256,256,100,50,20);
original_image = double(image+inpaint_domain)/255;
inpaint_domain = inpaint_domain < 1;
image = double(image)/255;
inpaint_domain = double(inpaint_domain);

%variable configuration
lambda = 25;
theta = 0.2;
tolerant = 1e-6;
max_iteration = 1000;
omega = 1.6;
GSiter = 3;
 beta = 1.0e-6;
lambda = lambda*inpaint_domain;

%FIX POINT
disp('Fixed Point')
tic
inpainted_image = FixedPointInpainter(image,lambda,theta,omega,GSiter,tolerant,max_iteration);
disp('RMSE ')
disp(sqrt(mean((inpainted_image(:) - original_image(:)).^2))); 
toc
%Split Bergman
disp('Split Bergman')
tic
inpainted_image = SplitBergmanInpainter(image,lambda,theta,omega,GSiter,tolerant,max_iteration);
disp('RMSE ')
disp(sqrt(mean((inpainted_image(:) - original_image(:)).^2))); 
toc
%inpainted_image = FixedPointInpainter(image,lambda,beta,omega,GSiter,tolerant,max_iteration);