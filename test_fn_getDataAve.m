clearvars; clearvars -GLOBAL; close all; plotbrowser('off'); %clc
set(0,'DefaultFigureWindowStyle','docked')

sLW = 'LineWidth';
cBlu = [0 0.4470 0.7410];

oCanada = fn_create_region('Canada',37,'2020-01-27',1,'o-',cBlu);
R = oCanada;

Nave = 7;
data = [1,5,3,7,5,9,7,11,9,13,11,15,13,17,15]';
% data = 1:15;
% diff_data = diff(data);
% diff_data = diff(R.deaths(41:end));
% zero_data = diff_data==0;
% data1 = diff_data + zero_data;  % change zeros to 1 (for log plot min)
% data = diff_data + (diff_data==0);  % change zeros to 1 (for log plot min)
data_ave = fn_getDataAve(Nave,data);

leg = {};
fig = figure(1);
fn_ptr = @semilogy; % @plot;
fn_ptr(data,R.pt); leg{end+1}='data'; hold on
fn_ptr(data_ave,'o-',sLW,3); leg{end+1}='data ave'; hold on
legend(leg)

figure(1)