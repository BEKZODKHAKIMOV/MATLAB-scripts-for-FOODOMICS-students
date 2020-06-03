function [ output] = pvalue_fdr_bkh(varargin)
% "[ output] = pvalue_fdr_bkh(data, class, P_thres, FDR_value,FDR_thres, Q_thres, box_plot_op, design_labels,box_type,var_label);
%
%"pvalue_fdr_bkh" computes ANOVA, mafdr, and fdr and returns P values, FDR Corrected P, FDR, and Q values 
% 
% INPUTS:
% (1) data = data (double) e.g. X(Samples, Variables)
% (2) class = class for ANOVA e.g. [1 1 1 2 2 2 ... N N N]
%
% OPTIONAL INPUTS:
% (3) P_thres = Threshold for P-value (default = 0.05) 
% (4) FDR_value = Threshold for Fasle Discovery Rate in (%) e.g 0.1=10%, (default = 0.1) 
% (5) FDR_thres = Threshold for FDR corrected P-value (default = 0.05) 
% (6) Q_thres = = Threshold for Q ( measures of hypothesis testing error for each observation in PValues) (default = 0.05) 
% (7) box_plot_op = If 1 box plots will be plotted for only Significant mets, If 2 for all, If 0 (zero) none
% (8) design_labels = name of the class (character array), e.g. 'treatment'
% (9) var_label=varargin{9};
% (10) box_type = if 'bekzod' then Normal scatter-box style plot, else MATLAB's default boxplot will be used
%
% OUTPUTS:
% output - structure, which contains below items
% P_FDRcorrected = FDR corrected P values
% Index_of_P_FDRcorrected = Indices of FDR corrected P values
% FDR
% Q
% details = contains All Other Test Results including (Non FDR corrected P values ect.) 
%
%
% 07.11.2017
% % %--------------------------
% % Bekzod Khakimov
% % Associate Professor
% % Chemometrics and Analytical Technology Research Group
% % Deprtment of Food Science, University of Copenhagen
% % Rolighedsvej 26, Frederiksberg, 1958, Denmark
% % Office: +45 3532-8184, Mobile: +45 2887-4454
% % Email: bzo@food.ku.dk 
% % http://food.ku.dk/english/staff/?pure=en/persons/388946
% % https://scholar.google.com/citations?user=vhBBNdUAAAAJ&hl=en

%% Get Inputs

% Get INputs:
data=varargin{1};
class=varargin{2};

if nargin<3 || isempty(varargin{3}); P_thres=0.05; else P_thres=varargin{3}; end
if nargin < 4 || isempty(varargin{4});  FDR_value=0.1;  else FDR_value=varargin{4}; end
if nargin < 5 || isempty(varargin{5});  FDR_thres=0.05;  else FDR_thres=varargin{5}; end
if nargin < 6 || isempty(varargin{6});  Q_thres=0.05;  else Q_thres=varargin{6}; end
if nargin < 7 || isempty(varargin{7});  box_plot_op=0;  else box_plot_op=varargin{7}; end
if nargin < 8 || isempty(varargin{8});  design_labels='NoDesign';  else design_labels=varargin{8}; end
if length(varargin)<9 || isempty(varargin{9})
    var_label=num2str([1:size(data,2)]');
else
    var_label=varargin{9};
end
if nargin < 10 || isempty(varargin{10});  box_type='bekzod';  else box_type=varargin{10}; end



%% Check Class Order is OK 

if issorted(class)
    class=class;
else
    [s1 s2]=sort(class);
    class=class(s2);
    data=data(s2,:);
end
                

%% ANOVA

for i=1:size(data,2)  
    nan1=find(isnan(data(:,i))==1);
    data1=data(:,i);
    class1=class;
    data1(nan1,:)=[];
    class1(nan1,:)=[];
[P(i),ANOVATAB,STATS]=anova1(data1,class1,'off');
MULTICOMPARISON{i} = multcompare(STATS,'display','off');
Eff_size(i)=(ANOVATAB{2,2}/ANOVATAB{4,2})*100;
end  

%%  FDR
% Estimate False Discovery Rate (FDR) and  measures of hypothesis testing error for each P-Values (q)
pvalues=P;
try
[FDR1, q] = mafdr(pvalues);
catch
    FDR1=pvalues;
    q=pvalues;
end
    
% Calculate FDR Corrected P-Values
[pthr,pcor,padj] = fdr(pvalues);
% Get Only Significant P-Values given by Pther value
 [f1 f2]=find(P<=P_thres);   
 if isempty(f2); f2=1:length(P);  warning( [ 'There are No Significant Variables with P - Value of <= ' num2str(P_thres)  ]);  else f2=f2; end
 pvalues1=P(f2);   
 % Get FDR of Only Significant P-Values given by Pther value
 FDR2=FDR1(f2); q2=q(f2); padj2=padj(f2); 
% Get Only  Significant P (FDR corrected)-Values given by Pther value
[f4 f3]=find(padj<=FDR_thres);    
f3a=f3;
if isempty(f3); f3=1:length(P);  warning(['There are No Significant Variables with P (FDR corrected) Value of <= ' num2str(FDR_thres) ]);  else f3=f3; end
pvalues2=P(f3); 
FDR3=FDR1(f3); q3=q(f3); padj3=padj(f3); 

output.details.P_values_All=P;
output.details.P_values_of_Significants=pvalues1;
output.details.P_values_After_FDR_correction=padj;
output.details.P_values_of_Significants_After_FDR_correction=padj2;
output.details.FDRsignificant_P_values=pvalues2;
output.details.FDRsignificant_Pvalues_After_FDR_correction=padj3;

output.P_FDRcorrected=padj3;

output.details.FDR_All=FDR1;
output.details.FDR_of_Significants=FDR2;
output.details.FDR_of_FDRcorected_Significants=FDR3;
output.FDR=FDR3;

output.details.Q_All=q;
output.details.Q_of_Significants=q2;
output.details.Q_of_FDRcorected_Significants=q3;
output.Q=q3;

output.details.Index_of_P_values_All=f2;
output.Index_of_P_FDRcorrected=f3a;

output.Effect_size=Eff_size;
output.MULTICOMPARISON=MULTICOMPARISON;


%%  Plot
figure
fz=6;
% subplot(1,3,1);   
 x=cat(1,FDR1, q, padj);  col={'bs','go','m^','rd','k*'};
%   for i=1:size(x,1);
%       plot(pvalues, x(i,:),col{i});    
%       xlabel(['P-Values: <=' num2str(P_thres) ' (' num2str((size(find(pvalues<=P_thres),2))*100/size(pvalues,2)) ...
%           '%)' ] ); ylabel('FDR, Q, P (FDR corrected)'); hold on;
%   end;
%   legend({['FDR: <=' num2str(FDR_value) '% (' num2str((size(find(FDR1<=FDR_value),2))*100/size(FDR1,2)) '%)' ]...
%       ['Q: <=' num2str(Q_thres) ' (' num2str((size(find(q<=Q_thres),2))*100/size(q,2)) '%)' ]...
%       ['P (FDR corrected): <=' num2str(FDR_thres) ' (' num2str((size(find(padj<=FDR_thres),2))*100/size(padj,2)) '%)' ]...
%       },'Location','northwest'); 
%   title([ 'Total P - values = ' num2str(size(P,2)) ], 'FontSize',9); hold on; line(pvalues, ones(1,length(pvalues))-(1-FDR_thres)); not_so_tight;
  
%%  Significant P - Values
% Estimate False Discovery Rate (FDR) and  measures of hypothesis testing error for each P-Values (q)
 subplot(1,3,2); 
%  [f1 f2]=find(P<=Pther); pvalues=P(f2);

% FDR2=FDR1(f2); q2=q(f2); padj2=padj(f2); 
%  Plot
x=cat(1,FDR2, q2, padj2);  
  for i=1:size(x,1)
      plot(pvalues1, x(i,:),col{i});    
      xlabel(['P-Values: <=' num2str(P_thres) ' (' num2str((size(find(pvalues1<=P_thres),2))*100/size(pvalues1,2)) ...
          '%)' ], 'FontSize',fz ); hold on;
  end
  legend({['FDR: <=' num2str(FDR_value) '% (' num2str((size(find(FDR2<=FDR_value),2))*100/size(FDR2,2)) '%)' ]...
      ['Q: <=' num2str(Q_thres) ' (' num2str((size(find(q2<=Q_thres),2))*100/size(q2,2)) '%)' ]...
      ['P (FDR corrected): <=' num2str(FDR_thres) ' (' num2str((size(find(padj2<=FDR_thres),2))*100/size(padj2,2)) '%)' ]...
      },'Location','northwest', 'BOX','OFF','FontSize',fz+1);
 title([ 'Significant P - values = ' num2str(size(padj2,2)) ], 'FontSize',fz); hold on; line(pvalues1, ones(1,length(pvalues1))-(1-FDR_thres)); not_so_tight;
  
%%  Significant P (FDR correcred) - Values
% Estimate False Discovery Rate (FDR) and  measures of hypothesis testing error for each P-Values (q)

if ~isempty(f3a)
    subplot(1,3,3); 
%  [f1 f2]=find(padj<=Pther); pvalues=P(f2);
% FDR2=FDR1(f2); q2=q(f2); padj2=padj(f2); 
%  Plot
x=cat(1,FDR3, q3, padj3);  
  for i=1:size(x,1)
      plot(pvalues2, x(i,:),col{i});    
      xlabel(['P-Values: <=' num2str(P_thres) ' (' num2str((size(find(pvalues2<=P_thres),2))*100/size(pvalues2,2)) ...
          '%)' ], 'FontSize',fz ); hold on;
  end
  legend({['FDR: <=' num2str(FDR_value) '% (' num2str((size(find(FDR3<=FDR_value),2))*100/size(FDR3,2)) '%)' ]...
      ['Q: <=' num2str(Q_thres) ' (' num2str((size(find(q3<=Q_thres),2))*100/size(q3,2)) '%)' ]...
      ['P (FDR corrected): <=' num2str(FDR_thres) ' (' num2str((size(find(padj3<=FDR_thres),2))*100/size(padj3,2)) '%)' ]...
      },'Location','northwest', 'BOX','OFF','FontSize',fz+1);
 title([ 'Significant P (FDR corrected) - values = ' num2str(size(padj3,2)) ], 'FontSize',fz);   hold on; line(pvalues2, ones(1,length(pvalues2))-(1-FDR_thres)); not_so_tight;
else
     subplot(1,3,3); 
      plot(1,1,'k.','MarkerSize',24);    
      ww=['Zero Sig.Vars. with (FDR corr.) P-value of <= ' num2str(FDR_thres) ];
      title(ww, 'FontSize',fz);   hold on; line(pvalues2, ones(1,length(pvalues2))-(1-FDR_thres)); not_so_tight;
end

% print( 'FDR Corrected P values','-dpng','-r0');

  
  %%
  subplot(1,3,1);   
x=cat(1,FDR1, q, padj);  col={'bs','go','m^','rd','k*'};
  for i=1:size(x,1)
      plot(pvalues, x(i,:),col{i});    
      xlabel(['P-Values: <=' num2str(P_thres) ' (' num2str((size(find(pvalues<=P_thres),2))*100/size(pvalues,2)) ...
          '%)' ] , 'FontSize',fz); ylabel('FDR, Q, P (FDR corrected)', 'FontSize',fz); hold on;
  end
  legend({['FDR: <=' num2str(FDR_value) '% (' num2str((size(find(FDR1<=FDR_value),2))*100/size(FDR1,2)) '%)' ]...
      ['Q: <=' num2str(Q_thres) ' (' num2str((size(find(q<=Q_thres),2))*100/size(q,2)) '%)' ]...
      ['P (FDR corrected): <=' num2str(FDR_thres) ' (' num2str((size(find(padj<=FDR_thres),2))*100/size(padj,2)) '%)' ]...
      },'Location','northwest', 'BOX','OFF','FontSize',fz+1); 
  title([ 'Total P - values = ' num2str(size(P,2)) ], 'FontSize',fz); hold on; line(pvalues, ones(1,length(pvalues))-(1-FDR_thres)); not_so_tight;

%    print( 'FDR Corrected P values','-dpdf','-r0');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%     % ANOVA
%     for pi=1:length(facs)
%         ANOVA_results{pi}=pvalue_fdr_bkh(data,design(:,pi));
%         print([filename '-ANOVA-Factor' num2str(facs(pi))], '-dpng','-r0');
%         close all
%     end;
    
        
if box_plot_op==1
    
    % for f_des=1:length(ANOVA_results)
    anov=output;
    des=design_labels;
    if ~isempty(anov.Index_of_P_FDRcorrected)
        for f_met=1:length(anov.Index_of_P_FDRcorrected)
            figure('units','normalized','outerposition',[0 0 1 1]);
            met=anov.Index_of_P_FDRcorrected(f_met);
            met_name=['MetName-' num2str(f_met) ': ' var_label(met,:)];
            p=['p-val = ' num2str(round(anov.P_FDRcorrected(f_met),5))];
            ef=['EffectSize = ' num2str(round(anov.Effect_size(met),2)) ' %'];
            try
                
                
                nan1=find(isnan(data(:,met))==1);
                data1=data(:,met);
                class1=class;
                data1(nan1,:)=[];
                class1(nan1,:)=[];
                
                if issorted(class1)
                    class1=class1;
                else
                    [s1 s2]=sort(class1);
                    class1=class1(s2);
                    data1=data1(s2,:);
                end;
                
                if strcmp(box_type,'bekzod')
                    box_plot_bkh(data1,class1);
                else
                    boxplot(data1,class1);
                end;
                
                legend({des, ['Mean-Met#' num2str(met)], met_name},'Location','northwest','BOX','OFF');
                title([ p ' / ' ef]);
                xlabel('Sample Class');
                ylabel(met_name);
                set(gcf,'color','w');
                grid('on');
                print([des '-Met' num2str(met) '-BoxPlot'], '-dpng','-r0');
                close all
            catch
                plot(1,1);
            end
        end
    end
    % end


        

elseif box_plot_op==2
    
    % for f_des=1:length(ANOVA_results);
    anov=output;
    des=design_labels;
    for met=1:size(data,2)
        figure('units','normalized','outerposition',[0 0 1 1]);
        met_name=['MetName-' num2str(met) ': ' var_label(met,:)];
        p=['p-val = ' num2str(round(anov.details.P_values_After_FDR_correction(met),5))];
        ef=['EffectSize = ' num2str(round(anov.Effect_size(met),2)) ' %'];
        try
            
            nan1=find(isnan(data(:,met))==1);
            data1=data(:,met);
            class1=class;
            data1(nan1,:)=[];
            class1(nan1,:)=[];
            
            if issorted(class1)
                class1=class1;
            else
                [s1 s2]=sort(class1);
                class1=class1(s2);
                data1=data1(s2,:);
            end
            
            if strcmp(box_type,'bekzod')
                box_plot_bkh(data1,class1);
            else
                boxplot(data1,class1);
            end;
            
            legend({des, ['Mean-Met#' num2str(met)], met_name},'Location','northwest','BOX','OFF');
            title([ p ' / ' ef]);
            xlabel('Sample Class');
            ylabel(met_name);
            set(gcf,'color','w');
            grid('on');
            print([des '-Met' num2str(met) '-BoxPlot' ], '-dpng','-r0');
            close all
        catch
            plot(1,1);
        end
    end
    % end;
    
end

    
    
    
end

