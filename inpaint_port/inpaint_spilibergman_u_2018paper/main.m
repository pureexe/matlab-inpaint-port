%% **section 1:** intial test image
% clear all previous run variable and windows
clc;clear;close all;
%create image
[image,inpaint_domain] =  CreateInpaintBar(64,64,20,10,2);
%change image domain [0 - 255] to [0 - 1]
original_image = double(image+inpaint_domain)/255;
inpaint_domain = inpaint_domain < 1;
image = double(image)/255;
inpaint_domain = double(inpaint_domain);

%% ** section 2:** testing
lambda = 250/1;
theta = 0.1; % in publication use little gamma insted
max_gauss_seidel = 10;
omega = 1.3;
tolerant = 5*1e-4;
max_iteration = 1000; % force stop compute if iteration exceed to prevent forever loop

%merge lambda with inpaint domain
lambda = lambda * inpaint_domain;

tic;
inpainted_splitbergman_image = SplitBergmanInpainter(image,lambda,theta,tolerant,omega,max_gauss_seidel,max_iteration);
toc %processed time measurement

disp('RMSE ')
disp(sqrt(mean((inpainted_splitbergman_image(:) - original_image(:)).^2))); 
disp('PSNR')
disp(psnr(inpainted_splitbergman_image,original_image))

figure
subplot(1,3,1);
imshow(original_image)
title('Original')
axis square

subplot(1,3,2);
imshow(inpainted_splitbergman_image)
title('Inpainted image')
axis square

subplot(1,3,3);
mesh(inpainted_splitbergman_image)
title('Surface of the inpainted domain')
axis square