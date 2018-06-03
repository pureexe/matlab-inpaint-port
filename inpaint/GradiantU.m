%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The subroutine for computing the image gradient
% over the image domain [1,N]x[1,N] with Neumann BCs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [ux,uy] = GradiantU(u) 
    h = 1;
    [m,n] = size(u);
    ux = [diff(u);zeros(1,m)]/h;
    uy = diff(u')';
    uy = ([uy zeros(n,1)])/h;


