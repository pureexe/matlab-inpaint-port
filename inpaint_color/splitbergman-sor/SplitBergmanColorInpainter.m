function result_image = SplitBergmanColorInpainter(toinpaint_image,inpaint_domain,lambda,theta,depth,tolerant,omega,max_gauss_seidel,multi_fine)
    [height,width,channel] = size(toinpaint_image);
    result_image = zeros(height,width,channel);
    for i = 1:channel
        result_image(:,:,i) = SplitBergmanInpainter(toinpaint_image(:,:,i),inpaint_domain,lambda,theta,depth,tolerant,omega,max_gauss_seidel,multi_fine);
    end
end
