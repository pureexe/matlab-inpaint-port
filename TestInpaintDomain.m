clc;clear;close all;
addpath('utility')
[image,inpaint_domain] = createInpaintBar();
imshow(uint8(image))