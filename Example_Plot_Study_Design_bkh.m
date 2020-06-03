

% Plot a Design of Your Study
dir1='D:\LIFE\TEACHING\FOODOMICS\2020\Project Work\GC-MS datasets\sorghum_mutant_gcms'; % CHANGE dir1 to Your Directory
cd(dir1);
load('design.mat');

figure
for i=1:size(design,2)
    
    subplot(size(design,2),1,i);
    plot(design(:,i));
    legend(design_label{i},'Location','northwest');
    axis tight;
    hold on;
end
xlabel('Sample');
    

