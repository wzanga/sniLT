function [ ] = cv_plot(mlist)
%Plot the coefficient of variation of function in the monomial class
% - INPUT :
%       - mlist : list of methods to use
%       - prec : (optional) decide by default if 
% - OUTPUT:
mlist = mlist( mlist<1);
Legend =cell(size(mlist,2),1); k=1; fmax = 1; figure;
for m=mlist
    r=10*m; %class index
    load(strcat(num2str(r),'m.mat'));s = size(paramlist,1); 
    X=inf*ones(1,s); Y=inf*ones(1,s);
    for p=1:s
        if ~isempty(paramlist{p,3})
            X(p) = m_fn(r,p)+1;
            Y(p) = paramlist{p,3};
        end
    end
    ind = (Y<inf & Y>0); X=X(ind); Y=Y(ind); fmax = max(fmax,size(X,2)); loglog(X,Y); hold on;
    Legend{k} = [num2str(10*m),'-monomial ']; k=k+1;
end

%unimodal
load('unimodal.mat');
X=zeros(1,fmax); Y=zeros(1,fmax);
for p=1:fmax
    if ~isempty(paramlist{p,1})
        X(p) = p+1;
        Y(p) = paramlist{p,2};
    end
end
loglog(X,Y); hold on; Legend{k} ='unimodal'; k=k+1;
 
%reference by HTT article
X = 1:1:fmax; loglog(X,2./(X.^2),'k'); Legend{k}='reference 2/n^2'; 
%plot configuration
ylabel('log[cv]'); xlabel('log[order]'); grid on;
title('coefficient of variation'); legend(Legend);
end
