library(dplyr)
library(stringr)

# dataset from https://data.cms.gov/resources/medicare-part-d-prescribers-by-geography-and-drug-data-dictionary

setwd("~/Desktop/Northeastern Classes - Programming/DS 5110/Project/Project Data/Medicare Part D by geography")

partd_2019 <- read_csv("Medicare_Part_D_Prescribers_by_Geography_and_Drug_2019.csv")
partd_2020 <- read_csv("Medicare_Part_D_Prescribers_by_Geography_and_Drug_2020.csv")
partd_2021 <- read_csv("Medicare_Part_D_Prescribers_by_Geography_and_Drug_2021.csv")
partd_2022 <- read_csv("Medicare_Part_D_Prescribers_by_Geography_and_Drug_2022.csv")
partd_2023 <- read_csv("Medicare_Part_D_Prescribers_by_Geography_and_Drug_2023.csv")
partd_2024 <- read_csv("Medicare_Part_D_Prescribers_by_Geography_and_Drug_2024.csv")

years = 2019:2024

partd <- list()

for (yr in years) {
  file <- paste0("Medicare_Part_D_Prescribers_by_Geography_and_Drug_", yr, ".csv")
  
  partd[[as.character(yr)]] <- read_csv(file) %>%
    filter(Prscrbr_Geo_Lvl == "State") %>%
    mutate(year = yr)
}

partd_all <- bind_rows(partd)

write_csv(partd_all, "partd_all.csv")

# target_stems <- c(
#   # treatment / reversal
#   "buprenorphine", "naloxone",
#   
#   # opioid analgesics
#   "oxycodone", "hydrocodone", "morphine", "codeine", "hydromorphone",
#   "oxymorphone", "methadone", "fentanyl", "tramadol", "tapentadol",
#   "meperidine", "levorphanol", "butorphanol", "pentazocine", "opium",
#   "sufentanil", "remifentanil", "alfentanil", "nalbuphine",
#   "dihydrocodeine", "apadaz", "benzhydrocodone"
# )
# 
# pattern <- paste(target_stems, collapse = "|")
# 
# partd_opioid <- partd_all %>%
#   filter(str_detect(str_to_lower(Gnrc_Name), pattern))
