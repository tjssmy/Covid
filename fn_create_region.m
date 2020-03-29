function Region = fn_create_region(name,population,sStart,nLW,s_plot_type)

Region.fn_no_ext = name;
Region.population = population; % million
Region.start = sStart;
Region.lw = nLW;
Region.pt = s_plot_type;

Region.shift_cases = 0;
Region.shift_cases_norm = 0;
Region.shift_deaths = 0;
Region.shift_deaths_norm = 0;

Region = fn_getCountryData(Region);
stdout = 1;
fid = stdout;
fn_region_fprintf_short(fid,Region);

