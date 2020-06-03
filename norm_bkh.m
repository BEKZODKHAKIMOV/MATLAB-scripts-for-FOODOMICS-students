function [data_norm] = norm_bkh(varargin)
% This function "[data_norm] = norm_bkh(varargin)"
% normalizes a data (varargin{1}) using one of siz methods below & returns only a normalized data 
%
% INPUTS:
% data = data(m,n) data, where m= samples, n=variables
% one of below:
% (1) '1norm' = 1Norm
% (2) '2norm' = 2Norm
% (3) 'infnorm' = Int-Norm (or sometimes called max norm)
% (4) 'pqn' = Probabilistic Quotient Normalization (PQN)
% (5) 'mfc' = Median Fold Change Normalization (MFC)
% (6) 'refnorm' = Reference-Normalization
%
% OPTIONAL INPUTS:
% for 'pqn' & 'mfc' e.g., [1:10] meaning samples 1-to-10 are pooled controls
% for 'refnorm' e.g., [100:125] meaning variables 100-to-125 is the area of
% reference Signal according to which entire data should be normalized
% (e.g., ERETIC signal, or IS)
%
% OUTPUTS:
% data_norm = normalized data
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
%
% 11 May 2019



data=varargin{1};
% if isdataset(data); data=data.data; end
% data2=varargin{1};

norm_method=varargin{2};

% 1Norm
switch strcmp(norm_method,'1norm')
    case 1
        for i=1:size(data)
            data_norm(i,:)=data(i,:)/nansum(data(i,:));
        end
%         if isdataset(data2)
%             data2.data=data_norm; clear data_norm;
%             data_norm=data2;
%         else
%             data_norm=data_norm;
%         end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% 2Norm
switch strcmp(norm_method,'2norm')
    case 1
        for i=1:size(data)
            data_norm(i,:)=data(i,:)/sqrt(nansum(data(i,:).^2));
        end
%         if isdataset(data2)
%             data2.data=data_norm; clear data_norm;
%             data_norm=data2;
%         else
%             data_norm=data_norm;
%         end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Inf-Norm
switch strcmp(norm_method,'infnorm')
    case 1
        for i=1:size(data)
            data_norm(i,:)=data(i,:)/nanmax(data(i,:));
        end
%         if isdataset(data2)
%             data2.data=data_norm; clear data_norm;
%             data_norm=data2;
%         else
%             data_norm=data_norm;
%         end
end


% PQN-Norm
switch strcmp(norm_method,'pqn')
    case 1
        if nargin<3 %
            data_norm=data;
        else
            pooled_control_samples=varargin{3};
            data_norm=data(pooled_control_samples,:);
        end
        for i=1:size(data_norm,1)
            a1(i,:)=data_norm(i,:)/nansum(data_norm(i,:));
        end
        a2 = nanmedian(a1);
        for i = 1:size(data,1)
            a3 = abs(a1(i,:)./a2);
            a4 = nanmedian(a3);
            data_norm(i,:) = data(i,:)/a4;
            clear a3 a4
        end
%         if isdataset(data2)
%             data2.data=data_norm; clear data_norm;
%             data_norm=data2;
%         else
%             data_norm=data_norm;
%         end
end




%  Median Fold Change Normalization (MFC)
switch strcmp(norm_method,'mfc')
    case 1
        if nargin<3 %
            data_norm2=nanmedian(data);
        else
            pooled_control_samples=varargin{3};
            data_norm2=nanmean_bkh(data(pooled_control_samples,:));
        end
        
        for i=1:size(data,1)
            a22=data(i,:)./data_norm2;
            a22(a22==0)=[];
            a1=nanmedian(a22);
            data_norm(i,:)=data(i,:)/a1;
        end
%         if isdataset(data2)
%             data2.data=data_norm; clear data_norm;
%             data_norm=data2;
%         else
%             data_norm=data_norm;
%         end
end



% Reference-Norm
switch strcmp(norm_method,'refnorm')
    case 1
        if nargin<3 %
            norm_region=[1:size(data,2)];
        else
            norm_region=varargin{3};
        end
        [s1 s2] = size(data);
        for i = 1:s1
            ref1 = nansum(data(i,norm_region));
            data_norm2(i,:) = data(i,:)/ref1;
            ref(i)=ref1;
        end
        mean_ref = nanmean_bkh(ref);
        data_norm = data_norm2*mean_ref; %  to scale-up to the original intensities
%       coef =(ref./mean_ref).^-1; % normalization coefficients ( can be used for multiplying the original dataset)
%         if isdataset(data2)
%             data2.data=data_norm; clear data_norm;
%             data_norm=data2;
%         else
%             data_norm=data_norm;
%         end
end












