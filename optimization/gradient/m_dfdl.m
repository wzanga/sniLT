function [ y ] = m_dfdl(r,x,t)
%Compute the partial derivative of the pi-form 
%with respect to the decay coefficient
% - INPUT 
%       r : index of the class
%       x : [l,w,phi_{1},......,phi_{N}]
%       t : point(s) of evaluation
% - OUTPUT
%       y = df/dl
%
% WKZ 2018
 y = (-t).* m_piform(r,x,t).^2;
end

