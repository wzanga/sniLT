function [ y ] = m_Dlogf(r,x,p,t)
%Compute the p-th partial derivativz D^{p}(logf) with respect to t
% - INPUT 
%       r : index of the class
%       x : [l,w,phi_{1},......,phi_{N}]
%       p : order of the derivative
%       t : point(s) of evaluation
% - OUTPUT
%       y : D^{p}[ log(f) ]
%
% WKZ 2018
N = size(x,2)-2;
if p==0, y=log(m_piform(r,x,t)); return; end
if p==1, y=-x(1); else, y=0; end
for k=1:N
    y = y - 2 * m_plog(x(2)*k^r,tan(x(2)*k^r*t+x(2+k)), p-1);
end
end
