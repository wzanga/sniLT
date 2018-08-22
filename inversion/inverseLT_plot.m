function [ ] = inverseLT_plot(n,mlist,t,hstar,h)
%Plot the inverse Laplace Transform in the Abate-Whitt framework
%for various methods implemented
% - INPUT :
%       - n : order of the approximations (number of terms)
%       - mlist : list of methods to use
%       - t : point(s) of evaluation
%       - hstar : Laplace Transform function to be inverted
% - OUTPUT:

Legend =cell(size(mlist,2),1);
k=1;

figure;
for m=mlist
    switch m
        case 1 %Gaver-Stehfest method
            [y,nn] = inverseLT(n,m,t,hstar); 
            plot(t,y); hold on;
            Legend{k} = ['Gaver-Stehfest ',num2str(nn)];
            k=k+1;
        case 2 %Euler-Fourier method
            [y,nn] = inverseLT(n,m,t,hstar);
            plot(t,y); hold on;
            Legend{k} = ['Euler-Fourier ',num2str(nn)];
            k=k+1;
        case 3 %Talbot
            [y,nn] = inverseLT(n,m,t,hstar);  
            plot(t,y); hold on;
            Legend{k} = ['Talbot ',num2str(nn)];
            k=k+1;
        case 4 %Horvath-Tayigas-Telek
            [y,nn] = inverseLT(n,m,t,hstar); 
            plot(t,y); hold on;
            Legend{k} = ['HTT ',num2str(nn)];
            k=k+1;
        case 5 %Power sine
            [y,nn] = inverseLT(n,m,t,hstar); 
            plot(t,y); hold on;
            Legend{k} = ['unimodal ',num2str(nn)];
            k=k+1;
        case {0.0, 0.1, 0.2} %monomial
            [y,nn] = inverseLT(n,m,t,hstar);
            plot(t,y); hold on;
            Legend{k} = [num2str(10*m),'-monomial ',num2str(nn)];
            k=k+1;
        otherwise
            disp('select one of the method implemented!');
    end
end

%plot the real inverse
if exist('h','var')
    plot(t,h(t),'k');
end

ylabel('f(t)');
xlabel('time t');
grid on;
title('Approximation of the Inverse Laplace Transform ');
legend(Legend)

end