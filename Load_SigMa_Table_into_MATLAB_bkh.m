

clear
close all
clc
dir1='C:\Users\pvw793\Desktop\New folder (9)'; % CHANGE TO YOUR DIRECTORY WHERE U SAVED SIGMA TABLE
cd(dir1)

% Import the data
[~, ~, DATAS1] = xlsread( [dir1 '\DATA.xlsx'],'METABOLITE TABLE');
DATAS1(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),DATAS1)) = {''};
idx = cellfun(@ischar, DATAS1);
DATAS1(idx) = cellfun(@(x) string(x), DATAS1(idx), 'UniformOutput', false);
clearvars idx;
x=DATAS1;


SampleNames=x(15:end,2);
SampleNumbers=cell2mat(x(15:end,1));
MetID=x(12,3:end);
Met_ppm=cell2mat(x(2,3:end));
MetTable=cell2mat(x(15:end,3:end));

cd(dir1)
save data SampleNames SampleNumbers MetID Met_ppm=cell2mat(x(2,3:end));







