
%% RIconvert
%
%
% (1) Load Your PARADISe data
%
%
clear
clc
dir1='C:\Users\pvw793\Dropbox\Cotton Oil UZB\DATASETS\GCMS\28022020_Splitless_Inj_Direct_Oil_GCMS'; % CHANGE TO YOUR DIRECTORY WHERE U SAVED PARADISe report
cd(dir1)
[~, ~, report] = xlsread( [dir1 '\\report.xlsx'],'Relative concentrations');
report(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),report)) = {''};
a1=report;
SampleID=a1(4:end,1);
x=cell2mat(a1(4:end,2:end));
rt=cell2mat(a1(1,2:end))';
metsID=a1(3,2:end)';

%
%
% (2) Calculate Retention Index (Kovatz Index)
%
%
load('alkmix_sorghum.mat'); 
RT=rt*60; % Convert RT from min to seconds, since RTs are given in sec in the alkmix_sorghum file
for i=1:length(RT)
    RI(i,1) = retentionindex(RT(i),alkmix_sorghum);
end;


%
%
% (3) SAVE
%
%
cd(dir1)
save sorghum_paradise SampleID x rt metsID RI



%% EIMSconvert
%
%
% (1) Load Your PARADISe data
%
%
clc
dir1='C:\Users\pvw793\Dropbox\Cotton Oil UZB\DATASETS\GCMS\28022020_Splitless_Inj_Direct_Oil_GCMS'; % CHANGE TO YOUR DIRECTORY WHERE U SAVED PARADISe report
cd(dir1)
[~, ~, report] = xlsread( [dir1 '\\report.xlsx'],'Resolved mass spectra');
MS=cell2mat(report(2:end,2:end));


%
%
% Convert PARADISe deconvoluted MS into NIST readible text format
%
%
FileName='sorghum_EIMS';
RIs=RI;
[ output_file ] = matlab2nist_bkh(MS, FileName, RIs) % this will create sorghum_EIMS NIST readible text file, which you will have to open in NIST and perform Level2 Identification






