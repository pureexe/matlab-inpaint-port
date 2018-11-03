function result_image = RecursiveColorInpainter(original_image,inpaint_domain,lambda,...
    theta,tolerant,omega,max_gauss_seidel,multi_coarse,multi_mid,multi_fine,max_step,current_step)
    if current_step < max_step
        half_image = imresize(original_image,0.5);
        half_domain = imresize(inpaint_domain,0.5);        
        half_result = RecursiveColorInpainter(half_image,half_domain,lambda,theta,tolerant,omega,max_gauss_seidel,multi_coarse,multi_mid,multi_fine,max_step,current_step+1);
        [height,width,channel] = size(original_image);
        upscale_result = imresize(half_result,[height width]);
        assignin('base',sprintf('upscale_%d',current_step),upscale_result);
        toinpaint_image = MergeColorResult(original_image,inpaint_domain,upscale_result);
    else
        toinpaint_image = original_image;
    end
    assignin('base',sprintf('toinpaint_image_%d',current_step),toinpaint_image);

    max_iteration = multi_fine;
    if current_step ~= 1
        if current_step == max_step
            max_iteration = multi_coarse;  
        else
            max_iteration = multi_mid;
        end
    end
    result_image = SplitBergmanColorInpainter(toinpaint_image,inpaint_domain,lambda,theta,current_step,tolerant,omega,max_gauss_seidel,max_iteration);
    assignin('base',sprintf('result_image_%d',current_step),result_image);
end