function [ output_file ] = matlab2nist_bkh(varargin)
%
%  [ output_file ] = matlab2nist(MS, FileName, RIs, Occurance, PeakNames)
% INPUTS:
% MS= MassSpectra (double), e.g., MS(700,12), where rows (700) are 1-to-700 m/z ion, columns are Peaks
% 
% OPTIONAL INPUTS:
% FileName = Character Aray of the FileName with .txt extension.,e.g.'COMDAS-Bileacids-GC-SingleQuadrupole-MS8.txt'
% RIs=Retention Indeces of Peaks (double), e.g., RIs= Vec(1,12)
% Occurence = How Many time Peak Occures in the datasets (%) e.g., Occ = Vec(1,12)
% PeakNames = cell array of Peak names, e.g, PeaksNames=X{1,12}
%
% OUTPUT
% FileName.txt file which could be read by NIST MSearch
%
% Bekzod Khakimov, bzo@food.ku.dk
% (17 feb 2017)

% Get Inout;
if isempty(varargin{1}); error('No Data');
else
    MS=varargin{1};
end;

if nargin<2 | isempty(varargin{2}) ; 
    FileName='EIMS.txt';
else
    FileName=varargin{2};
end;

if nargin<3 | isempty(varargin{3}); 
    RIs=zeros(1,size(MS,2));
else
    RIs=varargin{3};
end;

if nargin<4 | isempty(varargin{4}); 
    Occurance=zeros(1,size(MS,2));
else
    Occurance=varargin{4};
end;

if nargin<5 | isempty(varargin{5}); 
    a1=['PeakX'];
    PeakNames=str2cell(repmat(a1,size(MS,2),1))';
else
    PeakNames=varargin{5};
end;




output_file = FileName;

if exist(output_file,'file')
    error(['ERROR: file ' output_file ' already exists in this directory']);
else
    fid = fopen(output_file,'w');
end

N = size(MS);
for a=1:N(2)
    s = ['Name: ' 'Peak#' num2str(a) '_' PeakNames{a} '_' 'RI(' num2str(RIs(a)) ')_Occ(' num2str(Occurance(a)) ')' ];
    fprintf(fid,'%s\n',s);
    s = ['DB#: 1'];
    fprintf(fid,'%s\n',s);
    s = ['Num of Peaks: ' num2str(N(1))];
    fprintf(fid,'%s\n',s);
    for b=1:N(1)
        s = [num2str(b) ' ' num2str(MS(b,a))];
        fprintf(fid,'%s\n',s);
    end
    fprintf(fid,'\n');
end
fclose(fid);
clear fid;
end

