% Gradiant with Neuman Boundary Condition
function G = Gradient(u,depth)
    %h = 1;
    h = 2^(depth-1);
    [height,width] = size(u);
    ux = [diff(u);zeros(1,height)]/h;
    uy = diff(u')';
    uy = ([uy zeros(width,1)])/h;
    G = [ux;uy];
end