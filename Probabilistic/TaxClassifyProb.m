function [TaxClass,ClassOrd] = TaxClassifyProb(datain,data)
%%%%%%%%%%%%%%%% HELP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function  classifies an asteroid based on its NIR colors
% Input: datain - NIR colors of the object to be classified
%        data [Optional] - DeMeo NIR colors
%    Format: a) YmJ YmJerr JmK JmKerr HmK HmKerr
% Output: TaxClass: most probable class: TaxClass.cls (i.e. 'S'), and its probability TaxClass.prob (i.e. 0.88)
%         ClassOrd: the class and their probabilities
%Created by Marcel Popescu 01-07-2016, IAC
%Updated by Marcel Popescu 24-01-2017, AIRA
%------------------------------------------------------

if nargin<2
    % LOAD DeMeo NIR colors
    data = getDeMeoNIRColors('All');
    % Update the sigma of the DeMeo classes (if it is lower than a minimum value assigne the minimum sigmalimit)
    sigmalimit = 1e-2; % select a limiting threshold for Bus-DeMeo classes
    % compare the values from the standard deviation columns to sigmalimit, and replace the values smaller than sigmalimit to sigmalimit
    for i=2:2:size(data,2)
        idx = find(data(:,i)<sigmalimit);
        data(idx,i) = sigmalimit;
    end
end

%% Which colors to play with from MOVIS
cxm = 1; cym=3; czm=5;
%#YmJ YmJerr  JmK JmKerr HmK HmKerr
%#1   2       3   4      5   6

% Select the analogues columns from the TAX file
cxt = 1; cyt=9; czt=11;
%#YmJ YmJerr YmH YmHerr YmK YmKerr JmH JmHerr JmK JmKerr HmK HmKerr
%#1   2      3   4      5   6      7   8      9   10     11  12

nsigma = 1; 
% For each class defined in DeMeo taxonomy compute the distance in terms of Multiplying distribution in color space
for j = 1:size(data,1)
    dist(j) = 1;
    if(datain(cxm+1)>=0)&&(datain(cxm+1)<=10) % probability for YmJ
        dist(j) = dist(j)*distribprob(datain(cxm), datain(cxm+1),data(j,cxt),data(j,cxt+1)*nsigma);
    end
    if(datain(cym+1)>=0)&&(datain(cym+1)<=10) % probability for JmK
        dist(j) = dist(j)*distribprob(datain(cym), datain(cym+1),data(j,cyt),data(j,cyt+1)*nsigma);
    end
    if(datain(czm+1)>=0)&&(datain(czm+1)<=10) % probability for HmK
        dist(j) = dist(j)*distribprob(datain(czm), datain(czm+1),data(j,czt),data(j,czt+1)*nsigma);
    end        
end

% Define the groups
GroupAsoc = {'Ad','Bk', 'C','Cgx','D','Kl','S','Xt','V'};
% Assign the class indexes to each group - pay attention to match GroupAsoc with group
Group{1} = idxclassDeMeo({'A','Sa'});
Group{2} = idxclassDeMeo({'B'});
Group{3} = idxclassDeMeo({'C','Cb'});
Group{4} = idxclassDeMeo({'Cg','Cgh','Ch','Xc','Xe'});
Group{5} = idxclassDeMeo({'D'});
Group{6} = idxclassDeMeo({'K','L'});
Group{7} = idxclassDeMeo({'R','Q','S','Sq','Sv','Sr'});
Group{8} = idxclassDeMeo({'T','X','Xk'});
Group{9} = idxclassDeMeo({'O','V'});

%Compute the probability for each group
for i = 1:length(Group)
    p(i) = max(dist(Group{i}));
end
% Sort descending to find the best match
[p, groupidx] = sort(p,'descend'); 
Groupprobab = p/sum(p); %Normalize

% Report the best classification and the list ordered by the probability
TaxClass.cls =  GroupAsoc{groupidx(1)};
TaxClass.prob = Groupprobab(1);
ClassOrd.cls = GroupAsoc(groupidx);
ClassOrd.prob = Groupprobab;

