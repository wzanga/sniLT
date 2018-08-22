function [ y ] = m_weights(r,param,c)
%Compute the weights of a function in the monomial class theta_{r}^{n}
%by using the recursive procedure
% - INPUT :
%       r : index of the class
%       param : array of parameters [lambda,w,phi_{1},......,phi_{N}]
% - OUTPUT
%       y : array of parameters [lambda,w,eta_{0},......,phi_{F(N)}]
%
% WKZ 2018
if isempty(param), y=[]; return; end
if ~exist('c','var'), y = m_wint(r,param); else, y = m_wrec(r,param); end
if sum(isnan(y))==0, return; end
y=[];
end

%--------------------FOURIER SERIES METHOD-------------
function [y] = m_wint(r,param)
%Compute the weights of a function in the monomial class theta_{r}^{n}
%by exploiting the orthogonality of complex exponentials 

%(0) initialization
N = size(param,2)-2; %upperbound the the product
fn = m_fn(r,N);      %number of stricly positive pulse | order = 1 + fn
T = pi/param(2);     %integration upper bound
prec = 10^(-inf);    %10^(-1e1)

%(1) remove the decay coefficient lambda
y = zeros(1,3+fn);
y(1:2) = param(1:2);
param(1)=0;

%(2) constant term = mean term
y(3) = 1/(2*T) * integral(@(t) m_piform(r,param,t),0,T,'AbsTol',prec, 'RelTol',prec);

%(3) other frequencies
for k=1:fn
    y(k+3) = (1/T) * integral(@(t) exp(-2i*param(2)*k.*t).*m_piform(r,param,t),0,T,'AbsTol',prec, 'RelTol',prec);
end
end

%--------------------FOURIER RECURSIVE-------------
function [y] = m_wrec(r,param)
%Compute the weights of a function in the monomial class theta_{r}^{n}
%by using the recursive procedure
    
%(0) initialization
N = size(param,2)-2;    %upperbound the the product
fn = m_fn(r,N);         %number of stricly positive pulse | order = 1 + fn

%(1) adjust the parameters if the frequency is negative
y = [param(1:2),zeros(1,1+fn)] ; %initilize output list

%(2) base case
if N==1
    y(3:4) = [1/4 , 1/4 * exp(2i*param(3)) ];
    return;
end

%(3) general case
x = m_wrec(r,param(1:end-1));
sn = size(x,2)-3;
Nr = N^r;
phi = param(end);
for k=0:sn
    %part that corresponds to e^(2iwkt)
    y(3+k) =  y(3+k) + x(3+k)/2;
    %part that corresponds to e^(2iw(N^r + k)t)
    y(3+Nr+k) = y(3+Nr+k) +  1/4 * x(3+k) * exp( 2i*phi);
    %part that corresponds to e^(2iw(N^r - k)t) or e^(-2iw(N^r + k)t)
    if Nr-k>=0
        y(3+Nr-k) =  y(3+Nr-k) + 1/4 * conj(x(3+k)) *  exp( 2i*phi);
    else
        y(3+k-Nr) =  y(3+k-Nr) + 1/4 * x(3+k) *  exp(-2i*phi);
    end
end
end
