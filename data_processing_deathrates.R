library(dplyr)
library(readr)

setwd("~/Desktop/Northeastern Classes - Programming/DS 5110/Project/Project Data")

dt_deathrates <- read.csv("~/Desktop/Northeastern Classes - Programming/DS 5110/Project/Project Data/deathrates_cdcwonder.csv")

deathrates_state <- dt_deathrates %>%
  filter(State != "", !is.na(Year)) %>%                  # drop footer/notes rows
  mutate(
    Deaths = as.numeric(Deaths),
    Population = as.numeric(Population)                  # non-numeric text becomes NA
  ) %>%
  group_by(State, Year, UCD...Drug.Alcohol.Induced.Cause, UCD...Drug.Alcohol.Induced.Cause.Code) %>%
  summarize(
    deaths = sum(Deaths, na.rm = TRUE),
    population = sum(Population, na.rm = TRUE),
    rate = (deaths / population) * 100000,
    .groups = "drop"
  ) %>%
  rename(cause = UCD...Drug.Alcohol.Induced.Cause, ucd_code = UCD...Drug.Alcohol.Induced.Cause.Code)

deathrates_county <- dt_deathrates %>%
  filter(State != "", !is.na(Year)) %>%                  # drop footer/notes rows
  mutate(
    Deaths = as.numeric(Deaths),
    Population = as.numeric(Population)                  # non-numeric text becomes NA
  ) %>%
  group_by(County.Code, County, State, Year, UCD...Drug.Alcohol.Induced.Cause, UCD...Drug.Alcohol.Induced.Cause.Code) %>%
  summarize(
    deaths = sum(Deaths, na.rm = TRUE),
    population = sum(Population, na.rm = TRUE),
    rate = (deaths / population) * 100000,
    .groups = "drop"
  ) %>%
  rename(county_code = County.Code, cause = UCD...Drug.Alcohol.Induced.Cause, ucd_code = UCD...Drug.Alcohol.Induced.Cause.Code)

write_csv(deathrates_county, "deathrates_county.csv")
write_csv(deathrates_state, "deathrates_state.csv")
