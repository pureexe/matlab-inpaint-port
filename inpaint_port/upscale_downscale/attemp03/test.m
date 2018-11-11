clc;clear;close all;
image = imread('test.png');
%image = rgb2gray(image);
%downSize = AverageDownSample(image);
%0imshow(downSize);
upsize = BilinearUpSampleFreeSize(image,513,512);
imshow(uint8(upsize));