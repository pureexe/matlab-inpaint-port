function zeta = FourierZeta(width,height,theta)
    zeta = zeros(height,width);
    for i=1:height
        for j=1:width
            zeta(i,j) = 1-2*theta*(cos(2*pi*(i-1)/height)+cos(2*pi*(j-1)/width)-2); 
        end
    end
end