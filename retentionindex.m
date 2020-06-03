function [RI] = retentionindex(RTs,alkmix_numberof_C_RTsec);
% Calculates Retention Index of GC-MS Peaks
% "[RI] = retentionindex(rt,alkmix)"
% "INPUTS:
% RTs = Retention time of Peaks (in seconds)
% alkmix_numberof_C_RTsec = 2-column matrix, 1st contain number of carbons present in the molecular of Alkane, 2nd column contains its Retention times (in seconds) 
% OUTPUT
% RI = Retention index of GC-MS peak
%
% bzo@life.ku.dk 


library.carbonatoms = alkmix_numberof_C_RTsec(:,1);
library.seconds = alkmix_numberof_C_RTsec(:,2);

for i=1:length(RTs)
    
    rt=RTs(i);
    
    if rt<=library.seconds(1,:)
        rt=library.seconds(1,:)+0.001;
    else
        rt=rt;
    end;


newseconds = [library.seconds;rt];
[Y,index] = sort(newseconds);
findTx = find(Y == rt);
Tn = Y(findTx-1);
y3=findTx+1;
if y3>length(Y)
    y3=length(Y);
end;
Tn1 = Y(y3);
n = library.carbonatoms(findTx-1);

if findTx>length(library.carbonatoms)
    findTx=length(library.carbonatoms);
end;
n1 = library.carbonatoms(findTx);
RI(i,1) = 100*(n + (n1-n)*((rt-Tn)/(Tn1 - Tn)));

clear rt newseconds Y index findTx Tn Tn1 n n1

end;

end

