function [ ] = compareiLT_plot(n,mlist,t,hstar,h)
%Plot the logs of the relative errors with resepect to the analytical
%inverse for various method implemented
% - INPUT :
%       - n : order of the approximations (number of terms)
%       - mlist : list of methods to use
%       - t : point(s) of evaluation
%       - hstar : Laplace Transform function to be inverted
%       - prec : (optional) decide by default if 
% - OUTPUT:

if ~exist('prec','var')
    p = -1;
    text = 'significant digits produced';
    loc = 'northeast';
else
    p = 1;
    text = 'error';
    loc = 'southwest';
end

Legend =cell(size(mlist,2),1);
k=1;

% Analytical inversion : reference
href = h(t);
%method selection for relative error
c=1;

figure;
for m=mlist
    switch m
        case 1 %Gaver-Stehfest method
            [y,nn] = inverseLT(n,m,t,hstar);
            z = p*log10(relative_error(href,y,c));
            plot(t,z); hold on;
            Legend{k} = ['Gaver-Stehfest ',num2str(nn)];
            k=k+1;
        case 2 %Euler-Fourier method
            [y,nn] = inverseLT(n,m,t,hstar);
            z = p*log10(relative_error(href,y,c));
            plot(t,z); hold on;
            Legend{k} = ['Euler-Fourier ',num2str(nn)];
            k=k+1;
        case 3 %Talbot
            [y,nn] = inverseLT(n,m,t,hstar);  
            z = p*log10(relative_error(href,y,c));
            plot(t,z); hold on;
            Legend{k} = ['Talbot ',num2str(nn)];
            k=k+1;
        case 4 %Horvath-Tayigas-Telek
            [y,nn] = inverseLT(n,m,t,hstar); 
            z = p*log10(relative_error(href,y,c));
            plot(t,z); hold on;
            Legend{k} = ['HTT ',num2str(nn)];
            k=k+1;
        case 5 %Power sine
            [y,nn] = inverseLT(n,m,t,hstar); 
            z = p*log10(relative_error(href,y,c));
            plot(t,z); hold on;
            Legend{k} = ['unimodal',num2str(nn)];
            k=k+1;
        case {0.0, 0.1, 0.2} %monomial
            [y,nn] = inverseLT(n,m,t,hstar); 
            z = p*log10(relative_error(href,y,c));
            plot(t,z); hold on;
            Legend{k} = [num2str(10*m),'-monomial ',num2str(nn)];
            k=k+1;
        otherwise
            disp('select one of the method implemented!');
    end
end

ylabel(strcat('log10 relative [',text,']'));
xlabel('time t');
grid on;
title(strcat('Log10 [',text,'] of the iLT approximation'));
legend(Legend,'Location',loc);
end

function [r]=relative_error(x,y,c)
%compute the relative errors between x and y
%
% INPUT
%       - x : array
%       - y : array
%       - c : pramater to choose the method used
% OUTPUT
%       - z : array of relative errors
 switch c
     case 1
         %Relative Change and Difference 
         r = abs(x-y)./max(abs(x),abs(y));
     case 2
         %Relative Percent Difference  2
         r = abs(x-y)./abs(x);
     case 3 
          %Relative Percent Difference (RPD1)
         r = 2 * abs(x-y)./(abs(x) + abs(y));
     case 4
         r = abs( 2*atan(y/x) - pi/2);
     otherwise
 end
end
