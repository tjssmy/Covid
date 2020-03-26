function Data = fn_getCountryData(Data)

fn = sprintf('dat/%s.mat',Data.fn_no_ext);
% data = [1;1;1;1;1;1;1;1;4;5;7;7;7;7;7;7];
try
    load(fn) %,'data')
    fprintf('data loaded from %s\n',fn); 
catch
    fprintf('Error: could not read file %s\n',fn);
    return;
end

Data.cases = data(:,1);
Data.deaths = data(:,2);

len = length(Data.cases);
% start = '2020-01-27';
% dates = (1:len);
date1 = datetime(Data.start);
% date2 = datetime('today','InputFormat','yyyy-MM-dd');
date2 = date1 + days(len-1);
% t2 = datetime(2013,11,5,8,0,0);
Data.dates = date1:date2;
