function s_short_text = fn_region_fprintf_short(fid,Region)

s_short_text = sprintf('Region: %s pop: %.1f million start: %s (%d days data)', Region.fn_no_ext, Region.population, Region.start, length(Region.cases));

fprintf(fid,'%s\n',s_short_text);
