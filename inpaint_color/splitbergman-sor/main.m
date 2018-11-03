clc;clear;close all;

% Load Image
original_image = imread('../../images/color/256/case2_original.png');
inpaint_domain = imread('../../images/color/256/case2_inpaintdomain.png');
toinpaint_image = imread('../../images/color/256/case2_toinpaint.png');
original_image = double(original_image) / 255;
inpaint_domain = double(inpaint_domain) / 255;
toinpaint_image = double(toinpaint_image) / 255;

% variable Defined
lambda = 250;
theta = 5;
omega = 1;

% loop termination properties
tolerant = 10e-4;
multi_fine = 1000;
multi_mid = 3;
multi_coarse = 10;
multi_depth = 1;
max_gauss_seidel = 3; 
depth = 1;

tic;
% inpainted_image = SplitBergmanColorInpainter(toinpaint_image,inpaint_domain,lambda,theta,depth,tolerant,omega,max_gauss_seidel,multi_fine);
inpainted_image = RecursiveColorInpainter(original_image,inpaint_domain,lambda,theta,tolerant,omega,max_gauss_seidel,multi_coarse,multi_mid,multi_fine,multi_depth,1);
toc;
imshow(inpainted_image);
disp("PSNR")
disp(psnr(inpainted_image,original_image))
disp("SSIM")
disp(ssim(inpainted_image,original_image))

imwrite(inpainted_image,'case2.png')