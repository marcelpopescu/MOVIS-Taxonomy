% This script runs the probabilistic classification for the entire MOVIS-C catalog
% For the total number of ~18 000 entries it is expected to run ~6hrs

%% Prepare the reference colors
% LOAD DeMeo NIR colors
data = getDeMeoNIRColors('All');
% Update the sigma of the DeMeo classes (if it is lower than a minimum value assigne the minimum sigmalimit)
sigmalimit = 1e-2; % select a limiting threshold for Bus-DeMeo classes
for i=2:2:size(data,2)
    idx = find(data(:,i)<sigmalimit);
    data(idx,i) = sigmalimit;
end
%%

% ----------------------------------------------------

% Run the probabilistic approach for each line
% Search for the data in MOVIS-C catalog
fid = fopen('../Files/MOVIS-CTax.csv','r');
fidw = fopen('../Files/MovisProbCheck.csv','w');
fwrite(fidw,'#MainDesig,ProbClass,ProbProb');
temp = fgetl(fid);
% Uncomment these lines if you want to re-run the whole sample again
%  while(~feof(fid))
%      temp = fgetl(fid);
%      idx = strfind(temp, ',')(1);
%      desig = temp(1:idx-1);
%      [datain] = getmoviscdata(temp);
%      [TaxClass,ClassOrd] = TaxClassifyProb(datain.movisc,data);
%      fwrite(fidw,["\n",desig,',',TaxClass.cls,sprintf(",%.2f",TaxClass.prob)]);
%  end
fclose(fid);
fclose(fidw);
