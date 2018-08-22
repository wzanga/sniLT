%% ------- 0-monomial -----------
% r=0; load 0m.mat; s=size(paramlist,1);
% for k=1:s
%     if k>=219
%         paramlist{k,1} = []; paramlist{k,2} = [];paramlist{k,3} = [];paramlist{k,4} = [];
%         paramlist{k,5} = [];
%     end
% end
% save('./method/monomial_delta/xm/0m.mat','paramlist');

%% -------- 1-monomial -----------
% r=1; load 1m.mat; s=size(paramlist,1);
% for k=1:s
%     if k==1000
%         paramlist{k,1} = []; paramlist{k,2} = [];paramlist{k,3} = [];paramlist{k,4} = [];
%     end; paramlist{k,5} = [];
% end
% save('./method/monomial_delta/xm/1m.mat','paramlist');