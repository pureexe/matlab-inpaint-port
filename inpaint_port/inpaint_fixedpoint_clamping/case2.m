clc;clear;close all;
image = imread('case2_toinpaint.png');
inpaint_domain = imread('case2_inpaintdomain.png');
original_image = imread('case2_original.png');
original_image = double(original_image) / 255;
inpaint_domain = inpaint_domain < 1;
image = double(image)/255;
inpaint_domain = double(inpaint_domain);

lambda = 250;
  beta = 1.0e-6;
   esp = 1.0e-4;
    omega = 1.6;
 GSmax = 3;
  IMAX = 1000000;
  lambda = lambda*inpaint_domain;
  tic;
 denoised_image = FixedPointInpainter(image,lambda,beta,omega,GSmax,esp,IMAX);
 toc
 mesh(denoised_image);
 imwrite(denoised_image,'case2_result_fixpoint.png');
 disp("PSNR")
 disp(psnr(denoised_image,original_image));
 disp("SSIM")
 disp(ssim(denoised_image,original_image))