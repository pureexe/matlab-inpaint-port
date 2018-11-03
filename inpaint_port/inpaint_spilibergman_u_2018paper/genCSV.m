%% **section 1:** intial test image
% clear all previous run variable and windows
clc;clear;close all;
%create image
% [image,inpaint_domain] =  CreateInpaintBar(64,64,20,10,2);
[image,inpaint_domain] =  CreateInpaintBar(256,256,80,40,8);
%change image domain [0 - 255] to [0 - 1]
original_image = double(image+inpaint_domain)/255;
inpaint_domain = inpaint_domain < 1;
image = double(image)/255;
inpaint_domain = double(inpaint_domain);

%% ** section 2:** testing
lambda = 250/1;
theta = 5; % in publication use little gamma insted
max_gauss_seidel = 1;
omega = 0.1;
tolerant = 1e-6;
max_iteration = 10000; % force stop compute if iteration exceed to prevent forever loop

%merge lambda with inpaint domain
lambda = lambda * inpaint_domain;

lab_result = zeros(18,5);
for i = 1:18
    tic;
    fprintf("STEP %d\n",i);
    [inpainted_splitbergman_image,loop] = SplitBergmanInpainter(image,lambda,theta,tolerant,omega,max_gauss_seidel,max_iteration);
    process_time = toc; %processed time measurement
    RMSE = sqrt(mean((inpainted_splitbergman_image(:) - original_image(:)).^2)); 
    PSNR = psnr(inpainted_splitbergman_image,original_image);
    fprintf("Process time: %.6f seconds\n",process_time);
    lab_result(i,1) = omega;
    lab_result(i,2) = process_time;
    lab_result(i,3) = PSNR;
    lab_result(i,4) = RMSE;
    lab_result(i,5) = loop;
    omega = omega + 0.1;
end

csvwrite('out.csv',lab_result);
