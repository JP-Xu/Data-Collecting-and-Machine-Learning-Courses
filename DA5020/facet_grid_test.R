left_join(country_name[country_idx, ], indicator_data) %>% 
    ggplot() +
    geom_line( mapping = aes(x = year, y = value, color = `Country Name`, group =1)) +
    facet_wrap( vars(`Country Name`), nrow=3) +
    theme(axis.text.x=element_blank())


country_lists = c("Egypt, Arab Rep.","South Africa","Nigeria", "Kenya", "Ethiopia",
                  "China", "Japan", "India", "Korea, Dem. People's Rep.", "Iran, Islamic Rep.",
                  "Germany", "France", "Italy", "Sweden", "Norway")

left_join(country_name[country_idx, ], indicator_data) %>% 
    ggplot() +
    geom_line( mapping = aes(x = year, y = value, color = `Country Name`, group =1)) +
    facet_grid(cols = vars(`Country Name`)) +
    theme(axis.text.x=element_blank())

continent_lists <- countrycode(sourcevar = country_lists,
                                 origin = "country.name",
                                 destination = "continent")


continent_dict <- as_tibble( cbind(country_lists, continent_lists)) %>% 
    mutate( continent_lists = factor( continent_lists))

    
colnames(continent_dict) <- c("Country Name", "Continent")


base <- left_join(country_name[country_idx, ], indicator_data) %>% 
    left_join( continent_dict) %>% 
    ggplot() +
        geom_line( mapping = aes(x = year, y = value, color = `Country Name`, group =1))

base + facet_grid( . ~ `Country Name`)

        facet_wrap(vars( Contnent)) +
        theme(axis.text.x=element_blank())

