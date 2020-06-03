function box_plot_bkh(y,x)
%
% box_plot_bkh(y,x) Plots vars per classes
%

u=unique(x);


for i=1:length(u)
    id1=find(x==u(i));
    x1=x(id1);
    y1=y(id1);
    
    plot(ones(length(x1),1)*u(i),y1,'d','Color',[0.35 0.35 0.35],'MarkerSize',12); hold on;
    plot(u(i),mean(y1),'.','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerSize',30); hold on;
    clear id1 x1 y1
end;

    xlim([min(x)-0.5 max(x)+0.5]);
    ylim([min(y)*0.75 max(y)*1.25]);

end

