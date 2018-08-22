function [y,n] = delta_approx(n,m,t,T)
%Compute Evaluate the approximation of the Dirac impulse 
% function on the abscissa T>0 at the point t
% INTPUT : 
%        n : order of approximation
%        m : method chosen
%        t : point of evaluation
%        T : absissa of non zero (optional parameter). 
%            By default the absissa is at T=1

%1) Method selection
switch m
    case 1 %Gaver-Stefhest
        [H,B,n] = gaver_stehfest_method(n);
    case 2 %Euler-Fourier
        [H,B,n] = euler_method(n);
    case 3 %Talbot
        [H,B,n] = talbot_method(n);
    case 4 %Horvath-Tayigas-Telek
        [H,B,n] = HTT_method(n);
    case 5 %unimodal
        [H,B,n] = unimodal_method(n);
    case {0.0, 0.1, 0.2} %monomial
        [H,B,n] = m_method(10*m,n);
    otherwise
end

if ~exist('T','var')
    T = 1;
end

%2) Evaluation
y = H(1)*exp(-B(1).*t/T);
for k=2:size(B,2)
    y = y + H(k)*exp(-B(k).*t/T);
end
y = 1/T * real(y);
end

