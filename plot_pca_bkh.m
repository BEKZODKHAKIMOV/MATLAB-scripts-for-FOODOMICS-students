function plot_pca_bkh(PCA_model,design, design_name,print1, plotted_PCs)
% "plot_pca_bkh(PCA_model,design, design_name,print1, plotted_PCs)"
% INPUTS:
% PCA_model: structure array formed from the outputs of MATLAB's pca function
% PCA_model.SCORE;
% PCA_model.COEFF;
% PCA_model.EXPLAINED;
%
% OPTIONAL INPUTS
% design(i,1), where i=samples' categorical variable (e.g. [1 1 1 2 2 2 ...])
% design_name, character array, e.g. 'treatment'
% print1 = 1 will print figures, otherwise won't print;
% plotted_PCs = e.g. 2, means 1 vs 2 Or 3, means 1vs2, 1vs3, and 2vs3
% 
% Bekzod 08.08.2019
%

 % Get Inputs
sc=PCA_model.SCORE;
ld=PCA_model.COEFF;
exp_var=PCA_model.EXPLAINED;


if nargin<2 || isempty(design)
design=ones(size(sc,1),1);
else
    design=design;
end


if nargin<3 || isempty(design_name)
design_name='NoDesign';
else
    design_name=design_name;
end


if nargin<4 || isempty(print1)
print1=0;
else
    print1=print1;
end



if nargin<5 || isempty(plotted_PCs)
s1=size(sc,2);
else
    s1=plotted_PCs;
end
u1=unique(design);
col=color_bkh;

% Plot Scores
    
for i=1:s1
    for k=i:s1
        if i~=k
            figure
            leg={};
            for ki=1:length(u1)
                leg{ki}=['Class ' num2str(u1(ki))];
                sc1=sc(find(design==u1(ki)),i);
                sc1(isnan(sc1))=[];
                sc2=sc(find(design==u1(ki)),k);  
                sc2(isnan(sc2))=[];
                plot(sc1,sc2,'.','Color',[col(ki,:) 0.3],'MarkerSize',24);
                xlabel(['PC' num2str(i) '(' num2str(round(exp_var(i),1)) '%)']);
                ylabel(['PC' num2str(k) '(' num2str(round(exp_var(k),1)) '%)']);
                title(['Scores (' design_name ')']);hold on;
                set(gcf,'color','w');
                grid('on');
                clear ki
            end
            legend(leg,'BOX','OFF');
            
            if print1==1
                print([ 'Scores-' design_name '-' 'PC' num2str(i) '-vs-' num2str(k)],'-dpng','-r0');
                pause(0.1);close all;
            end
            pause(0.1);
        end
    end
end

% Plot Loadings

for i=1:s1
    for k=i:s1
        if i~=k
            figure
            led={};
%             for ki=1:length(u1);
%                 leg{ki}=['Class ' num2str(ki)];
                sc1=ld(:,i);
                sc1(isnan(sc1))=[];
                sc2=ld(:,k);  
                sc2(isnan(sc2))=[];
                plot(sc1,sc2,'k.','MarkerSize',14);
                xlabel(['PC' num2str(i) '(' num2str(round(exp_var(i),1)) '%)']);
                ylabel(['PC' num2str(k) '(' num2str(round(exp_var(k),1)) '%)']);
                title(['Loadings (' design_name ')']);hold on;
                set(gcf,'color','w');
                grid('on');
                hold on;
                for ko=1:length(sc1)
                    text(sc1(ko),sc2(ko),num2str(ko),'FontSize',9);
                end
            
%             end; 
           % legend(leg,'BOX','OFF');            
            if print1==1
                print([ 'Loadings-' design_name '-' 'PC' num2str(i) '-vs-' num2str(k)],'-dpng','-r0');
                pause(0.1);close all;
            end
            pause(0.1);
        end
    end
end





end

