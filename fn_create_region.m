function Region = fn_create_region(name,population,sStart,nLW,s_plot_type)

Region.fn_no_ext = name;
Region.population = population; % million
Region.start = sStart;
Region.lw = nLW;
Region.pt = s_plot_type;
Region = fn_getCountryData(Region);
