%% prerequisite
init; clear all;

%% turn off warnings
warning('off','all');

N=10000; w=pi/2; r=6; l=r*w*log(10)/pi;
for n=2000:N
    disp(['n=',num2str(n)]);
    %(0) weights and nodes
    load('unimodal.mat');
    if ~isempty(paramlist{n,1}), continue; end
    unimodal_method(n);
    %(1) coefficient of variation
    load('unimodal.mat');
    xi =-atan(l/(2*n*w)); tol=1e-100;
    f = @(t) exp(-l*t).*( cos(w*(t-1)+xi) ).^(2*n);
    m0 = integral(@(t) f(t),0,inf,'AbsTol',tol, 'RelTol',tol);
    m1 = integral(@(t) t.*f(t),0,inf,'AbsTol',tol, 'RelTol',tol);
    m2 = integral(@(t) (t.^2).*f(t),0,inf,'AbsTol',tol, 'RelTol',tol);
    paramlist{n,2} = m0*m2/(m1.^2)-1;
    save(strcat('./method/unimodal/unimodal.mat'),'paramlist');
end
%figure; loglog(X,Y); grid on; legend('scv');