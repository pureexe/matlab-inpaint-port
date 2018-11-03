clear;clc;
image = imread('test.png');
[height,width] = size(image);
downImage = BilinearUpSample(image);
imshow(downImage);
