function shift_days = fn_get_shift(s_data_type, date_to_hit_thresh,thresh,Data)

% find days to shift so that threshold is reached on date_to_hit_thresh

if strcmp(s_data_type,'cases')
    data_gt_thresh = Data.cases > thresh;
elseif strcmp(s_data_type,'deaths')
    data_gt_thresh = Data.deaths > thresh;
elseif strcmp(s_data_type,'deaths_norm')
    data_gt_thresh = Data.deaths/Data.population > thresh;
else
    error('fn_get_shift: data_type=%s illegal value',s_data_type);
end

thresh_i = find(data_gt_thresh,1);
if ~isempty(thresh_i)
    thresh_date = Data.dates(thresh_i);
    shift_days = days(thresh_date - date_to_hit_thresh);
else
    shift_days = 0;
end