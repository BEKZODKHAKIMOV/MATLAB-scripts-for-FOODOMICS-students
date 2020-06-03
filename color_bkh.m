function [ color1] = color_bkh
% Generates 110 Matlab Color Codes
% BKH
%



% Black to Blue
cm=[0 0 0];
cm1=[];
for i=1:10;
    t=0.1;
    cm=[cm(1,1:2) cm(1,3)+t];
    cm1=[cm1; cm]; 
end;

% Blue to Cyan
cm=[0 0 1];
cm2=[];
for i=1:10;
    t=0.1;
    cm=[cm(1,1) cm(1,2)+t cm(1,3)];
    cm2=[cm2; cm]; 
end;

% Cyan to Green
cm=[0 1 1];
cm3=[];
for i=1:10;
    t=0.1;
    cm=[cm(1,1) cm(1,2) round(cm(1,3)-t,2)];
    cm3=[cm3; cm]; 
end;

%  Green to Yellow
cm=[0 1 0];
cm4=[];
for i=1:10;
    t=0.1;
    cm=[cm(1,1)+t cm(1,2) cm(1,3)];
    cm4=[cm4; cm]; 
end;

%  Yellow to Red
cm=[1 1 0];
cm5=[];
for i=1:10;
    t=0.1;
    cm=[cm(1,1) cm(1,2)-t cm(1,3)];
    cm5=[cm5; cm]; 
end;

%  Red to Magenda
cm=[1 0 0];
cm6=[];
for i=1:10;
    t=0.1;
    cm=[cm(1,1) cm(1,2) cm(1,3)+t];
    cm6=[cm6; cm]; 
end;

%  Yellow to Magenda
cm=[1 1 0];
cm7=[];
for i=1:20;
    t=0.05;
    cm=[cm(1,1) cm(1,2)-t cm(1,3)+t];
    cm7=[cm7; cm]; 
end;

%  Blue to Red
cm=[0 0 1];
cm8=[];
for i=1:20;
    t=0.05;
    cm=[cm(1,1)+t cm(1,2) cm(1,3)-t];
    cm8=[cm8; cm]; 
end;

%  Blue to Green
cm=[0 0 1];
cm9=[];
for i=1:20;
    t=0.05;
    cm=[cm(1,1) cm(1,2)+t cm(1,3)-t];
    cm9=[cm9; cm]; 
end;

%  Blue to Magenda
cm=[0 0 1];
cm10=[];
for i=1:20;
    t=0.05;
    cm=[cm(1,1)+t cm(1,2) cm(1,3)];
    cm10=[cm10; cm]; 
end;

%  White to Black
cm=[1 1 1];
cm11=[];
for i=1:20;
    t=0.05;
    cm=[cm(1,1)-t cm(1,2)-t cm(1,3)-t];
    cm11=[cm11; cm]; 
end;

% Concatinate all above colors
cm=cat(1,cm1,cm2,cm3,cm4,cm5,cm6,cm7(6:end-5,:),cm8(6:end-5,:),cm9(6:end-5,:),cm10(6:end-5,:),cm11(6:end-5,:));

% Shufle in Blocks of 10 
col1=[];
for i=1:8;
    col2=cm(i:8:end,:);
    col1=cat(1,col1,flip(col2));
end;

color1=col1;

end

