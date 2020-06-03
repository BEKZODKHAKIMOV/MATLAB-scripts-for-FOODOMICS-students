
%% Save MATLAB nmrdata in excel

close all
clc

xlswrite('data.xlsx',nmrdata.data',1,'B3');
xlswrite('data.xlsx',{'ppm'},1,'A2');
xlswrite('data.xlsx',nmrdata.ppm_mean',1,'A3');
xlswrite('data.xlsx','Samples',1,'A1');
xlswrite('data.xlsx',nmrdata.subjects',1,'B2');





