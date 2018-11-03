%% **section 1:** intial test image
% clear all previous run variable and windows
clc;clear;close all;
%create image
image = imread('case2_toinpaint.png');
inpaint_domain = imread('case2_inpaintdomain.png');
%change image domain [0 - 255] to [0 - 1]
original_image = double(imread('case2_original.png'))/255;
inpaint_domain = inpaint_domain < 1;
image = double(image)/255;
inpaint_domain = double(inpaint_domain);

%% ** section 2:** testing
lambda = 250/1;
theta = 1; % in publication use little gamma insted
max_gauss_seidel = 5;
omega = 1.6;
tolerant = 1*1e-4;
max_iteration = 1000; % force stop compute if iteration exceed to prevent forever loop

%merge lambda with inpaint domain
lambda = lambda * inpaint_domain;

tic;
inpainted_splitbergman_image = SplitBergmanInpainter(gpuArray(image),gpuArray(lambda),theta,tolerant,omega,max_gauss_seidel,max_iteration);
toc %processed time measurement

imshow(inpainted_splitbergman_image);

%imwrite(inpainted_splitbergman_image,'case2_result.png')