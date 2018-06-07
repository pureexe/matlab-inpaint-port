clc;clear;close all;
addpath('denosing_port')
image = (imread('images/to_inpaint.png'));
image = double(rgb2gray(imresize(image,0.25)));
inpaint_domain = (imread('images/inpaint_domain.png'));
inpaint_domain = double(rgb2gray(imresize(inpaint_domain,0.25)));
inpaint_domain = inpaint_domain < 1;
lambda = 1/10;
beta = 1.0e-2;
tau = 1e-4;
tolerent = 1.0e-8;
max_iteration =500000;
rec = 1;KJ = 1000;
lambda = lambda*inpaint_domain;
[denoised_image,i] = ExplicitTimeMarchingDenoiser(image,lambda,beta,tau,...
    tolerent,max_iteration,rec,KJ);
%imshow(uint8(denoised_image));
        imagesc( denoised_image );
        axis square
        title('Denoised image')
        xlabel(['i = ',num2str(i)]);
        drawnow
