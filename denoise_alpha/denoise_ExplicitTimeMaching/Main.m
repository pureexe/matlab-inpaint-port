clc;clear;
image = rgb2gray(imread('_noisy_rectangle.png'));
image = double(image);
alpha = 10;
beta = 1.0e-4;
tau = 1.0e-4;
tolerent = 1.0e-6;
max_iteration = 5000;
denoised_image = ExplicitTimeMarchingDenoiser(image,alpha,beta,tau,tolerent,max_iteration);
imshow(uint8(denoised_image));
