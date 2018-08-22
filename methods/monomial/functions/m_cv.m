function [cv,m0,m1,m2] = m_cv(r,x,~)
%Compute the coefficient of variation of a delta approximation in the
%monomial class of index r
% - INPUT
%       r:index of the class
%       x:[lambda,w,phi_{1},......,phi_{N}]
% - OUTPUT
%       cv : coefficient of variation
% WKZ 2018
tol=1e-100; T=inf;
m0 = integral(@(t) m_piform(r,x,t),0,T,'AbsTol',tol, 'RelTol',tol);
m1 = integral(@(t) t.*m_piform(r,x,t),0,T,'AbsTol',tol, 'RelTol',tol);
m2 = integral(@(t)(t.^2).*m_piform(r,x,t),0,T,'AbsTol',tol, 'RelTol',tol);
cv = m0*m2/(m1.^2)-1;
end