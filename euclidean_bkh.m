function [euc_distance] = euclidean_bkh(vector1,vector2)
% [euc_distance] = euclidean_bkh(vector1,vector2)
% This function calculates Euclidean distance of two vectors
% Inputs:
% vector1(i,1) & vector2(i,1) are two vectors where i = samples
%
% 21.05.2020
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
% www.models.life.ku.dk


euc_distance  = sqrt(nansum((vector1-vector2) .^ 2))

end

