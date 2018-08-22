function [H,B,n] = HTT_method(n)
%compute the weights and the nodes of the 
% method within the Abatte-Whitt framework
% - INPUT
%   n : order of approximation of the Dirac impulse function
% - OUTPUT
%   H : list of weights (eta)
%   B : list of nodes (beta)
%   n : order of approximation of the Dirac impulse function used
%
% WKZ 2018

%Maximal order that have been computed by HTT is 24
n = min(n,24); %Safeguard

k = n-1;
% Load and returns the weights and nodes
load opt_alpha_gamma.mat

a = alpha{k};   
gam = gamma{k};

m0 = -dot(1./gam,conj(a));
m1 = dot(1./gam.^2, conj(a));

H = m1/m0^2*a;
B = -gam*m1/m0;

end
