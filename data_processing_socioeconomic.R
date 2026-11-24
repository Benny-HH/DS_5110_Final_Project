library(tidycensus)
library(dplyr)
library(purrr)
library(tigris)

setwd("~/Desktop/Northeastern Classes - Programming/DS 5110/Project/Project Data")

vars <- c(med_hh_inc = "B19013_001", 
          per_cap = "B19301_001",
          pov_univ = "B17001_001", 
          pov_below = "B17001_002", 
          pop = "B01003_001",
          median_age = "B01002_001",
          labor_force = "B23025_003",
          unemployed = "B23025_005",
          total_households = "B22001_001",
          snap_households = "B22001_002",
          occupied_housing = "B25003_001",
          renter_occ = "B25003_003")

years <- 2019:2024

census_api_key("defa954408cc53ac76cee9a7f1c6e917a779d551", install = TRUE, overwrite = TRUE)
readRenviron("~/.Renviron")

county <- purrr::map_dfr(years, ~ get_acs("county", variables=vars,
                                          year=.x, survey="acs5", output="wide") |> dplyr::mutate(year=.x))
state  <- purrr::map_dfr(years, ~ get_acs("state", variables=vars,
                                          year=.x, survey="acs5", output="wide") |> dplyr::mutate(year=.x))

county$state_fips <- substr(county$GEOID, 1, 2)
county$state <- tigris::fips_codes$state[
  match(county$state_fips, tigris::fips_codes$state_code)
]

write.csv(county, "socioeconomic_county.csv", row.names = FALSE)
write.csv(state, "socioeconomic_state.csv", row.names = FALSE)


