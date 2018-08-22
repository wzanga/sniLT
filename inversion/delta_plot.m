function [ ] = delta_plot(n,mlist,t,T)
%Plot the dirac approximation around the abscissa T>0 
%for various methods implemented
% - INPUT :
%       - n : order of the approximations (number of terms)
%       - mlist : list of methods to use
%       - t : point(s) of evaluation
%       - T : central points
% - OUTPUT:

if ~exist('T','var')
    T = 1;
end

Legend =cell(size(mlist,2),1);
k=1;
figure;
for m=mlist
    switch m
        case 1 %Gaver-Stehfest method
            [y,nn] = delta_approx(n,m,t,T); 
            plot(t,y); hold on;
            Legend{k} = ['Gaver-Stehfest ',num2str(nn)];
            k=k+1;
        case 2 %Euler-Fourier method
            [y,nn] = delta_approx(n,m,t,T); 
            plot(t,y); hold on;
            Legend{k} = ['Euler-Fourier ',num2str(nn)];
            k=k+1;
        case 3 %Talbot
            [y,nn] = delta_approx(n,m,t,T); 
            plot(t,y); hold on;
            Legend{k} = ['Talbot ',num2str(nn)];
            k=k+1;
        case 4 %Horvath-Tayigas-Telek
            [y,nn] = delta_approx(n,m,t,T); 
            plot(t,y); hold on;
            Legend{k} = ['HTT ',num2str(nn)];
            k=k+1;
        case 5 %Power sine
            [y,nn] = delta_approx(n,m,t,T); 
            plot(t,y); hold on;
            Legend{k} = ['unimodal ',num2str(nn)];
            k=k+1;
        case {0.0, 0.1, 0.2} %monomial
            [y,nn] = delta_approx(n,m,t,T); 
            plot(t,y); hold on;
            Legend{k} = [num2str(10*m),'-monomial ',num2str(nn)];
            k=k+1;
        otherwise
            disp('select one of the method implemented!');
    end
end

ylabel(' Delta_{n}^{T}(t)');
xlabel('time t');
grid on;
title(['Approximation of the dirac distribution Delta_{n}^{T}(t) for T=',num2str(T)]);
legend(Legend)

end