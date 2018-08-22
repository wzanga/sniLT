function [x]=m_hses(nmax,r,x,c)
% Heuristic Search (1+1)-ES
% - INPUT
%       nmax : maximum number of iterations
%       r : class index
%       x : first guess [l,w,phi_{1},....,phi_{N}]
%       c :choice between one period or infinity for integrations
% - OUTPUT
%       x : optimal solution

% Objective function
f = @(z) m_fitness(r,z,c);

% parameters
n=size(x,2);    %number of parameters to be optimized
rcc=0.9;        %Rechenberg control coefficient
rsc=0;          %Number of Rechenber success
rsig=1e-2;       %Standtard deviation of mutations
fx=f(x); y=x;

% Iterations
for k=1:nmax
    %(hs.0) generate candidate
    %y(3:end) = mod(x(3:end)+ pi*rsig*randn(1,n-2), pi); fy = f(y);
    y(2:end) = x(2:end)+ rsig*randn(1,n-1); fy = f(y);
    %(hs.1) update search head
    if fy<fx, rsc=rsc+1; x=y; fx=fy; end
    %(hs.2) Rechenberg 1/5th rule
    if mod(k,20)==0
        %if mod(k,it1p)==0, disp(['(1+1)-ES :',num2str(100*k/nmax),'%']); end
        if(rsc<4), rsig=rsig*rcc; elseif(rsc>4), rsig=rsig/rcc; end; rsc=0;
    end
end
%x = m_wshift(r,x);
end
