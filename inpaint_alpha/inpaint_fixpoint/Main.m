clc;clear;close all;
[image,inpaint_domain] = createInpaintBar();
inpaint_domain = inpaint_domain > 1;
image = double(image)/255;
inpaint_domain = double(inpaint_domain);

alpha = 10;
  beta = 1.0e-4;
   esp = 1.0e-4;
    omega = 1.6;
 GSmax = 3;
  IMAX = 1000;
  alpha = alpha*inpaint_domain;
 denoised_image = FixedPointInpainter(image,alpha,beta,omega,GSmax,esp,IMAX);
 mesh(denoised_image);