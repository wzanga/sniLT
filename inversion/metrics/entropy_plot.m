function [ ] = entropy_plot(mlist)
%Plot the Boltzmann entropy of function in the monomial class
% - INPUT :
%       - mlist : list of methods to use
%       - prec : (optional) decide by default if 
% - OUTPUT:
mlist = mlist( mlist<1);
Legend =cell(size(mlist,2),1); k=1; fmax = 1; 
figure;
for m=mlist
    r=10*m; %class index
    load(strcat(num2str(r),'m.mat'));s = size(paramlist,1); 
    X=inf*ones(1,s); Y=inf*ones(1,s);
    for p=1:s
        if ~isempty(paramlist{p,4})
            X(p) = m_fn(r,p)+1;
            Y(p) = paramlist{p,4};
        end
    end
    ind = (Y<inf & Y>0); X=X(ind); Y=Y(ind); fmax = max(fmax,size(X,2)); loglog(X,Y); hold on;
    Legend{k} = [num2str(10*m),'-monomial ']; k=k+1;
end

%plot configuration
ylabel('log[S]'); xlabel('log[order]'); grid on;
title('Differential Entropy [log-log]'); legend(Legend);
end