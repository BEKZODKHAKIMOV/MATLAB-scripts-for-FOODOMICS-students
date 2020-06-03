%% How to do PCA

% 1. Load you data
cd 'D:\LIFE\TEACHING\FOODOMICS\2020\Project Work\GC-MS datasets\sorghum_mutant_gcms';
load('sorghum_mutant_gcms.mat');

% 2. Mean Centring is MUST for PCA - use scale_bkh.m function
X=scale_bkh(TIC,'auto'); % type "help scale_bkh" in MATLAB for more options of scaling

% 3. Develop a PCA model
[COEFF, SCORE, LATENT, TSQUARED, EXPLAINED, MU] = pca(X,'NumComponents',3); % type "help pca" in MATLAB to read more about pca.m funciton and its outputs

% 4. Plot PCA scores and loading plots 
PCA_model.SCORE=SCORE;
PCA_model.COEFF=COEFF;
PCA_model.EXPLAINED=EXPLAINED;
plot_pca_bkh(PCA_model); % type "help plot_pca_bkh" in MATLAB to read more the plotting options 
% Or use plotting's Optional Inputs to color by your study design
plot_pca_bkh(PCA_model,design(:,3), design_label{3},0, 3)



% Bekzod Khakimov (bzo@food.ku.dk)
% 23.05.2020






 
 