clear;clc;
image = imread('test.png');
[height,width] = size(image);
downImage = ResizeImage(image,height*2,width*2);
imshow(downImage);
