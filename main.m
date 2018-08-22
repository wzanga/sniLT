% This code perform compute the inverse Laplace Transform of a function H*
% in the unified framework proposed by J. Abate and W.Whitt
% Ref :[ J. Abate and W.Whitt "A Unified Framwork for numerically inverting
%       Laplace transforms", Journal of Computing, 2007]
%
% METHODS IMPLEMENTED :
% 1 - Gaver-Stefhest
% 2 - Euler-Fourier
% 3 - Talbot
% 4 - HTT
% 5 - unimodal
% 0.0 - 0-monomial
% 0.1 - 1-monomial
% 0.2 - 2-monomial
%
% WKZ 2018

%% prerequisite call to add all the subfloders to the path
init;

%% Test Functions
%h = @(t) exp(-t);  h_star = @(s) 1./(s+1);
%h = @(t) cos(t);  h_star = @(s) s./(s.^2+1);
%h = @(t) sin(t);  h_star = @(s) 1./(s.^2+1);
%h = @(t) t>=1;  h_star = @(s) exp(-s)./s;
%h = @(t) (t>=1).*exp(1-t);  h_star = @(s) exp(-s)./(s+1);
h = @(t) floor(t);  h_star = @(s) (1./s).*1./(exp(s)-1);
%h = @(t) max(-square(pi*t),0);  h_star = @(s) (1./s).*(1./(exp(s)+1));
%h = @(t) -log(t)-0.5772156649 ;  h_star = @(s) log(s)./s;
%h = @(t) 1./sqrt(pi*t);  h_star = @(s) 1./sqrt(s);
%h = @(t) 3/5*(1-exp(-5*t));  h_star = @(s) 3/(s.^2+5*s);
%h = @(t) exp(t).*erfc(sqrt(t));  h_star = @(s) 1/(sqrt(s)+s);
%h = @(t) (1-exp(-t))./sqrt(4*pi*t.^3);  h_star = @(s) 1./(sqrt(s)+sqrt(s+1));

%% Inversion and Plot
t = 0.4:0.0001:3;
n=3900; r=0; n = m_fn(r,n)+1;
mlist = [2,0.1];
%delta_plot(n,mlist,t);
inverseLT_plot(n,mlist,t,h_star,h);
%compareiLT_plot(n,mlist,t,h_star,h);

%% metrics
%cv_plot(mlist)
%entropy_plot(mlist)

%% Plot opt
%r=1; load([num2str(r),'m.mat']); prec=1e-20; n=180; x = paramlist{n,1};
%lx =  m_piform(r,x,t); prcsn=1e-10;
%mx = integral(@(t) m_piform(r,x,t),0,inf,'AbsTol',prec, 'RelTol',prec);
%figure; plot(t, 1/mx * lx); hold on; grid on;
%figure; plot(t,m_sigform(r,paramlist{n,2},t)); hold on; grid on;

%% unimodal
% load unimodal.mat
% x=[]; y=[]; n=size(paramlist,1);
% for k=1:n
%     if ~isempty(paramlist{k,1})
%         x=[x,k]; 
%         y=[y,paramlist{k,2}];
%     end
% end
% figure; loglog(x,y); legend('unimodal scv'); grid on; xlabel('scv'); ylabel('order');
% % logy = a +b*logx => y = exp(a)*x^b;
% p = polyfit(log(x),log(y),1);
% b=p(1); a=p(2); 
% figure; plot(x,y); hold on; plot(x,exp(a)*x.^b); legend('originial','fit');