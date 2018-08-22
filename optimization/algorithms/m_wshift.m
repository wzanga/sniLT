function [ x ] = m_wshift(r,x)
% Adjust the frequency non optimized parameters (w,l)
%- INPUT
%       r : class index
%       x : array of parameters [lambda,w,phi_{1},......,phi_{N}]
%- OUTPUT
%       x : adjusted parametets
% WKZ 2018
%(1) Find the argmax
if x(2)<0, x(2:end)=-x(2:end); end; T=pi/x(2);
t=1e-3:1e-3:T; [~,index] = max(m_piform(r,x,t)); wfact = t(index);
%(2) Adjust the frequency (w)
w = wfact * x(2); x(2)=w;
%(3) Adjust the decay coefficient
l =x(1)*w; x(1)=6*l;
%(4) Shift the phases such that the maximum is at T=1
s1 = 0; s2 = 0; N = size(x,2)-2;
for k=1:N
    s1 = s1 + (k^r)*x(2)*tan(k^r * x(2) +x(k+2));
    s2 = s2 + (k^r)*x(2)*( 1 + tan(k^r * x(2) + x(k+2))^2);
end
x(3:end) = x(3:end) + (-x(1)/2 - s1)/s2;
end