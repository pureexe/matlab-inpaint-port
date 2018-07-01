% Periodic bondary condition Gradiant with backword-difference
function G = Gradiant(u) 
    [height,width] = size(u);
    previous_ux = [u(height,:); u(1:height-1,:)];
    previous_uy = [u(:,width) u(:,1:width-1)];
    pd_ux = u-previous_ux;
    pd_uy = u-previous_uy;
    G = [pd_ux;pd_uy];

