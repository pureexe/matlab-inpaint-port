function result_image = RecursiveInpainter(original_image,inpainted_domain,lambda,...
    theta,tolerant,max_iteration,max_step,current_step)
    if current_step < max_step
        [height,width] = size(original_image);
        % half_image = imresize(original_image,0.5);
        half_image = ResizeImage(original_image,floor(height/2),floor(width/2));
        %half_domain = imresize(inpainted_domain,0.5);
        half_domain = ResizeImage(inpainted_domain,floor(height/2),floor(width/2));
        % assignin('base',sprintf('half_image_%d',current_step),half_image);
        % assignin('base',sprintf('half_domain_%d',current_step),half_domain);        
        half_result = RecursiveInpainter(half_image,half_domain,lambda,...
            theta,tolerant,max_iteration,max_step,current_step+1);
        %upscale_result = imresize(half_result,[height width]);
        upscale_result = ResizeImage(half_result,height,width);
        toinpaint_image = MergeResult(original_image,inpainted_domain,upscale_result);
    else
        toinpaint_image = original_image;
    end
    
    %theta = 2^(current_step-1) * theta;
    theta = theta / 2^(current_step-1);
    % lambda = lambda*exp(0.02*(max_step - current_step + 1));
        
    inpainted_lambda =  inpainted_domain < 1;
    inpainted_lambda = inpainted_lambda*lambda;
    
    % assignin('base',sprintf('toinpaint_image_%d',current_step),toinpaint_image);
    if current_step ~= 1
        if current_step == 4
            max_iteration = 100;
            tolerant = 1e-12;
        else
            max_iteration = 10;
            tolerant = 1e-12;
        end        
    end
    result_image = SplitBergmanInpainter(toinpaint_image,inpainted_lambda,theta,tolerant,1,1,max_iteration);
    % assignin('base',sprintf('result_image_%d',current_step),result_image);
end