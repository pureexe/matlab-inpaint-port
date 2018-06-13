clc;clear;close all;
[image,inpaint_domain] = createInpaintBar();
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
% apply lambda
lambda = lambda*inpaint_domain;

inpainted_image = SplitBergmanInpainter(image,lambda,theta,omega,GSiter,tolerant,max_iteration);

mesh(inpainted_image);