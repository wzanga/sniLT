function [H,B,n] = unimodal_method(n)
%compute the weights and the nodes of the unimodal method
% method within the Abatte-Whitt framework
% - INPUT
%   n : order of approximation of the Dirac impulse function
% - OUTPUT
%   H : list of weights (eta)
%   B : list of nodes (beta)
%   n : order of approximation of the Dirac impulse function used
%
% WKZ 2018
%parameters
n=n-1;
w = pi/2; r=6; l=r*w*log(10)/pi; phi = pi/2 - atan(l/(2*n*w));
%compute the weights recursively
load('unimodal.mat');
if size(paramlist,1)<n || isempty(paramlist{n,1})
    paramlist{n,1} = m_weights(0,[l,w,phi*ones(1,n)],'rec');
    save('./method/unimodal/unimodal.mat','paramlist');
end
param = paramlist{n,1};
n = size(param,2)-2;
B = - (0:1:n-1) * 2i * param(2) + param(1);
H = param(3:end) /( real(sum(param(3:end)./B)));
end