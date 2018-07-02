function TaxClassymjjmk(datain)

%%%%%%%%%%%%%%%% HELP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function  plots the ymj versus jmk color of an asteroid and allows to classify it by visual inspection 
% Input: datain - NIR colors of the object to be classified
%        data [Optional] - DeMeo NIR colors
%    Format: a) YmJ YmJerr JmK JmKerr HmK HmKerr
% Output: YmJ vesru JmKs class with  borders for specific classes 
%Created by Marcel Popescu 19-07-2017, IAC
%------------------------------------------------------


% Prepare reference background: load the equivalen colors of 371 spectra

% open the colors for the 371 asteroids classified with the Bus-DeMeo algorithm 
fid = fopen('../Files/371SpectraDeMeoColor.csv','r');
temp = fgetl(fid);       % read line from fid
data = [];
while(~feof(fid))        % test for end of file
    line = fgetl(fid);   % read line from fid
    [~, ~, ~, ~, ~, ~, myccell] = regexp (line, ',');          % introduce in myccell the elements from line separated by ',' 
    data = [data; [str2num(myccell{3}),str2num(myccell{7})]];  % select the 3rd (YmJ) and 7th (JmK) element of myccell
end
fclose(fid);

figure(2)
% Plot the colors of the 371 spectra from DeMeo Taxonomy
plot(data(:,2),data(:,1),'*','Color',[0.77 0.77 0.77]);
% Plot the borderlines between classes
drawyjjkborders;
% Text to mark the specific regions
text(0.2,0.4,'S','FontSize',30,'FontName','Arial');
text(0.1,0.15,'B','FontSize',30,'FontName','Arial');
text(0.6,0.25,'C/X','FontSize',30,'FontName','Arial');
text(0.6,0.375,'D','FontSize',30,'FontName','Arial');
text(0.1,0.8,'V','FontSize',30,'FontName','Arial');
text(1,0.5,'A','FontSize',30,'FontName','Arial');
text(0.5,0.7,'O','FontSize',30,'FontName','Arial');
%  grid

% Plot the colors of the object with error bars
%% Which colors to play with from MOVIS
cx = 3; % JmK
cy = 1; % YmJ
hold on
% plot the data and errorbars for the elements having the errors between 0 and 10
if (datain(cx+1)>=0)&&(datain(cx+1)<=10)&&(datain(cy+1)>=0)&&(datain(cy+1)<=10)
    h = errorbar(datain(:,cx),datain(:,cy), datain(:,cx+1),datain(:,cy+1),'~>o'); set(h, 'Linewidth',2, 'Color','b');
    plot(datain(:,cx),datain(:,cy),'ob','Linewidth',5);
end
hold off;
% Make-up the plot
xlim([-0.2 1.2]); ylim([0 1]);
set(gca, 'xtick', [-0.2:0.4:1.2]);
set(gca, 'ytick', [0.1:0.2:0.9]);
set(gca,'FontSize',24,'FontName','Arial');
ylabel('Y-J','FontSize',24,'FontName','Arial')
xlabel('J-Ks','FontSize',24,'FontName','Arial')
