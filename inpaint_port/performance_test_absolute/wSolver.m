function w = wSolver(u,b,theta)
    gradU = Gradiant(u);
    gradB = gradU+b;
    w = max(abs(gradB)-1./theta,0).*sign(gradB);
end
