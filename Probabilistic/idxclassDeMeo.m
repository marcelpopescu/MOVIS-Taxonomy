function [idx] = idxclassDeMeo(myclass)
%%%%%% HELP %%%%%%%%%
% This function returns the idex of a BusDeMeo class by considering them in an alfabetical order
% Ussage:[idx] = idxclassDeMeo('Xn')
% Created by Marcel Popescu 26-01-2017
%--------------------------------------
    % if the input is not a cell, transform it into a cell
if ~iscell(myclass)
    myclass = {myclass};
end

ListClass = {'A','B','C','Cb','Cg','Cgh','Ch','D','K','L','O','Q','R','S','Sa','Sq','Sr','Sv','T','V','X','Xc','Xe','Xk','Xn'};

for j = 1:length(myclass)
    theclass = zeros(size(ListClass));  % initialize theclass: an array with one line and size(ListClass) columns
    % compare ListClass{i} with myclass{j}; theclass(i) is 1 if i is the index of myclass and 0 otherwise
    for i = 1:length(ListClass)
          theclass(i) = strcmp(ListClass{i},myclass{j});  
    end
    % idx is the index of the position of the nonzero element of theclass (the index of myclass in ListClass)
    idx(j) = find(theclass); 
end
