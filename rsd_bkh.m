function [RSD, STD, MEAN] = rsd_bkh(varargin);
% "rsd_bkh"  [RSD, STD, MEAN] = rsd_bkh(X) computes relative standard deviation (RSD) of X data 
% Input
% X(i,j) where i=samples, and j=variables 
% Output
% RSD, STD, MEAN
%
% 07.11.2017
% % %--------------------------
% % Bekzod Khakimov
% % Associate Professor
% % Chemometrics and Analytical Technology Research Group
% % Deprtment of Food Science, University of Copenhagen
% % Rolighedsvej 26, Frederiksberg, 1958, Denmark
% % Office: +45 3532-8184, Mobile: +45 2887-4454
% % Email: bzo@food.ku.dk 
% % http://food.ku.dk/english/staff/?pure=en/persons/388946
% % https://scholar.google.com/citations?user=vhBBNdUAAAAJ&hl=en
X=varargin{1};
% mm2=varargin{2};

[s1 s2]=size(X);
for i=1:s2;
 m=nanmean_bkh(X(:,i)); % get MEAN; 
MEAN(i)=m;
s=nanstd_bkh(X(:,i)); % get STD
STD(i)=s;
rd=(s*100)./m; % get RSD
RSD(i)=rd;
end

