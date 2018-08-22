function [H,B,n] = gaver_stehfest_method(n)
%compute the weights and the nodes of the Gaver-Stehfest
% method within the Abatte-Whitt framework
% - INPUT
%   n : order of approximation of the Dirac impulse function
% - OUTPUT
%   H : list of weights (eta)
%   B : list of nodes (beta)
%   n : order of approximation of the Dirac impulse function used
%
% WKZ 2018

%this method requires even numbers of terms
n = min(n,30);
n = (mod(n,2)==0)*(n) + (mod(n,2)==1)*(n+1);

%start compution the 
H = zeros(1,n); %weights
B = zeros(1,n); %nodes
for k=1:n
   B(k) = k*log(2);
   H(k) = log(2) * (-1)^(k + n/2) * gscoef(k,n);
end
end

function [s] = gscoef(k,n)
s = 0; 
for j = floor((k+1)/2) : min(k,n/2)
    s = s + j^(n/2+1) * nchoosek(n/2,j) * nchoosek(2*j,j)* nchoosek(j,k-j)/ factorial(n/2);
    %s = s + j^(n/2+1) * exp( j*log(2)-gammaln(j+1) - gammaln(n/2-j+1) - gammaln(k-j+1) - gammaln(2*j-k+1));
end
end