%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A MATLAB code (Driver) to demonstrate the global fixed-point (GFP) method 
% for Total Variation denoising model (ROF model)
%
% Min { alpha*Tv(u) + (1/2)*int(u-z)^2 } (*)
%  u
%
% This is equaivalent to solve the following PDE:
%
% -alpha*div[Grad(u)/|Grad(u)|]+(u-z) = 0
%
% Here u is the image to be recovered 
%      z is the observed image corrupted by the Gaussian noise 
% and  
%      alpha > 0 is the regularization parameter.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;close all;
z = double(rgb2gray(imread('_noisy_rectangle.png')));
alpha = 0.02;
beta = 1.0e-4;
omega = 1.6;
GSmax = 3;
IMAX = 1000;
esp = 1.0e-6;
denoised_image = FixedPointDenoiser(z,alpha,beta,omega,GSmax,esp,IMAX);
imshow(uint8(denoised_image))
