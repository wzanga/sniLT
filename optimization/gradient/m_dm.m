function [dm] = m_dm(r,x,p,c)
%Compute the gradient of a moment non uncluding the partial derivative
%with respect to the frequency ( useless for the optimization)
% - INPUT 
%       r : index of the class
%       x : [l,w,phi_{1},......,phi_{N}]
%       p : order of the momemt
%       c : choice between one period or infinity for integrations
% - OUTPUT
%       dm :[dl,dw,dphi_{1},......,dphi_{N}]
% WKZ 2018
n = size(x,2); dm = zeros(1,n);
if isequal(c,'per'), T=pi/x(2); tol=1e-20; else, T=inf; tol=1e-100; end
%dm(1) = integral(@(t) (t.^p).*m_dfdl(r,x,t),0,T,'AbsTol',tol, 'RelTol',tol);
%dm(2) = integral(@(t) (t.^p).*m_dfdw(r,x,t),0,T,'AbsTol',tol, 'RelTol',tol);
for k=1:n-2
    dm(2+k) = integral(@(t) (t.^p).*m_dfdphi(r,x,k,t) ,0,T,'AbsTol',tol, 'RelTol',tol);
end
end