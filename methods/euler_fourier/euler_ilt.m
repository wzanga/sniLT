function [y,n] = euler_ilt(n,t,hstar)
%Compute the inverse Laplace Transform of the function h_star without
%the explicit Abatte-Whitt framework. 
% Ref :[ J. Abate and W.Whitt "Numerical Inversion of Laplace Transforms 
%       of Probability Distributions", Journal of Computing, 1995]
%
% - INTPUT : 
%        n : order of approximation
%        t : point of evaluation
%        hstar : Laplace Transform function to be inverted
% - OUTPUT :
%       y : result of the evaluation
%       n : order of approximation used (may be different than the one
%           given as input)

%(0) Initilizations
n = (mod(n,2)==0)*(n) + (mod(n,2)==1)*(n+1);
c = [1,11,55,165,330,462]; c=[c,fliplr(c)];
a = 18.4; x = a./(2*t); h=1i * pi./t;

%(1) First evaluation of the transform  z=="sum" in te article
z = hstar(x)/2;
for k=1:n, z = z + (-1)^k * hstar(x+k*h); end

%(2) Second evaluation of the transform
s = zeros(13,size(t,2)); s(1,:) = z;
for k=1:12
    s(k+1,:) = s(k,:) + (-1)^k * hstar(x+(n+k)*h);
end
y = ( exp(a/2)./t) .* (c* s(2:end,:));
y = real(y)/2048;
end