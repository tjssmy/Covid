clearvars; clearvars -GLOBAL; close all; plotbrowser('off'); %clc
set(0,'DefaultFigureWindowStyle','docked')

CTRL_SAVE_DATA = 0;
CTRL_SAVE_PLOT = 1;

sPgm = 'covid19';
fn_log = sprintf('%s.txt',sPgm);
fid_log = fopen(fn_log,'w');
% stdout = 1;
% fid_log = stdout;

sDataDate = sprintf('%s data',datestr(datetime('today')-1,'mmm dd'));

sLW = 'LineWidth';
sLS = 'LineStyle';
sC = 'Color';
sL = 'Location';
sV = 'Visible';
sM = 'Marker';
sMSz = 'MarkerSize'; % 10 % default 6
sMECol = 'MarkerEdgeColor'; % ,'b',...
sMFCol = 'MarkerFaceColor'; %,[0.5,0.5,0.5])
cBlu = [0 0.4470 0.7410];
cRed = [0.8500 0.3250 0.0980];
cYel = [0.9290 0.6940 0.1250];
cPur = [0.4940 0.1840 0.5560];
cLtBlu = [0.5 0.7 1]; % cBlu = [0 0.4470 0.7410];
cLtRed = [1 0.8 0.7]; % cRed = [0.8500 0.3250 0.0980];
cLtYel = [1 0.9 0.7]; % cYel = [0.9290 0.6940 0.1250];

nLW = 2;
nLW_O = 4;
nLW_C = 6; % Canada
nLW_dbl = 1;  % plots of growth per day (ie double per day)

R = {};

% start_date = datetime(Canada.start);  % used to ref all plots
oCanada = fn_create_region('Canada',37,'2020-01-27',nLW_C,'o-');


thresh_cases = 100;
thresh_cases_norm = 500/oCanada.population;
thresh_deaths = 10;
thresh_deaths_norm = 10/oCanada.population;
today_date = datetime('today');


data_gt_thresh = oCanada.cases > thresh_cases; % find date that Canada is at thresh (so its dates won't be shifted)
thresh_i = find(data_gt_thresh,1);
thresh_date_cases = oCanada.dates(thresh_i); 
oCanada.shift_cases = fn_get_shift('cases',thresh_date_cases,thresh_cases,oCanada); % find date shift so data is at threshold on thresh_date

data_gt_thresh = oCanada.cases/oCanada.population > thresh_cases_norm; % find date that Canada is at thresh (so its dates won't be shifted)
thresh_i = find(data_gt_thresh,1);
thresh_date_cases_norm = oCanada.dates(thresh_i); 
oCanada.shift_cases_norm = fn_get_shift('cases_norm',thresh_date_cases_norm,thresh_cases_norm,oCanada); % find date shift so data is at threshold on thresh_date

data_gt_thresh = oCanada.deaths > thresh_deaths; % find date that Canada is at thresh (so its dates won't be shifted)
thresh_i = find(data_gt_thresh,1);
thresh_date_deaths = oCanada.dates(thresh_i); 
oCanada.shift_deaths = fn_get_shift('deaths',thresh_date_deaths,thresh_deaths,oCanada); % find date shift so data is at threshold on thresh_date

data_gt_thresh = oCanada.deaths/oCanada.population > thresh_deaths_norm; % find date that Canada is at thresh (so its dates won't be shifted)
thresh_i = find(data_gt_thresh,1);
thresh_date_deaths_norm = oCanada.dates(thresh_i); 
oCanada.shift_deaths_norm = fn_get_shift('deaths_norm',thresh_date_deaths_norm,thresh_deaths_norm,oCanada); % find date shift so data is at threshold on thresh_date
fn_region_fprintf(fid_log,oCanada);
R{end+1} = oCanada;  % update shift parms before copy value to R{}


oItaly = fn_create_region('Italy',60,'2020-02-15',nLW,'o-');
oItaly.shift_cases = fn_get_shift('cases',thresh_date_cases,thresh_cases,oItaly);
oItaly.shift_cases_norm = fn_get_shift('cases_norm',thresh_date_cases_norm,thresh_cases_norm,oItaly);
oItaly.shift_deaths = fn_get_shift('deaths',thresh_date_deaths,thresh_deaths,oItaly);
oItaly.shift_deaths_norm = fn_get_shift('deaths_norm',thresh_date_deaths_norm,thresh_deaths_norm,oItaly);
fn_region_fprintf(fid_log,oItaly);
R{end+1} = oItaly;

oChina = fn_create_region('China',1400,'2020-01-17',nLW,'o-');
oChina.shift_cases = fn_get_shift('cases',thresh_date_cases,thresh_cases,oChina);
oChina.shift_cases_norm = fn_get_shift('cases_norm',thresh_date_cases_norm,thresh_cases_norm,oChina);
oChina.shift_deaths = fn_get_shift('deaths',thresh_date_deaths,thresh_deaths,oChina);
oChina.shift_deaths_norm = fn_get_shift('deaths_norm',thresh_date_deaths_norm,thresh_deaths_norm,oChina);
fn_region_fprintf(fid_log,oChina);
R{end+1} = oChina;

oUSA = fn_create_region('USA',328,'2020-01-22',nLW,'o-');
oUSA.shift_cases = fn_get_shift('cases',thresh_date_cases,thresh_cases,oUSA);
oUSA.shift_cases_norm = fn_get_shift('cases_norm',thresh_date_cases_norm,thresh_cases_norm,oUSA);
oUSA.shift_deaths = fn_get_shift('deaths',thresh_date_deaths,thresh_deaths,oUSA);
oUSA.shift_deaths_norm = fn_get_shift('deaths_norm',thresh_date_deaths_norm,thresh_deaths_norm,oUSA);
fn_region_fprintf(fid_log,oUSA);
R{end+1} = oUSA;

oSKorea = fn_create_region('SKorea',52,'2020-01-22',nLW,'o-');
oSKorea.shift_cases = fn_get_shift('cases',thresh_date_cases,thresh_cases,oSKorea);
oSKorea.shift_cases_norm = fn_get_shift('cases_norm',thresh_date_cases_norm,thresh_cases_norm,oSKorea);
oSKorea.shift_deaths = fn_get_shift('deaths',thresh_date_deaths,thresh_deaths,oSKorea);
oSKorea.shift_deaths_norm = fn_get_shift('deaths_norm',thresh_date_deaths_norm,thresh_deaths_norm,oSKorea);
fn_region_fprintf(fid_log,oSKorea);
R{end+1} = oSKorea;

oGermany = fn_create_region('Germany',83,'2020-02-24',nLW,'o-');
oGermany.shift_cases = fn_get_shift('cases',thresh_date_cases,thresh_cases,oGermany);
oGermany.shift_cases_norm = fn_get_shift('cases_norm',thresh_date_cases_norm,thresh_cases_norm,oGermany);
oGermany.shift_deaths = fn_get_shift('deaths',thresh_date_deaths,thresh_deaths,oGermany);
oGermany.shift_deaths_norm = fn_get_shift('deaths_norm',thresh_date_deaths_norm,thresh_deaths_norm,oGermany);
fn_region_fprintf(fid_log,oGermany);
R{end+1} = oGermany;

oDenmark = fn_create_region('Denmark',6,'2020-02-27',nLW,'*:');
oDenmark.shift_cases = fn_get_shift('cases',thresh_date_cases,thresh_cases,oDenmark);
oDenmark.shift_cases_norm = fn_get_shift('cases_norm',thresh_date_cases_norm,thresh_cases_norm,oDenmark);
oDenmark.shift_deaths = fn_get_shift('deaths',thresh_date_deaths,thresh_deaths,oDenmark);
oDenmark.shift_deaths_norm = fn_get_shift('deaths_norm',thresh_date_deaths_norm,thresh_deaths_norm,oDenmark);
fn_region_fprintf(fid_log,oDenmark);
R{end+1} = oDenmark;

oSpain = fn_create_region('Spain',47,'2020-01-31',nLW,'*:');
oSpain.shift_cases = fn_get_shift('cases',thresh_date_cases,thresh_cases,oSpain);
oSpain.shift_cases_norm = fn_get_shift('cases_norm',thresh_date_cases_norm,thresh_cases_norm,oSpain);
oSpain.shift_deaths = fn_get_shift('deaths',thresh_date_deaths,thresh_deaths,oSpain);
oSpain.shift_deaths_norm = fn_get_shift('deaths_norm',thresh_date_deaths_norm,thresh_deaths_norm,oSpain);
fn_region_fprintf(fid_log,oSpain);
R{end+1} = oSpain;

oOntario = fn_create_region('Ontario',14.3,'2020-03-01',nLW_O,'o-');
oOntario.shift_cases = fn_get_shift('cases',thresh_date_cases,thresh_cases,oOntario);
oOntario.shift_cases_norm = fn_get_shift('cases_norm',thresh_date_cases_norm,thresh_cases_norm,oOntario);
oOntario.shift_deaths = fn_get_shift('deaths',thresh_date_deaths,thresh_deaths,oOntario);
oOntario.shift_deaths_norm = fn_get_shift('deaths_norm',thresh_date_deaths_norm,thresh_deaths_norm,oOntario);
fn_region_fprintf(fid_log,oOntario);
R{end+1} = oOntario;

oQuebec = fn_create_region('Quebec',8.5,'2020-02-28',nLW_O,'o-');
oQuebec.shift_cases = fn_get_shift('cases',thresh_date_cases,thresh_cases,oQuebec);
oQuebec.shift_cases_norm = fn_get_shift('cases_norm',thresh_date_cases_norm,thresh_cases_norm,oQuebec);
oQuebec.shift_deaths = fn_get_shift('deaths',thresh_date_deaths,thresh_deaths,oQuebec);
oQuebec.shift_deaths_norm = fn_get_shift('deaths_norm',thresh_date_deaths_norm,thresh_deaths_norm,oQuebec);
fn_region_fprintf(fid_log,oQuebec);
R{end+1} = oQuebec;

oNewYork = fn_create_region('NewYork',20,'2020-03-01',nLW_O,'o-');
oNewYork.shift_cases = fn_get_shift('cases',thresh_date_cases,thresh_cases,oNewYork);
oNewYork.shift_cases_norm = fn_get_shift('cases_norm',thresh_date_cases_norm,thresh_cases_norm,oNewYork);
oNewYork.shift_deaths = fn_get_shift('deaths',thresh_date_deaths,thresh_deaths,oNewYork);
oNewYork.shift_deaths_norm = fn_get_shift('deaths_norm',thresh_date_deaths_norm,thresh_deaths_norm,oNewYork);
fn_region_fprintf(fid_log,oNewYork);
R{end+1} = oNewYork;

oOttawa = fn_create_region('Ottawa',0.9,'2020-03-11',nLW_O,'o-');
oOttawa.shift_cases = fn_get_shift('cases',thresh_date_cases,thresh_cases,oOttawa);
oOttawa.shift_cases_norm = fn_get_shift('cases_norm',thresh_date_cases_norm,thresh_cases_norm,oOttawa);
oOttawa.shift_deaths = fn_get_shift('deaths',thresh_date_deaths,thresh_deaths,oOttawa);
oOttawa.shift_deaths_norm = fn_get_shift('deaths_norm',thresh_date_deaths_norm,thresh_deaths_norm,oOttawa);
fn_region_fprintf(fid_log,oOttawa);
R{end+1} = oOttawa;

oBC = fn_create_region('BC',4.9,'2020-03-01',nLW_O,'o-');
oBC.shift_cases = fn_get_shift('cases',thresh_date_cases,thresh_cases,oBC);
oBC.shift_cases_norm = fn_get_shift('cases_norm',thresh_date_cases_norm,thresh_cases_norm,oBC);
oBC.shift_deaths = fn_get_shift('deaths',thresh_date_deaths,thresh_deaths,oBC);
oBC.shift_deaths_norm = fn_get_shift('deaths_norm',thresh_date_deaths_norm,thresh_deaths_norm,oBC);
fn_region_fprintf(fid_log,oBC);
R{end+1} = oBC;

oSweden = fn_create_region('Sweden',10.3,'2020-03-01',nLW,'*-');
oSweden.shift_cases = fn_get_shift('cases',thresh_date_cases,thresh_cases,oSweden);
oSweden.shift_cases_norm = fn_get_shift('cases_norm',thresh_date_cases_norm,thresh_cases_norm,oSweden);
oSweden.shift_deaths = fn_get_shift('deaths',thresh_date_deaths,thresh_deaths,oSweden);
oSweden.shift_deaths_norm = fn_get_shift('deaths_norm',thresh_date_deaths_norm,thresh_deaths_norm,oSweden);
fn_region_fprintf(fid_log,oSweden);
R{end+1} = oSweden;

oFrance = fn_create_region('France',67,'2020-02-25',nLW,'*--');
oFrance.shift_cases = fn_get_shift('cases',thresh_date_cases,thresh_cases,oFrance);
oFrance.shift_cases_norm = fn_get_shift('cases_norm',thresh_date_cases_norm,thresh_cases_norm,oFrance);
oFrance.shift_deaths = fn_get_shift('deaths',thresh_date_deaths,thresh_deaths,oFrance);
oFrance.shift_deaths_norm = fn_get_shift('deaths_norm',thresh_date_deaths_norm,thresh_deaths_norm,oFrance);
fn_region_fprintf(fid_log,oFrance);
R{end+1} = oFrance;

days = linspace(0,1e2);
y_dbl_day = 2.^days;
y_dbl_2_days = 2.^(days/2);
y_dbl_3_days = 2.^(days/3);
y_dbl_4_days = 2.^(days/4);

fig1 = figure(1);
if CTRL_SAVE_PLOT, fig1.WindowStyle = 'normal'; fig1.Position = [40 378 760 720]; end %default: [440 378 560 420] %'docked')
leg = {};
for i = 1:length(R)
    plot(R{i}.dates,R{i}.cases,R{i}.pt,sLW,R{i}.lw);leg{end+1}=sprintf('%s',R{i}.fn_no_ext); hold on
end
plot([datetime('2019-12-01'),today_date+30],[thresh_cases,thresh_cases],'k'); leg{end+1}=sprintf('thresh=%d',thresh_cases); hold on
hold off
ylabel('cases'); %xlabel('days')
title('COVID-19')
% title('FFT E(z)');
legend(leg,'Location','NorthWest','FontSize',12)
xlim([datetime('2020-01-21'), datetime('today')+1])
% ylim([0,10000])
ymax1 = fig1.Children(2).YLim(2);

fig10 = figure(10);
if CTRL_SAVE_PLOT, fig10.WindowStyle = 'normal'; fig10.Position = [140 378 760 720]; end %default: [440 378 560 420] %'docked')
leg = {};
for i = 1:length(R)
    plot(R{i}.dates-R{i}.shift_cases,R{i}.cases,R{i}.pt,sLW,R{i}.lw);leg{end+1}=sprintf('%s %d',R{i}.fn_no_ext,R{i}.shift_cases); hold on
end
plot([datetime('2019-12-01'),today_date+30],[thresh_cases,thresh_cases],'k'); leg{end+1}=sprintf('thresh=%.1f',thresh_cases); hold on
hold off
ylabel('cases'); %xlabel('days')
title('COVID-19 shifted to same cases at threshold');
legend(leg,'Location','NorthWest','FontSize',12)
xlim([datetime('2020-01-21'), datetime('today')+21])
ylim([0,ymax1]) %20000])

fig15 = figure(15);
if CTRL_SAVE_PLOT, fig15.WindowStyle = 'normal'; fig15.Position = [140 378 760 720]; end %default: [440 378 560 420] %'docked')
leg = {};
for i = 1:length(R)
    semilogy(R{i}.dates-R{i}.shift_cases,R{i}.cases,R{i}.pt,sLW,R{i}.lw);leg{end+1}=sprintf('%s %d',R{i}.fn_no_ext,R{i}.shift_cases); hold on
end
semilogy([datetime('2019-12-01'),today_date+30],[thresh_cases,thresh_cases],'k'); leg{end+1}=sprintf('thresh=%.1f',thresh_cases); hold on
semilogy(datetime('2020-03-03')+days+0.5,y_dbl_day,'k:',sLW,nLW_dbl);leg{end+1}='double every day'; hold on
semilogy(datetime('2020-02-25')+days+0.85,y_dbl_2_days,'k--',sLW,nLW_dbl);leg{end+1}='double every 2 days'; hold on
semilogy(datetime('2020-02-19')+days+0.24,y_dbl_3_days,'k-.',sLW,nLW_dbl);leg{end+1}='double every 3 days'; hold on
semilogy(datetime('2020-02-12')+days+0.6,y_dbl_4_days,'k-',sLW,nLW_dbl);leg{end+1}='double every 4 days'; hold on
hold off
ylabel('cases'); %xlabel('days')
title(sprintf('COVID-19 shifted to same cases at threshold (%s)',sDataDate));
legend(leg,'Location','NorthWest','FontSize',12)
xlim([datetime('2020-03-09'), datetime('today')+21]) % [datetime('2020-03-15'),datetime('2020-03-18')])
ylim([50,6e5])
% figure(15)

fig11 = figure(11);
if CTRL_SAVE_PLOT, fig11.WindowStyle = 'normal'; fig11.Position = [40 378 760 720]; end %default: [440 378 560 420] %'docked')
leg = {};
for i = 1:length(R)
    plot(R{i}.dates,R{i}.cases/R{i}.population,R{i}.pt,sLW,R{i}.lw);leg{end+1}=m_description(R{i}); hold on
end
plot([datetime('2019-12-01'),today_date+30],[thresh_cases_norm,thresh_cases_norm],'k'); leg{end+1}=sprintf('thresh=%.1f',thresh_cases_norm); hold on
hold off
ylabel('cases/million'); %xlabel('days')
title('COVID-19')
% title('FFT E(z)');
legend(leg,'Location','NorthWest','FontSize',12)
xlim([datetime('2020-01-21'), datetime('today')+1])
ylim([0,300])

% figure(10)

fig12 = figure(12);
if CTRL_SAVE_PLOT, fig12.WindowStyle = 'normal'; fig12.Position = [140 378 760 720]; end %default: [440 378 560 420] %'docked')
leg = {};
for i = 1:length(R)
    plot(R{i}.dates-R{i}.shift_cases_norm,R{i}.cases/R{i}.population,R{i}.pt,sLW,R{i}.lw);leg{end+1}=sprintf('%s %d',R{i}.fn_no_ext,R{i}.shift_cases_norm); hold on
end
plot([datetime('2019-12-01'),today_date+30],[thresh_cases_norm,thresh_cases_norm],'k'); leg{end+1}=sprintf('thresh=%.1f',thresh_cases_norm); hold on
hold off
ylabel('cases/million'); %xlabel('days')
title('COVID-19 shifted to same cases at threshold');
legend(leg,'Location','NorthWest','FontSize',12)
xlim([datetime('2020-03-10'), datetime('today')+21])
ylim([0,1000]) %300])

fig16 = figure(16);
if CTRL_SAVE_PLOT, fig16.WindowStyle = 'normal'; fig16.Position = [140 378 760 720]; end %default: [440 378 560 420] %'docked')
leg = {};
for i = 1:length(R)
    semilogy(R{i}.dates-R{i}.shift_cases_norm,R{i}.cases/R{i}.population,R{i}.pt,sLW,R{i}.lw);leg{end+1}=sprintf('%s %d',R{i}.fn_no_ext,R{i}.shift_cases_norm); hold on
end
semilogy([datetime('2019-12-01'),today_date+30],[thresh_cases_norm,thresh_cases_norm],'k'); leg{end+1}=sprintf('thresh=%.1f',thresh_cases_norm); hold on
semilogy(datetime('2020-03-12')+days+0.65,y_dbl_day,'k:',sLW,nLW_dbl);leg{end+1}='double every day'; hold on
semilogy(datetime('2020-03-08')+days+0.9,y_dbl_2_days,'k--',sLW,nLW_dbl);leg{end+1}='double every 2 days'; hold on
semilogy(datetime('2020-03-05')+days+0.13,y_dbl_3_days,'k-.',sLW,nLW_dbl);leg{end+1}='double every 3 days'; hold on
semilogy(datetime('2020-03-01')+days+0.38,y_dbl_4_days,'k-',sLW,nLW_dbl);leg{end+1}='double every 4 days'; hold on
hold off
ylabel('cases/million'); %xlabel('days')
title('COVID-19 shifted to same cases at threshold');
legend(leg,'Location','NorthWest','FontSize',12)
xlim([datetime('2020-03-13'), datetime('today')+21]) %[datetime('2020-03-15'),datetime('2020-03-18')]
ylim([1e1,1e4]) %300])

fig13 = figure(13);
if CTRL_SAVE_PLOT, fig13.WindowStyle = 'normal'; fig13.Position = [140 378 760 720]; end %default: [440 378 560 420] %'docked')
leg = {};
for i = 1:length(R)
    plot(R{i}.dates(2:end)-R{i}.shift_cases,diff(R{i}.cases),R{i}.pt,sLW,R{i}.lw);leg{end+1}=sprintf('%s %d',R{i}.fn_no_ext,R{i}.shift_cases); hold on
end
% plot([datetime('2019-12-01'),today_date+30],[thresh_cases_norm,thresh_cases_norm],'k'); leg{end+1}=sprintf('thresh=%.1f',thresh_cases_norm); hold on
hold off
ylabel('cases/day'); %xlabel('days')
title(sprintf('COVID-19 shifted to same cases at threshold (%s)',sDataDate));
legend(leg,'Location','NorthWest','FontSize',12)
xlim([datetime('2020-03-14'), datetime('today')+21])
ylim([0,15000])

fig14 = figure(14);
if CTRL_SAVE_PLOT, fig14.WindowStyle = 'normal'; fig14.Position = [140 378 760 720]; end %default: [440 378 560 420] %'docked')
leg = {};
for i = 1:length(R)
    plot(R{i}.dates(2:end)-R{i}.shift_cases,diff(R{i}.cases)/R{i}.population,R{i}.pt,sLW,R{i}.lw);leg{end+1}=sprintf('%s %d',R{i}.fn_no_ext,R{i}.shift_cases); hold on
end
% plot([datetime('2019-12-01'),today_date+30],[thresh_cases,thresh_cases],'k'); leg{end+1}=sprintf('thresh=%d',thresh_cases); hold on
hold off
ylabel('cases/million/day'); %xlabel('days')
title('COVID-19 shifted to same cases at threshold');
legend(leg,'Location','NorthWest','FontSize',12)
xlim([datetime('2020-03-14'), datetime('today')+21])
ylim([0,550])

fig2 = figure(2);
if CTRL_SAVE_PLOT, fig2.WindowStyle = 'normal'; fig2.Position = [240 378 760 720]; end %default: [440 378 560 420] %'docked')
leg = {};
for i = 1:length(R)
    plot(R{i}.dates,R{i}.deaths,R{i}.pt,sLW,R{i}.lw);leg{end+1}=sprintf('%s',R{i}.fn_no_ext); hold on
end
plot([datetime('2019-12-01'),today_date+30],[thresh_deaths,thresh_deaths],'k'); leg{end+1}=sprintf('thresh=%d',thresh_deaths); hold on
hold off
ylabel('deaths'); %xlabel('days')
title('COVID-19')
% title('FFT E(z)');
legend(leg,'Location','NorthWest','FontSize',12)
xlim([datetime('2020-02-21'), datetime('today')])
ylim([0,7000])

fig20 = figure(20);
if CTRL_SAVE_PLOT, fig20.WindowStyle = 'normal'; fig20.Position = [340 378 760 720]; end %default: [440 378 560 420] %'docked')
leg = {};
for i = 1:length(R)
    plot(R{i}.dates-R{i}.shift_deaths,R{i}.deaths,R{i}.pt,sLW,R{i}.lw);leg{end+1}=sprintf('%s %d',R{i}.fn_no_ext,R{i}.shift_deaths); hold on
end
plot([datetime('2019-12-01'),today_date+30],[thresh_deaths,thresh_deaths],'k'); leg{end+1}=sprintf('thresh=%d',thresh_deaths); hold on
hold off
ylabel('deaths'); %xlabel('days')
title('COVID-19 shifted to same cases at threshold');
legend(leg,'Location','NorthWest','FontSize',12)
xlim([datetime('2020-03-14'), datetime('today')+7])
ylim([0,200])

fig21 = figure(21);
if CTRL_SAVE_PLOT, fig21.WindowStyle = 'normal'; fig21.Position = [440 378 760 720]; end %default: [440 378 560 420] %'docked')
leg = {};
for i = 1:length(R)
    plot(R{i}.dates,R{i}.deaths/R{i}.population,R{i}.pt,sLW,R{i}.lw);leg{end+1}=sprintf('%s',R{i}.fn_no_ext); hold on
end
plot([datetime('2019-12-01'),today_date+30],[thresh_deaths_norm,thresh_deaths_norm],'k'); leg{end+1}=sprintf('thresh=%.1f',thresh_deaths_norm); hold on
hold off
ylabel('deaths/million'); %xlabel('days')
title('COVID-19 Normalized for population')
% title('FFT E(z)');
legend(leg,'Location','NorthWest','FontSize',12)
xlim([datetime('2020-02-01'), datetime('today')])
ymax21 = 2e2;
ylim([0,ymax21]) % Italy: 120])

fig22 = figure(22);
if CTRL_SAVE_PLOT, fig22.WindowStyle = 'normal'; fig22.Position = [540 378 760 720]; end %default: [440 378 560 420] %'docked')
leg = {};
for i = 1:length(R)
    plot(R{i}.dates-R{i}.shift_deaths_norm,R{i}.deaths/R{i}.population,R{i}.pt,sLW,R{i}.lw);leg{end+1}=sprintf('%s %d',R{i}.fn_no_ext,R{i}.shift_deaths_norm); hold on
end
plot([datetime('2019-12-01'),today_date+30],[thresh_deaths_norm,thresh_deaths_norm],'k'); leg{end+1}=sprintf('thresh=%.1f',thresh_deaths_norm); hold on
hold off
ylabel('deaths/million'); %xlabel('days')
title('COVID-19 Normalized by population, shifted to same deaths at threshold');
legend(leg,'Location','NorthWest','FontSize',12)
xlim([datetime('2020-03-17'), datetime('today')+28])
ylim([0,ymax21])

fig25 = figure(25);
if CTRL_SAVE_PLOT, fig25.WindowStyle = 'normal'; fig25.Position = [540 378 760 720]; end %default: [440 378 560 420] %'docked')
leg = {};
for i = 1:length(R)
    semilogy(R{i}.dates-R{i}.shift_deaths_norm,R{i}.deaths/R{i}.population,R{i}.pt,sLW,R{i}.lw);leg{end+1}=sprintf('%s %d',R{i}.fn_no_ext,R{i}.shift_deaths_norm); hold on
end
semilogy([datetime('2019-12-01'),today_date+30],[thresh_deaths_norm,thresh_deaths_norm],'k'); leg{end+1}=sprintf('thresh=%.1f',thresh_deaths_norm); hold on
scal = 100;
semilogy(datetime('2020-03-13')+days+0.61,y_dbl_day/scal,'k:',sLW,nLW_dbl);leg{end+1}='double every day'; hold on
semilogy(datetime('2020-03-08')+days+0.85,y_dbl_2_days/scal,'k--',sLW,nLW_dbl);leg{end+1}='double every 2 days'; hold on
semilogy(datetime('2020-03-04')+days+0.1,y_dbl_3_days/scal,'k-.',sLW,nLW_dbl);leg{end+1}='double every 3 days'; hold on
semilogy(datetime('2020-02-28')+days+0.35,y_dbl_4_days/scal,'k-',sLW,nLW_dbl);leg{end+1}='double every 4 days'; hold on
hold off
ylabel('deaths/million'); %xlabel('days')
title(sprintf('COVID-19 Normalized by population, shifted to same deaths at threshold (%s)',sDataDate));
legend(leg,'Location','NorthWest','FontSize',12)
xlim([datetime('2020-03-17'), datetime('today')+28]) % [datetime('2020-03-17'),datetime('2020-03-20')])
ylim([2e-1,6e2])

% figure(25)

fig23 = figure(23);
if CTRL_SAVE_PLOT, fig23.WindowStyle = 'normal'; fig23.Position = [140 378 760 720]; end %default: [440 378 560 420] %'docked')
leg = {};
for i = 1:length(R)
    plot(R{i}.dates(2:end)-R{i}.shift_deaths,diff(R{i}.deaths),R{i}.pt,sLW,R{i}.lw);leg{end+1}=sprintf('%s %d',R{i}.fn_no_ext,R{i}.shift_deaths); hold on
end
% plot([datetime('2019-12-01'),today_date+30],[thresh_deaths_norm,thresh_deaths_norm],'k'); leg{end+1}=sprintf('thresh=%.1f',thresh_deaths_norm); hold on
hold off
ylabel('deaths/day'); %xlabel('days')
title('COVID-19 shifted to same deaths at threshold');
legend(leg,'Location','NorthWest','FontSize',12)
xlim([datetime('2020-03-14'), datetime('today')+14])
ylim([0,100])

% figure(23)

fig24 = figure(24);
if CTRL_SAVE_PLOT, fig24.WindowStyle = 'normal'; fig24.Position = [540 378 760 720]; end %default: [440 378 560 420] %'docked')
leg = {};
for i = 1:length(R)
    plot(R{i}.dates(2:end)-R{i}.shift_deaths_norm,diff(R{i}.deaths/R{i}.population),R{i}.pt,sLW,R{i}.lw);leg{end+1}=sprintf('%s %d',R{i}.fn_no_ext,R{i}.shift_deaths_norm); hold on
end
% plot([datetime('2019-12-01'),today_date+30],[thresh_deaths_norm,thresh_deaths_norm],'k'); leg{end+1}=sprintf('thresh=%.1f',thresh_deaths_norm); hold on
hold off
ylabel('deaths/million/day'); %xlabel('days')
title('COVID-19 Normalized by population, shifted to same deaths at threshold');
legend(leg,'Location','NorthWest','FontSize',12)
fig24_xaxis_days = 21;
xlim([datetime('2020-03-16'), datetime('today')+fig24_xaxis_days])
ylim([0,10])

% i = 15;  % select Region
% diff_data = diff(R{i}.deaths)/R{i}.population;
% dates_T = R{i}.dates(2:end).';

fig26 = figure(26);
if CTRL_SAVE_PLOT, fig26.WindowStyle = 'normal'; fig26.Position = [540 378 760 720]; end %default: [440 378 560 420] %'docked')
leg = {};
for i = 1:length(R)
    semilogy(R{i}.dates(2:end)-R{i}.shift_deaths_norm,diff(R{i}.deaths/R{i}.population),R{i}.pt,sLW,R{i}.lw);leg{end+1}=sprintf('%s %d',R{i}.fn_no_ext,R{i}.shift_deaths_norm); hold on
end
% semilogy(R{i}.dates(2:end)-R{i}.shift_deaths_norm,diff_data,R{i}.pt,sLW,R{i}.lw);leg{end+1}=sprintf('%s %d',R{i}.fn_no_ext,R{i}.shift_deaths_norm); hold on
scal = 30;
semilogy(datetime('2020-03-16')+days,y_dbl_day/scal,'k:',sLW,nLW_dbl);leg{end+1}='double every day'; hold on
semilogy(datetime('2020-03-16')+days,y_dbl_2_days/scal,'k--',sLW,nLW_dbl);leg{end+1}='double every 2 days'; hold on
semilogy(datetime('2020-03-16')+days,y_dbl_3_days/scal,'k-.',sLW,nLW_dbl);leg{end+1}='double every 3 days'; hold on
semilogy(datetime('2020-03-16')+days,y_dbl_4_days/scal,'k-',sLW,nLW_dbl);leg{end+1}='double every 4 days'; hold on
hold off
ylabel('deaths/million/day'); %xlabel('days')
title(sprintf('COVID-19 Normalized by population, shifted to same deaths at threshold (%s)',sDataDate));
legend(leg,'Location','NorthWest','FontSize',12)
xlim([datetime('2020-03-16'), datetime('today')+fig24_xaxis_days])
ylim([1e-2,5e1])

figure(26)

if CTRL_SAVE_PLOT
    out_folder = 'plot';
    [status, msg, msgID] = mkdir(out_folder);
    fprintf('out_folder "%s" created. %s\n',out_folder, msg);

    if exist('fig1','var'), saveas(fig1,sprintf('%s/covid19-1a-cases.jpg',out_folder)); end  
    if exist('fig10','var'), saveas(fig10,sprintf('%s/covid19-1b-cases-shift.jpg',out_folder)); end  
    if exist('fig15','var'), saveas(fig15,sprintf('%s/covid19-1b2-cases-shift-log.jpg',out_folder)); end  
    if exist('fig11','var'), saveas(fig11,sprintf('%s/covid19-1c-cases-norm.jpg',out_folder)); end  
    if exist('fig12','var'), saveas(fig12,sprintf('%s/covid19-1d-cases-norm-shift.jpg',out_folder)); end  
    if exist('fig16','var'), saveas(fig16,sprintf('%s/covid19-1d2-cases-norm-shift-log.jpg',out_folder)); end  
    if exist('fig13','var'), saveas(fig13,sprintf('%s/covid19-1e-cases-day-shift.jpg',out_folder)); end  
    if exist('fig14','var'), saveas(fig14,sprintf('%s/covid19-1f-cases-day-norm-shift.jpg',out_folder)); end  
    if exist('fig2','var'), saveas(fig2,sprintf('%s/covid19-2a-deaths.jpg',out_folder)); end  
    if exist('fig20','var'), saveas(fig20,sprintf('%s/covid19-2b-deaths-shift.jpg',out_folder)); end  
    if exist('fig21','var'), saveas(fig21,sprintf('%s/covid19-2c-deaths-norm.jpg',out_folder)); end  
    if exist('fig22','var'), saveas(fig22,sprintf('%s/covid19-2d-deaths-norm-shift.jpg',out_folder)); end  
    if exist('fig25','var'), saveas(fig25,sprintf('%s/covid19-2d2-deaths-norm-shift-log.jpg',out_folder)); end  
    if exist('fig23','var'), saveas(fig23,sprintf('%s/covid19-2e-deaths-day-shift.jpg',out_folder)); end  
    if exist('fig24','var'), saveas(fig24,sprintf('%s/covid19-2f-deaths-day-norm-shift.jpg',out_folder)); end  
    if exist('fig26','var'), saveas(fig26,sprintf('%s/covid19-2f2-deaths-day-norm-shift-log.jpg',out_folder)); end  
end

if CTRL_SAVE_DATA
    fn_save_country_data(oCanada);
    fn_save_country_data(oOntario);
    fn_save_country_data(oQuebec);
    fn_save_country_data(oBC);
    fn_save_country_data(oOttawa);
    fn_save_country_data(oItaly);
    fn_save_country_data(oChina);
    fn_save_country_data(oUSA);
    fn_save_country_data(oSKorea);
    fn_save_country_data(oGermany);
    fn_save_country_data(oDenmark);
    fn_save_country_data(oSpain);
    fn_save_country_data(oNewYork);
    fn_save_country_data(oSweden);
    fn_save_country_data(oFrance);
end

fclose(fid_log);

