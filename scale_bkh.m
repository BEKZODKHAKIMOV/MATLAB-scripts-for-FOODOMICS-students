function [ scaled_data ] = scale_bkh(data,scaling_method)
% This function calculates various scalings of data(i,j), where i=samples, j=variables
% [ ten_scalings single_scaling] = scale_bkh(data,single_scaling_method) 
% NaNs are not included
% Inspired by doi:10.1186/1471-2164-7-142 
%
% INPUT:
% data = data(i,j)
% single_scaling_method e.g., 'auto' or 'pareto' or 'none'
%
% Outputs:
% scaled_data(i,j), the same size as Input data(i,j)
% 
% Bekzod Khakimov (bzo@food.ku.dk)
% % 17.05.2018
% 
% 
% Bekzod Khakimov
% Associate Professor
% 
% University of Copenhagen
% Department of Food Science
% Chemometrics and Analytical Technology 
% Rolighedsvej 26, Frederiksberg, 1958, Denmark
% 
% DIR +45 3532-8184
% MOB +45 2887-4454
% bzo@food.ku.dk
% bekzod@hotmail.co.uk
% www.models.life.ku.dk

%if isdataset(data); data=data.data; end;

if nargin<2;
    
    for i=1:size(data,2);
        q1=data(:,i);
        nans = isnan(q1);
        q2=q1;
        q2(nans) = [];
        mean1=nanmean_bkh(q1);
        mean2(i,1)=mean1;
        std1=nanstd_bkh(q1);
        std2(i,1)=std1;
        data_mean(:,i)=q1-mean1;
        data_auto(:,i)=(q1-mean1)./std1;
        data_pareto(:,i)=(q1-mean1)./sqrt(std1);
        data_range(:,i)=(q1-mean1)./(max(q2)-min(q2));
        data_vast(:,i)=((q1-mean1)./std1)*(mean1/std1);
        data_level(:,i)=(q1-mean1)./mean1;
        data_logtrans(:,i)=(log10(q1))-nanmean_bkh(log10(q1));
        data_powertrans(:,i)=(sqrt(q1))-nanmean_bkh(sqrt(q1));
    end;
    
    scaled_data.mean=mean2;
    scaled_data.std=std2;
    scaled_data.data_mean=data_mean;
    scaled_data.data_auto=data_auto;
    scaled_data.data_pareto=data_pareto;
    scaled_data.data_range=data_range;
    scaled_data.data_vast=data_vast;
    scaled_data.data_level=data_level;
    scaled_data.data_logtrans=data_logtrans;
    scaled_data.data_powertrans=data_powertrans;
    
else
    
    switch scaling_method
        
        case 'mean'
            for i=1:size(data,2);
                q1=data(:,i);
                mean1=nanmean_bkh(q1);
                data_mean(:,i)=q1-mean1;
            end;
            scaled_data=data_mean;
            
        case 'auto'
            for i=1:size(data,2);
                q1=data(:,i);
                mean1=nanmean_bkh(q1);
                std1=nanstd_bkh(q1);
                data_auto(:,i)=(q1-mean1)./std1;
            end;
            scaled_data=data_auto;
            
        case 'pareto'
            for i=1:size(data,2);
                q1=data(:,i);
                mean1=nanmean_bkh(q1);
                std1=nanstd_bkh(q1);
                data_pareto(:,i)=(q1-mean1)./sqrt(std1);
            end;
            scaled_data=data_pareto;
            
        case 'range'
            for i=1:size(data,2);
                q1=data(:,i);     nans = isnan(q1);    q2=q1;   q2(nans) = [];
                mean1=nanmean_bkh(q1);
                data_range(:,i)=(q1-mean1)./(max(q2)-min(q2));
            end;
            scaled_data=data_range;
            
        case 'vast'
            for i=1:size(data,2);
                q1=data(:,i);
                mean1=nanmean_bkh(q1);
                std1=nanstd_bkh(q1);
                data_vast(:,i)=((q1-mean1)./std1)*(mean1/std1);
            end;
            scaled_data=data_vast;
            
        case 'level'
            for i=1:size(data,2);
                q1=data(:,i);
                mean1=nanmean_bkh(q1);
                data_level(:,i)=(q1-mean1)./mean1;
            end;
            scaled_data=data_level;
            
        case 'log'
            for i=1:size(data,2);
                q1=data(:,i);
                data_logtrans(:,i)=(log10(q1))-nanmean_bkh(log10(q1));
            end;
            scaled_data=data_logtrans;
            
        case 'power'
            for i=1:size(data,2);
                q1=data(:,i);
                data_powertrans(:,i)=(sqrt(q1))-nanmean_bkh(sqrt(q1));
            end;
            scaled_data=data_powertrans;
            
    end;
    
    
end
