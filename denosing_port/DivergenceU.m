%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The subroutine for computing the divergent of a vector field
% over the image domain [1,N]x[1,N] with Neumann BCs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function divGU = DivergenceU(ux,uy)
    h = 1;
    [m,n] = size(ux);
    ux = [zeros(1,m);ux];
    ax = (ux(2:n+1,:)-ux(1:n,:))/h;
    uy = [zeros(n,1) uy];
    by = (uy(:,2:m+1)-uy(:,1:m))/h;
    divGU = ax+by;