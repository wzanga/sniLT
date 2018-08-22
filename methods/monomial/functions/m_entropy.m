function [s] = m_entropy(r,x,c)
%Compute the differential entropy of an elemnt of the monomial class
% - INPUT
%       r: index of the class
%       x: [l,w,phi_{1},......,phi_{N}]
%       c:choice between one period or infinity for integrations
% - OUTPUT
%       s: differential entropy
% WKZ 2018
if isequal(c,'per'), T=pi/x(2); tol=1e-20; else, T=inf; tol=1e-100; end
s = -integral(@(t) m_piform(r,x,t).*log(m_piform(r,x,t)),0,T,'AbsTol',tol, 'RelTol',tol);
end