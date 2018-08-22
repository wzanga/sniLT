function [H,B,n] = euler_method(n)
%compute the weights and the nodes of the Euler-Fourier method
% method within the Abatte-Whitt framework
% - INPUT
%   n : order of approximation of the Dirac impulse function
% - OUTPUT
%   H : list of weights (eta)
%   B : list of nodes (beta)
%   n : order of approximation of the Dirac impulse function used
%
% WKZ 2018

%this method requires odd numbers of terms
n = min(n,60);
n = (mod(n,2)==0)*(n+1) + (mod(n,2)==1)*(n);
M = (n-1)/2 ;

%initialize the weights and nodes
H = zeros(1,n); %weights
B = zeros(1,n); %nodes

%Compute the ksi-list
LK = [0.5, ones(1, M), zeros(1, M-1), 2^-M];
for k = 1:M-1
    LK(2*M-k + 1) = LK(2*M-k + 2) + 1/(2^M) * nchoosek(M,k);
end

%computes the weights and nodes
for k=0:2*M
    B(k+1) = M*log(10)/3 + 1i*pi*k ;
    H(k+1) = (-1)^k * 10^(M/3) * LK(k+1);
end
end
