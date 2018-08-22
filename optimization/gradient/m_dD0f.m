function [dD0f] = m_dD0f(r,x,~)
%Compute the gradient of D^{0}[f] with respect to parameters
% - INPUT 
%       r : index of the class
%       x : [l,w,phi_{1},......,phi_{N}]
% - OUTPUT
%       dD0f :[dl,dw,dphi_{1},......,dphi_{N}]
% WKZ 2018
n = size(x,2); dD0f = zeros(1,n); 
f1=m_piform(r,x,1);
%partial derivative with respect to lambda
dD0f(1) = -f1;
%partial derivatives with respect to phi and w
for k=1:n-2
    kr = k^r; wkr = x(2)*kr; Tf=tan(wkr+x(2+k))*f1;
    dD0f(2+k) = (-2)*Tf;
    dD0f(2) = dD0f(2) + (-2)*kr*Tf;
end
end