init; clear;  warning('off','all');

%% Parameters
%t = 1:00.1:pi;
%r=0; n=10; load([num2str(r),'m.mat']); s=2; nmax=1e3;

%x = paramlist{n,1}; t = 0:0.0001:2; y=x;
%y = [0,0,rand(1,n)];
%y = [paramlist{n-1,1},0];  
%y = m_hses(nmax,r,y,'period');
%y = m_bgd(1e-100,nmax,r,y,'period');

%% plot metrics to minimize
%cv_plot(r/10);  dist_plot(r/10);

%% Plot
% figure;
% cx = m_cv(r,x,'infinity'); cy=m_cv(r,y,'infinity');
% dx = m_dist(r,x);dy = m_dist(r,y);
% lx =m_piform(r,x,t); ly = m_piform(r,y,t);
% plot(t,lx/max(lx)); hold on; plot(t,ly/max(ly)); grid on;
% legend(['ref [cx:',num2str(cx),']----[dx:',num2str(dx),']'],...
%     ['opt [cy:',num2str(cy),']----[dy:',num2str(dy),']']);

%% Prod
t = 0:0.0001:1;
r=0; n=140; load([num2str(r),'m.mat']); s=2; x = paramlist{n,1};
if x(2)<0, x(2:end)=-x(2:end); end

%% optim attempt
%y =[1,1,pi*rand(1,n)];y = m_hses(1e3,r,y,'inf');
%% Parametrization 1 (failure when taking the decay into account)
% e = 0.8/sqrt(n);
% K=((1:n)-1); Kr=(1:n).^r;
% y=[1,pi/0.9,1/2*pi-(pi-e)/(n-1)*K.*Kr];
% y = m_bgd(0,1e3,r,y,'inf');
%% Parametrization 2 (fail)
% e = 0.5; a=pi*(1/2-1/6); K=(1:n-1); Kr=K.^r; phin = n^r *(pi/2-a-e); 
% y=[0,1,Kr.*(pi/2-a*K/(n-1)),phin];
%% Parametrization 3 (fail)
% psi=@(z) 0.5 +0.5*exp(-0.0230*n);
% e=1-2*psi(n);
% a=0.6;
% p=1-psi(n);
% eg = pi/n;                     ed = 0;
% Ng = ceil(p*n);             cg = 0.5*(a-eg)/Ng;
% Nd = max(n-Ng);             cd = ((pi-ed)-(a+e))/Nd;
% phi=zeros(1,n);
% for k=1:Ng, phi(k) = pi/2 -k^r*(cg*k+eg); end
% for k=1:Nd, phi(k+Ng) = pi/2 -(Ng+k)^r*(cd*k+a+e); end
% y = [1,1,phi];
% y = m_hses(1e3,r,y,'inf');
%% PLOT parametrization and reference
% figure;
% subplot(2,2,1);
% for k=1:n
%     plot(t,cos(k^r*t*pi+x(k+s)).^2); hold on;
% end; grid on; title('reference terms');
% 
% subplot(2,2,3);
% for k=1:n
%     plot(t,cos(k^r*t*pi+y(k+s)).^2); hold on;
% end; grid on; title('opt terms');
% 
% subplot(2,2,[2,4]);
% tt=0:0.001:5; 
% %x(1)=0; %x(2)=1;
% fx = m_piform(r,x,tt); mx=max(fx);
% %y=m_wshift(r,y); 
% fy = m_piform(r,y,tt); my=max(fy);
% plot(tt,fx/mx); hold on;
% plot(tt,fy/my); grid on; 
% title('Results'); legend('reference','creation');

%% Poincarre inspired section
% subplot(2,2,[3,4]);
% fn = m_fn(r,n); X = zeros(1,fn); Y=X; i=1; j=1; Z=zeros(1,fn-1);
% for k=1:n
%     sk = k^r; yk=cos(x(2+k)).^2;
%     for p=0:s-1
%         xk = mod( ((p+1/2)*pi-x(2+k))/sk, pi);
%         X(i)= xk; Y(i)=yk; i=i+1;
%         line([xk,xk],[0,1]); hold on;
%     end
% end
% line([pi,pi],[0,0]); grid on;
% %h=plot(X,Y,'.'); set(h,'markersize',8); hold on;
% %h=plot(X,0*X,'.'); set(h,'markersize',8); grid on;

%% Lissajous's curve
% A =1; B=1;
% a =41.5; b=25; d = pi/1;
%t=0:0.001:pi;
% x = A*cos(a*t+d);
% y = B*sin(b*t);
% figure; plot(y,x); grid on;

%% Alternative cos(k^r (t-e))^2
%r=1; k=10; fx = (k^r)/pi; fy=k^r;
%x = cos(fx*t);y = cos(fy*t).^2;
%x = t; y = cos(fy*t).^2;
%figure; plot(x,y); grid on; xlabel('x'); ylabel('y');

%% frequency plot
% r=0; load([num2str(r),'m.mat']);
% n=size(paramlist,1);
% X=[paramlist{1,1}(2)]; Y=[2];
% for k=1:n
%     if ~isempty(paramlist{k,1})
%         X=[X,m_fn(r,k)+1];
%         Y=[Y,paramlist{k,1}(2)];
%     end
% end
% figure;
% plot(X,Y);

%% Zeros and maximums
% k=1; w=pi; r=0; 
% T= pi/(w*k^r); zk=0.4; ek=mod(zk+T/2,T);
% t=0:0.001:T;
% plot(t, cos(w*k^r*(t-ek)).^2); grid on;
% disp(['zero at:',num2str(zk)]);
% disp(['max at:',num2str(ek)]);

%% PLot zeros distribution
t=0:0.01:5;
r=1; load([num2str(r),'m.mat']); 
s=size(paramlist,1);
Z = cell(s,3);
for k=1:s
    x=paramlist{k,1};
    if isempty(x), continue; end
    if x(2)<0, x(2:end)=-x(2:end); end
    phi = x(3:end);
    n = size(phi,2);
    Z{k,1}= (n)*ones(1,n);
    Z{k,2}= mod(phi,pi);
end

figure;
%subplot(1,2,1); fs=m_fn(r,s)+1;
for k=1:s
    scatter( Z{k,1},Z{k,2},2,'r'); hold on;
end
grid on; grid minor;
ylabel('normalized position of the zeros'); xlabel('N');
% 
% subplot(1,2,2);
% for k=1:s
%     if isempty(Z{k,1}), continue; end
%      y = quantile(Z{k,2},0.25:0.25:0.75);
%      x = (1+m_fn(r,k))*ones(size(y));
%      scatter( x,y,1,'r'); hold on;
% end
%grid on; grid minor;
%ylabel('mean'); xlabel('order');