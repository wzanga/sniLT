function [H,B,n] = talbot_method(n)
%compute the weights and the nodes of the Talbot
% method within the Abatte-Whitt framework
% - INPUT
%   n : order of approximation of the Dirac impulse function
% - OUTPUT
%   H : list of weights (eta)
%   B : list of nodes (beta)
%   n : order of approximation of the Dirac impulse function used
%
% WKZ 2018

%Initialization
H = zeros(1,n); %weights
B = zeros(1,n); %nodes

B(1) = 2*n/5;
H(1) = 1/5 * exp(B(1));

for k=2:n
   x = (k-1)*pi/n;
   B(k) = 2/5 * (k-1)*pi *( cot(x) + 1i) ;
   H(k) = 2/5 * ( 1 + 1i*x*(1+cot(x)^2) - 1i*cot(x) )* exp(B(k));
end
end