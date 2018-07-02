function [out] = getDeMeoNIRColors(demandclass, fname)
%%%%%% HELP %%%%%%
% This function loads the DeMeoNIRColors for a specific  taxonomic type, or for all types (as a matrix)
% The format of the file is assumed to be:
%  #TaxClass,Nobj,YmJ,YmJstd,YmH,YmHstd,YmK,YmKstd,JmH,JmHstd,JmK,JmKstd,HmK,HmKstd
%  A,6,0.4842,0.0418,1.2490,0.1595,1.3817,0.1767,0.7648,0.1389,0.8975,0.1660,0.1337,0.0562
%  ......
% Inputs: - demandclass - the class for which the data will be loaded, 'All' - to load the entire table
%         - fname [optional] - path to the csv file containing the table
% Outputs: DeMeo NIR colors in the following format:
%           YmJ,YmJstd,YmH,YmHstd,YmK,YmKstd,JmH,JmHstd,JmK,JmKstd,HmK,HmKstd
% Created by Marcel Popescu 24 - 01 - 2017, AIRA
% Updated by Marcel Popescu 29 - 06 - 2018, IAC
% Contact: popescu.marcel1983@gmail.com
%-----------------------------------------------
% if the reference file is not provided, assume the file attached to this package
if nargin<2
    fname = '../Files/DeMeoMeanColors.csv';
end

fid = fopen(fname,'r');          % Open the file identifier
fgetl(fid);                      % read the  header line
idx = 1;
while (~feof(fid)) && (idx<25)   % Assuming 24 classes
    temp = strtrim(fgetl(fid));  % read line from fid, remove whitespaces at the beginning and at the ending
    cstr = strsplit(strtrim(temp), ',');    % split temp in multiple strings separated by ','
    for i=3:length(cstr)
        out(idx,i-2) = str2num(cstr{i});    % convert the values from character to numeric
    end
    % if the taxonomic class corresponding to current line
    % is identical with the class we wanted to be loaded, save a flag
    theclass(idx) = strcmp(cstr{1},demandclass);  
    idx = idx+1;
end
fclose(fid);

% if a particular class was requested
if(sum(theclass))
    out = out(find(theclass),:);
end
% if not the option 'all' and no particular class was requested
if(~sum(theclass) && ~strcmp('All',demandclass))
    error('The input of getDeMeoNIRColors is not valid!');
end
