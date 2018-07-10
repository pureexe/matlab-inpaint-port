[image,inpaint_domain] =  createInpaintBar2(128,128,50,50,5);
imwrite(uint8(image),'case6_toinpaint.png');
imwrite(uint8(inpaint_domain),'case6_inpaintdomain.png');
imwrite(uint8(image + inpaint_domain),'case6_original.png');
[image,inpaint_domain] =  createInpaintBar2(256,256,100,50,5);
imwrite(uint8(image),'case7_toinpaint.png');
imwrite(uint8(inpaint_domain),'case7_inpaintdomain.png');
imwrite(uint8(image + inpaint_domain),'case7_original.png');
