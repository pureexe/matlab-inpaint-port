clc;clear;
addpath('denosing_port')
image = (imread('images/_noisy.png'));
image = double(image);
lambda = 10;
beta = 1.0e-4;
tau = 1.0e-4;
tolerent = 1.0e-6;
max_iteration = 1000;
denoised_image = ExplicitTimeMarchingDenoiser(image,lambda,beta,tau,tolerent,max_iteration);
imshow(uint8(denoised_image));
