clearvars; clearvars -GLOBAL; close all; plotbrowser('off'); %clc
set(0,'DefaultFigureWindowStyle','docked')

CTRL_SAVE_DATA = 0;
CTRL_SAVE_PLOT = 1;

sPgm = 'covid19_ont_sweden';
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
cOrgRed = [0.8500 0.3250 0.0980];
cDarkRed = [0.6350 0.0780 0.184];
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

thresh_deaths = 10;
thresh_deaths_norm = thresh_deaths/oCanada.population;
today_date = datetime('today');

oOntario = fn_create_region('Ontario',14.3,'2020-03-01',nLW_O,'o-');
oOntario.col = cOrgRed;

data_gt_thresh = oOntario.deaths/oOntario.population > thresh_deaths_norm; % find date that Ontario is at thresh (so its dates won't be shifted)
thresh_i = find(data_gt_thresh,1);
thresh_date_deaths_norm = oOntario.dates(thresh_i); 
thresh_date_deaths_norm_reg_region = oOntario;

oOntario.shift_deaths_norm = fn_get_shift('deaths_norm',thresh_date_deaths_norm,thresh_deaths_norm,oOntario); % find date shift so data is at threshold on thresh_date
fn_region_fprintf(fid_log,oOntario);
R{end+1} = oOntario;

oSweden = fn_create_region('Sweden',10.3,'2020-03-01',nLW,'*-');
oSweden.col = cDarkRed;
oSweden.shift_deaths_norm = fn_get_shift('deaths_norm',thresh_date_deaths_norm,thresh_deaths_norm,oSweden);
fn_region_fprintf(fid_log,oSweden);
R{end+1} = oSweden;

days = linspace(0,1e2);
y_dbl_day = 2.^days;
y_dbl_2_days = 2.^(days/2);
y_dbl_3_days = 2.^(days/3);
y_dbl_4_days = 2.^(days/4);

scal = 10;
thresh_exact = thresh_date_deaths_norm-0.28;
b1 = (log(thresh_deaths_norm)+log(scal))/log(2);
b2 = 2*(log(thresh_deaths_norm)+log(scal))/log(2);
b3 = 3*(log(thresh_deaths_norm)+log(scal))/log(2);
b4 = 4*(log(thresh_deaths_norm)+log(scal))/log(2);

fig25 = figure(25);
if CTRL_SAVE_PLOT, fig25.WindowStyle = 'normal'; fig25.Position = [540 378 760 720]; end %default: [440 378 560 420] %'docked')
leg = {};
for i = 1:length(R)
    semilogy(R{i}.dates-R{i}.shift_deaths_norm,R{i}.deaths/R{i}.population,R{i}.pt,sC,R{i}.col,sLW,R{i}.lw);leg{end+1}=sprintf('%s %d',R{i}.fn_no_ext,R{i}.shift_deaths_norm); hold on
end
semilogy([datetime('2019-12-01'),today_date+30],[thresh_deaths_norm,thresh_deaths_norm],'k'); leg{end+1}=sprintf('thresh=%.1f',thresh_deaths_norm); hold on
semilogy(thresh_exact+days-b1,y_dbl_day/scal,'k:',sLW,nLW_dbl);leg{end+1}='double every day'; hold on
semilogy(thresh_exact+days-b2,y_dbl_2_days/scal,'k--',sLW,nLW_dbl);leg{end+1}='double every 2 days'; hold on
semilogy(thresh_exact+days-b3,y_dbl_3_days/scal,'k-.',sLW,nLW_dbl);leg{end+1}='double every 3 days'; hold on
semilogy(thresh_exact+days-b4,y_dbl_4_days/scal,'k-',sLW,nLW_dbl);leg{end+1}='double every 4 days'; hold on
hold off
ylabel('deaths/million'); xlabel(sprintf('%s date',thresh_date_deaths_norm_reg_region.fn_no_ext))
title(sprintf('COVID-19 Normalized by population, shifted to same deaths at threshold (%s)',sDataDate));
legend(leg,'Location','NorthWest','FontSize',12)
xlim([thresh_date_deaths_norm-1, datetime('today')+7]) % [datetime('2020-03-17'),datetime('2020-03-20')])
ylim([2e-1,2e2])

figure(25)

if CTRL_SAVE_PLOT
    out_folder = 'plot';
    [status, msg, msgID] = mkdir(out_folder);
    fprintf('out_folder "%s" created. %s\n',out_folder, msg);

    if exist('fig25','var'), saveas(fig25,sprintf('%s/covid19-2d2-deaths-norm-shift-log-Ont-Sw.jpg',out_folder)); end  
end

fclose(fid_log);

