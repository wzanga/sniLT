function [ y ] = m_D1f(r,x,t)
%Compute the partial first order derivative of the pi-form with respect to t
% - INPUT 
%       r : index of the class
%       x : [l,w,phi_{1},......,phi_{N}]
%       t : point(s) of evaluation
% - OUTPUT
%       y = D^{1}[f] = D^{1}[log(f)] * f
%
% WKZ 2018
y = m_Dlogf(r,x,1,t).*m_piform(r,x,t);
end

