function ReportTaxonomyMOVISCobj(maindesig)

%%%%%%%%%%%%%%%% HELP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function reports the taxonomic classification of an object included in MOVIS - C catalog
% Input: The object main designation as string
% Output:
% Created by Marcel Popescu 19-07-2017, IAC, popescu.marcel1983@gmail.com
%------------------------------------------------------

% Search for the data in MOVIS-C catalog
fid = fopen('../Files/MOVIS-CTax.csv','r');
temp = fgetl(fid);
while(~feof(fid))
    temp = fgetl(fid);
    idx = strfind(temp, ',')(1);
    if strcmp([maindesig,','], temp(1:idx))
        [data] = getmoviscdata(temp);
        break;
    end
end
fclose(fid);

% Issue an error if the designation was not found
if(~exist('data'))
    error('Designation not available in the catalog');
end

% Get probabilities for each class
[TaxClass,ClassOrd] = TaxClassifyProb(data.movisc);

myxlabels = '';
for i = 1:length(ClassOrd.prob)
    printf("%s : %.2f\n",ClassOrd.cls{i},ClassOrd.prob(i));
    myxlabels = [myxlabels,'|' ,sprintf("%s",ClassOrd.cls{i})];
end

figure(1)
stem(ClassOrd.prob)
set(gca,'FontSize',24,'FontName','Arial');
set(gca, 'xtick', [1:9]);
set(gca, 'xticklabel', myxlabels(2:end));
xlabel('Taxonomic Group','FontSize',24,'FontName','Arial');
ylabel('probability distance','FontSize',24,'FontName','Arial');
xlim([0,10])
TaxClassymjjmk(data.movisc);
