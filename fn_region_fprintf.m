function s_short_text = fn_region_fprintf(fid,Region)

s_short_text = fn_region_fprintf_short(fid,Region);
fprintf(fid,'%s\n',s_short_text);

fprintf(fid,' shift_cases: %d\n',Region.shift_cases);
fprintf(fid,' shift_cases_norm: %d\n',Region.shift_cases_norm);
fprintf(fid,' shift_deaths: %d\n',Region.shift_deaths);
fprintf(fid,' shift_deaths_norm: %d\n',Region.shift_deaths_norm);
fprintf(fid,'\n');