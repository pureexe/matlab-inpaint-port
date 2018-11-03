function w = wSolver(u,b,theta,depth)
    gradU = Gradient(u,depth);
    gradB = gradU+b;
    w = max(abs(gradB)-1./theta,0).*sign(gradB);
end
