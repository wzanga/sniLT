function [y] = m_fitness(r,x,c)
% Evaluate the objective function to be minimized
% - INPUT
%       r: index of the class
%       x: [l,w,phi_{1},......,phi_{N}]
%       c :choice between one period or infinity for integrations
% - OUTPUT
%       y: 
% WKZ 2018

y = abs(sqrt( m_D2f(r,x,1).^2 - m_D3f(r,x,1)*m_D1f(r,x,1))/m_D3f(r,x,1));

%%--------reserve functions
%abs(m_D1f(r,x,1));
%m_cv(r,x,c)*m_entropy(r,x,c);
%abs(sqrt( m_D2f(r,x,1).^2 - m_D3f(r,x,1)*m_D1f(r,x,1))/m_D3f(r,x,1));
%tol=1e-10; integral(@(t) m_piform(r,x,t),0,inf,'AbsTol',tol, 'RelTol',tol);
end