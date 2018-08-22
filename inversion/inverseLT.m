function [y,n] = inverseLT(n,m,t,hstar)
%Compute the inverse Laplace Transform of the function h_star with
%the Abatte-Whitt framework and evaluate it at time t
% - INTPUT : 
%        n : order of approximation
%        m : method chosen
%        t : point of evaluation
%        hstar : Laplace Transform function to be inverted
% - OUTPUT :
%       y : result of the evaluation
%       n : order of approximation used (may be different than the one
%           given as input)

%1) Method selection
switch m
    case 1 %Gaver-Stefhest
        [H,B,n] = gaver_stehfest_method(n);
    case 2 %Euler-Fourier
        %[H,B,n] = euler_method(n);
        [y,n] = euler_ilt(n,t,hstar); return;
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

%2) Evaluation
y=0;
for k=1:size(B,2)
    y = y + (H(k)./t) .*hstar(B(k)./t);
end
y = real(y);
end
