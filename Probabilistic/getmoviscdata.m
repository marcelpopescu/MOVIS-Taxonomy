function [data] = getmoviscdata(line)
%%%% HELP
% Get [Y-J, J-Ks, H-Ks,Y-J_err, J-Ks_err, H-Ks_err] vector from a MOVIS-C line:
% The movis-c line follows the header format
%#MainDesig,EquivDesig,Class,YmJ,YmJerr,YmJt_min,JmK,JmKerr,JmKt_min,HmK,HmKerr,HmKt_min,TaxClassKNN,KNNMCProb,TaxClassProb,ProbProb,TaxClassFin
% Input: line from the catalog (i.e. line = fgetl(fid));
% Output: [Y-J, J-Ks, H-Ks,Y-J_err, J-Ks_err, H-Ks_err]
% Created by Marcel Popescu as auxiliary function for processing MOVIS-C data
% xx - 07 - 2016
% Contact: popescu.marcel1983@gmail.com
%% ----------

% Replace the empty values with '99999' string
[~, ~, ~, ~, ~, ~, movisccell] = regexp (line, ','); % introduce in myccell the elements from line separated by ',' 
data.objdes = movisccell{2};
for i =1:length(movisccell)
    if length(movisccell{i}) == 0
        movisccell{i} = '99999';
    end
end

% Select the colors and their errors according to the format:
% [Y-J, J-Ks, H-Ks,Y-J_err, J-Ks_err, H-Ks_err]
idxoffset = 4; %first three columns are #MainDesig,EquivDesig,Class
idx = [[0:3:6]+idxoffset; [0:3:6]+idxoffset+1](:)';
data.movisc = [];
% concatenate data.movisc with the character from movisccell{idx(i)} transformed into numeric
for i=1:length(idx)
    data.movisc = [data.movisc,str2num(movisccell{idx(i)})];
end

