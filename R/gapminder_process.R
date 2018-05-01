#' Calculate population relative to a baseline year
#'
#' Calculate population at different timepoints, for each country in the gapminder 
#' dataset relative to a baseline year. Append result to the dataframe as a new column.
#' @param gapminder_df dataframe of gapminder data
#' @param base_year numeric. Year to be taken as baseline for the calculation of 
#' of relative population change
#'
#' @return gapminder_df with relative population added as column pop_rel 
#' @export
#'
#' @importFrom dplyr %>%
#' @examples
gapmider_rel_pop <- function(gapminder_df, base_year = 1952) {
    
    # check that the base year is a valid year. 
    valid_b_y <- base_year %in% unique(gapminder_df$year) & is.numeric(base_year)
    if (!valid_b_y) {
        stop("base_year ", base_year,
             " not a valid year in gapminder dataset. \nValid years are: ", 
             paste(unique(gapminder_df$year), collapse = ","))
    }
    
    # group by country and calculate population relative to baseline year
    gapminder_df %>%
        dplyr::filter(year >= base_year) %>% 
        dplyr::group_by(country) %>% dplyr::do(rel_pop_get(., base_year)) %>%
        dplyr::ungroup()
}

# calculate population relative to a baseline year from gapminder single country 
# subset
rel_pop_get <- function(df, base_year){
    df$pop_rel <- df$pop/df$pop[df$year == base_year]
    df
}

#' Calculate population percentage change from baseline
#'
#' Calculate population percentage change from baseline from relative population
#' @param gapminder_df dataframe of gapminder data. Must contain pop_rel column.
#'
#' @return gapminder_df with population percentage change from baseline appended 
#' as column pop_perc
#' @export
#' 
pop_perc_get <- function(gapminder_df){
    gapminder_df$pop_perc <- (gapminder_df$pop_rel - 1) * 100
    gapminder_df
}