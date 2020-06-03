function [data_std data_var] = nanstd_bkh(data)
% This function calculates STD and VARIANCE of data(i,j), where i=samples, j=variables
% [data_std data_var] = nanmean_bkh(data);
% NaNs are not included
% STD is calculated as described in doi:10.1186/1471-2164-7-142 
% 
% Outputs:
% data_std(1,j) = STD
% data_var(1,j)= VARIANCE
%
% Bekzod Khakimov (bzo@food.ku.dk)
% 17.05.2018
%

data_org=data;
%if isdataset(data_org); data=data.data; end;

for j=1:size(data,2);
q1=data(:,j);

nans = isnan(q1);
q1(nans) = [];
n = sum(~nans);
n(n==0) = NaN; 

q2=nanmean_bkh(q1);
q3=q1-q2;
q4=q3.^2;
q5=nansum(q4);

var1=q5/(n-1);
std1=sqrt(var1);

data_std(:,j)=std1;
data_var(:,j)=var1;
end;

% if isdataset(data_org);
%     data_org=data_org(1,:);
%         data_org.data=data_std;
%     data_std=data_org;
%         data_org.data=data_var;
%     data_var=data_org;
% end;

end

