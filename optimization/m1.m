%% prerequisite
init; clear all;

%% turn off warnings
warning('off','all');

%% extract info from filename of format 'mr.m'
fname = mfilename;
r = str2num(fname(2));
sfilename = strcat(fname(2),'m.mat');
sfilepath = strcat('./methods/monomial/xm/',sfilename);

%% create the file if it does not exist
if exist(sfilepath,'file')~=2
    disp(strcat('---- creating file [',sfilename,'] to save the coefficients---'));
  fileID = fopen(sfilepath,'w'); % create file
  paramlist{1,1}=[]; %piform coefficients
  paramlist{1,2}=[]; %sigform coefficients
  paramlist{1,3}=[]; %coefficient of variation
  paramlist{1,4}=[]; %entropy
  save(sfilepath,'paramlist');
  fclose(fileID);
end

%% variables
Max = 10000;
nmax=1e3;           %maximum number of cycle of ga and bgd
maxtry = 100;       %maximum of attempts to optimize the given order
epsln = 0;          %precision for BGD
k=1;

%% optimization (rm)
disp(strcat('-------',fname(2),'m optimization-------'));
while k<=Max
    load(sfilename);
    if k<=size(paramlist,1) && ~isempty(paramlist{k,1})
        if exist(sfilepath,'file')~=2, quit; end; bv=false;
        if isempty(paramlist{k,2}), paramlist{k,2}=m_weights(r,paramlist{k,1}); bv=true; end
        if isempty(paramlist{k,3}), paramlist{k,3}=m_cv(r,paramlist{k,1},'inf'); bv=true; end
        if isempty(paramlist{k,4}), paramlist{k,4}=m_entropy(r,paramlist{k,1},'per'); bv=true; end
        if bv, disp(['update savefile with k=',num2str(k)]); save(sfilepath,'paramlist'); end
        k=k+1;
    else
        disp(['---Optimizing order k=',num2str(k),'---']);
        y=[]; cv=inf;
        for i=1:maxtry
            if exist(sfilepath,'file')~=2, quit; end
            %if mod(k,2)==0, x = [1,paramlist{k-1,1}(2:end),pi/2*rand];
            %else, x = [1,paramlist{k-2,1}(2:end),pi/2*rand,pi/4*rand];end
             %w=7*pi/8; if r==1, w=pi/2; end
            x=[1,paramlist{k-1,1}(2:end),pi*rand];
            %if mod(k,2)==0, x=[1,w,pi*rand(1,k)]; else, x=[1,paramlist{k-1,1}(2:end),pi*rand]; end
            %x=m_hses(nmax,r,x,'inf');  cvx=m_cv(r,x,'inf'); 
            x=m_bgd(epsln,nmax,r,x,'inf'); cvx=m_cv(r,x,'inf');
            if cvx<cv && cvx>0, y=x; cv=cvx; end
        end
        if ~isempty(y)
            paramlist{k,1}=y; 
            paramlist{k,2}=m_weights(r,y);
            paramlist{k,3}=cv; 
            paramlist{k,4}=m_entropy(r,y,'per');
            disp(['update savefile with k=',num2str(k)]); save(sfilepath,'paramlist');
            k=k+1;
        end
    end
end
disp( strcat('----',fname(2),'m optimization finished---'));

%% exit matlab
quit;