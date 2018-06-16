clc;clear;close all;
%[image,inpaint_domain] =  createInpaintBar2(64,64,20,10,2);
%[image,inpaint_domain] =  createInpaintBar2(1024,1024,400,100,30);
%[image,inpaint_domain] =  createInpaintBar2(128,128,50,50,5);
[image,inpaint_domain] =  createInpaintBar2(256,256,100,50,5);
%[image,inpaint_domain] =  createInpaintBar2(512,512,200,100,10);
original_image = double(image+inpaint_domain)/255;
inpaint_domain = inpaint_domain < 1;
image = double(image)/255;
inpaint_domain = double(inpaint_domain);

%variable configuration
lambda = 25;
theta = 1/200;
tolerant = 1e-6;
max_iteration = 1000;
omega = 1.85;
GSiter = 2;
 beta = 1.0e-6;
lambda = lambda*inpaint_domain;

%FIX POINT
disp('Fixed Point')
tic
inpainted_fixedpoint_image = FixedPointInpainter(image,lambda,theta,omega,GSiter,tolerant,max_iteration);
disp('RMSE ')
disp(sqrt(mean((inpainted_fixedpoint_image(:) - original_image(:)).^2))); 
toc
%Split Bergman
disp('Split Bergman')
tic
inpainted_splitbergman_image = SplitBergmanInpainter(image,lambda,theta,omega,GSiter,tolerant,max_iteration);
disp('RMSE ')
disp(sqrt(mean((inpainted_splitbergman_image(:) - original_image(:)).^2))); 
toc