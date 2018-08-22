function [x] = m_bgd(epsln,nmax,r,x,c)
% Batch gradient descent on the parameters of the pi-form
% - INPUT 
%       eps : tolerence for gradient
%       nmax : maximum number of attempts
%       x : initial guess
%       c :choice between one period or infinity for integrations
% - OUTPUT
%       x : final guess
g=1;
for k=1:nmax
    %if mod(k,nmax/10)==0, disp(['(BGD):',num2str(100*k/nmax),'%']); end
    df = 1/2* (-m_dD0f(r,x,c) + m_dD1f(r,x,c));
    if sum(isfinite(df))==0 || norm(g*df)<epsln || x(1)<g*df(1), break; end
    x = x -g*df;
end; x = m_wshift(r,x);
end