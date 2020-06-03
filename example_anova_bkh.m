%% How to do ANOVA

% 1. Load you data
cd 'D:\LIFE\TEACHING\FOODOMICS\2020\Project Work\GC-MS datasets\sorghum_mutant_gcms';
load('sorghum_mutant_gcms.mat');

% 2. Mean Centring is MUST for PCA - use scale_bkh.m function
X=scale_bkh(TIC,'1norm'); % type "help scale_bkh" in MATLAB for more options of scaling

% 3. Perform ANOVA with False Discover Rate Correction & Plot the Results
[ output] = pvalue_fdr_bkh(X(:,1001:2005), design(:,3), 0.05, 0.1,0.05, 0.05, 1,'Line');
% type "help pvalue_fdr_bkh" in MATLAB to read more about pvalue_fdr_bkh.m funciton and its outputs



% Bekzod Khakimov (bzo@food.ku.dk)
% 23.05.2020






 
 