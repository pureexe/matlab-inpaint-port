clc;clear;
addpath('denosing_port')
image = rgb2gray(imread('images/_noisy_rectangle.png'));
image = double(image);
lambda = 1.0e-4;
beta = 1.0e-4;
tau = 1.0e-2;
tolerent = 1.0e-4;
max_iteration = 1000;
denoised_image = ExplicitTimeMarchingDenoiser(image,lambda,beta,tau,tolerent,max_iteration);
imshow(uint8(denoised_image));
