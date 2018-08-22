function [dcv,cv] = m_dcv(r,x,c)
%Compute the gradient of the coefficient of variation non iuncluding
%the partial derivative with respect to the frequency (not used)
% - INPUT 
%       r : index of the class
%       x : [l,w,phi_{1},......,phi_{N}]
%       c : choice between one period or infinity for integrations
% - OUTPUT
%       dcv = [dl,dw,dphi_{1},......,dphi_{N}]
%
% WKZ 2018
[cv,m0,m1,m2] = m_cv(r,x,c);
dm0 = m_dm(r,x,0,c); dm1 = m_dm(r,x,1,c); dm2 = m_dm(r,x,2,c);
dcv = (dm0/m0 -2*dm1/m1 +dm2/m2).*cv;
end