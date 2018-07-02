function drawyjjkborders()
%%%%%% HELP %%%%%%
% This function creates the border for taxonomic classification in Y-J vs J-Ks plot
% it plots over the corresponding plot

%(Y − J) = 0.412±0.046 · (J − K s) + 0.155±0.016 .
xalfa = [0.1:1e-3:0.8];
yalfa = 0.412.*xalfa +0.155;
yalfap = (0.412+0.046).*xalfa +(0.155+0.0166);
yalfan = (0.412-0.046).*xalfa +(0.155-0.0166);
hold on
plot(xalfa,yalfa,'-k','Linewidth',3);
%plot(xalfa,yalfap,'--k','Linewidth',4);
%plot(xalfa,yalfan,'--k','Linewidth',4);
hold off

xbeta = [-0.2:1e-3:0.8];
ybeta = 0.5*ones(size(xbeta));
hold on
plot(xbeta,ybeta,'-k','Linewidth',3);
hold off

ygama = [0.5:1e-3:0.87]; 
xgama = 0.3*ones(size(ygama));
hold on
plot(xgama,ygama,'-k','Linewidth',3);
hold off

xdelta = [0.4:1e-3:0.8];
ydelta = 0.32*ones(size(xdelta));
hold on
plot(xdelta,ydelta,'-k','Linewidth',3);
hold off


xepsilon = [0.2:1e-3:0.4];
yepsilon = 0.23*ones(size(xepsilon));
hold on
plot(xepsilon,yepsilon,'-k','Linewidth',3);
hold off

