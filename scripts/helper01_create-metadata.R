# get and save gapminder data
readr::write_csv(gapminder::gapminder, path = here::here("data/raw/gapminder.csv"))

# read data
gapminder_df <- readr::read_csv(here::here("data/raw/gapminder.csv"))

# create
write.csv(metadatar::create_meta_shell(gapminder_df, 
                                       factor_cols = c("country", 
                                                       "continent")), 
          file = here::here("data/metadata/gapminder_meta_shell.csv"), 
          row.names = F)



