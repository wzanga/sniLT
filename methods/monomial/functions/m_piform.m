function [y] = m_piform(r,param,t)
%Compute evaluate the pi-form of an approximation of the Dirac impulse
%function the the monomial space
% - INPUT :
%       r : index of the class
%       param : array of parameters [lambda,w,phi_{1},......,phi_{N}]
%       t : point of evaluation
% - OUTPUT
%       y : evaluation 
%
% WKZ 2018
N = size(param,2)-2;
%first term of the product
y = exp(-param(1)*t).*(cos(param(2)*t + param(3)).^2);
%rest of the terms
for k=2:N
    y = y.*( (cos( (k^r)*param(2)*t + param(k+2)) ).^2);
end
end