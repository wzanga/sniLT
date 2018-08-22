function [ y ] = m_dfdw(r,x,t)
%Compute the partial derivative of the pi-form
%with respect to the frequency
% - INPUT 
%       r : index of the class
%       x : [l,w,phi_{1},......,phi_{N}]
%       t : point(s) of evaluation
% - OUTPUT
%       y = df/dw
%
% WKZ 2018
N = size(x,2)-2; y = tan(x(2)*t + x(3));
for k=2:N, y = y + (k^r)* tan(k^r*x(2)*t + x(k+2)); end
y = (-2) *t.* m_piform(r,x,t);
end

