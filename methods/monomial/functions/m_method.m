function [H,B,n] = m_method(r,n)
%compute the weights and the nodes of the 
% method within the Abatte-Whitt framework
% - INPUT
%   n : order of approximation of the Dirac impulse function
%   r : index of the class
% - OUTPUT
%   H : list of weights (eta)
%   B : list of nodes (beta)
%   n : order of approximation of the Dirac impulse function used
%
% WKZ 2018

%(0) load the corresponding coefficients file
fname  = strcat(num2str(r),'m.mat');
load(fname);

%(1) Find closest computed order
N = min( size(paramlist,1) , m_invfn(r,n));
fn = m_fn(r,N);
n = 1 + fn;

%(2) Compute the coefficients and save them into the coeffcicient
% file if the they have not yet been computed. Otherwise read them
if isempty(paramlist{N,1})
    warning(strcat('No order [',num2str(n),'] coefficients in [',fname,']'));
    H=0;
    B=0;
    return;
else
    if isempty(paramlist{N,2})
        warning(strcat('Coefficients not computed for order [',num2str(n),'] in [',fname,']'));
        H=0; B=0; n=-1; return;
    end
end
param = paramlist{N,2};

%(3) Fetch the weights and compute the nodes
H = param(3:end);
B = - (0:1:fn) * 2i * param(2) + param(1);

%(4) complete the conjugate and normalize the PDF
W = [H, conj(H)];
B = [B, conj(B)];
H = W./sum( W./B);
end
