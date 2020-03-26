function fn_save_country_data(Data)

data = [Data.cases, Data.deaths];
fn = sprintf('%s.mat',Data.fn_no_ext);
save(fn,'data')
fprintf('Country %s data saved in %s\n',Data.fn_no_ext, fn);
