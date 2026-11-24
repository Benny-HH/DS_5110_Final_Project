library(dplyr)
library(stringr)
library(readr)
library(tigris)
library(sf)
library(tidygeocoder)

setwd("~/Desktop/Northeastern Classes - Programming/DS 5110/Project/Project Data/Medicare Part D for Naloxone:Buprenorphine Rates")
options(tigris_use_cache = TRUE)

dt_2019 <- read_csv("Medicare_Part_D_Prescribers_by_Provider_and_Drug_2019.csv")
dt_2020 <- read_csv("Medicare_Part_D_Prescribers_by_Provider_and_Drug_2020.csv")
dt_2021 <- read_csv("Medicare_Part_D_Prescribers_by_Provider_and_Drug_2021.csv")
dt_2022 <- read_csv("Medicare_Part_D_Prescribers_by_Provider_and_Drug_2022.csv")
dt_2023 <- read_csv("Medicare_Part_D_Prescribers_by_Provider_and_Drug_2023.csv")
dt_2024 <- read_csv("Medicare_Part_D_Prescribers_by_Provider_and_Drug_2024.csv")

nal_bup_all <- bind_rows(
  "2019" = dt_2019,
  "2020" = dt_2020,
  "2021" = dt_2021,
  "2022" = dt_2022,
  "2023" = dt_2023,
  "2024" = dt_2024,
  .id = "year"
) %>%
  mutate(year = as.integer(year))

write_csv(nal_bup_all, "nal_bup_all.csv")

# get county variable based on city and state, and compute dispensing rates
