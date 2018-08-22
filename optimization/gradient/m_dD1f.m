function [dD1f] = m_dD1f(r,x,~)
%Compute the gradient of D^{1}[f] with respect to parameters
% - INPUT 
%       r : index of the class
%       x : [l,w,phi_{1},......,phi_{N}]
% - OUTPUT
%       dD1f :[dl,dw,dphi_{1},......,dphi_{N}]
% WKZ 2018
n = size(x,2); dD1f = zeros(1,n); 
DLogf1 = m_Dlogf(r,x,1,1); 
f1=m_piform(r,x,1);
%partial derivative with respect to lambda
dD1f(1) = (-1-DLogf1)*f1;
dD1f(2) = DLogf1 * m_dfdw(r,x,1);
%partial derivatives with respect to phi and w
for k=1:n-2
    kr = k^r; wkr = x(2)*kr; T=tan(wkr+x(2+k));
    dD1f(2+k) = (-2)*( wkr*(1+T^2) + DLogf1*T )*f1;
    dD1f(2) = dD1f(2) + (-2)*kr*(T + wkr*(1+T^2))*f1;
end
end