clc;clear;close all;
[image,inpaint_domain] = createInpaintBar();
original_image = double(image+inpaint_domain)/255;
inpaint_domain = inpaint_domain < 1;
image = double(image)/255;
inpaint_domain = double(inpaint_domain);

%variable configuration
lambda = 10;
theta_1 = 1; 
theta_2 = 1;
tolerant = 1e-6;
max_iteration = 100;
% apply lambda
lambda = lambda*inpaint_domain;
%variable configuration
tic
inpainted_image = HighOrderSplitBergmanInpainter(image,lambda,theta_1,theta_2,tolerant,max_iteration);
toc
mesh(inpainted_image);