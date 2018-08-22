function [ y ] = m_dfdphi(r,x,k,t)
%Compute the partial derivative of the pi-form
%with respect to a phase coefficient
% - INPUT 
%       r : index of the class
%       x : [l,w,phi_{1},......,phi_{N}]
%       k : index of the phase
%       t : point(s) of evaluation
% - OUTPUT
%       y = df/dphi_{k}
%
% WKZ 2018
 y = (-2) * tan(k^(r)*x(2)*t + x(k+2)).* m_piform(r,x,t);
end

