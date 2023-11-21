# description -------

# R script to read XLSX data, clean it up, and store it
# as a CSV file

# load packages ------

library(tidyverse)
library(readxl)
library(janitor)

# code ------

# code --------------------------------------------------------------------

# read in data for day 1

data_day1_in <- read_xlsx("data/raw/Faecal sludge Analysis_05112023.xlsx", 
                          sheet = 1,
                          range = "A2:C7")

data_day1_renamed <- data_day1_in |> 
  janitor::clean_names() |> 
  rename(ts = ts_g_l,
         users = users_daily)

data_day1_out <- data_day1_renamed |> 
  fill(system_location) |> 
  separate_wider_delim(cols = system_location,
                       delim = "_",
                       names = c("system", "location")) |> 
  mutate(date_sample = "2023-11-01") |> 
  mutate(date_sample = as_date(date_sample)) |> 
  relocate(date_sample)

# read in data for day 2

data_day2_in <- read_xlsx("data/raw/Faecal sludge Analysis_05112023.xlsx", 
                          sheet = 1,
                          range = "A12:C17")

data_day2_renamed <- data_day2_in |>
  janitor::clean_names() |> 
  rename(ts = ts_g_l,
         users = users_daily)

data_day2_out <- data_day2_renamed |>
  fill(system_location) |> 
  separate_wider_delim(cols = system_location,
                       delim = "_",
                       names = c("system", "location")) |> 
  mutate(date_sample = "2023-11-02") |> 
  mutate(date_sample = as_date(date_sample)) |> 
  relocate(date_sample)

# read in data for day 3

data_day3_in <- read_xlsx("data/raw/Faecal sludge Analysis_05112023.xlsx", 
                          sheet = 1,
                          range = "A22:C27")

data_day3_renamed <- data_day3_in |>
  janitor::clean_names() |> 
  rename(ts = ts_g_l,
         users = users_daily)

data_day3_out <- data_day3_renamed |>
  fill(system_location) |> 
  separate_wider_delim(cols = system_location,
                       delim = "_",
                       names = c("system", "location")) |> 
  mutate(date_sample = "2023-11-03") |> 
  mutate(date_sample = as_date(date_sample)) |> 
  relocate(date_sample)


# read in data for day 4

data_day4_in <- read_xlsx("data/raw/Faecal sludge Analysis_05112023.xlsx", 
                          sheet = 1,
                          range = "A32:C37")

data_day4_renamed <- data_day4_in |>
  janitor::clean_names() |> 
  rename(ts = ts_g_l,
         users = users_daily)

data_day4_out <- data_day4_renamed |>
  fill(system_location) |> 
  separate_wider_delim(cols = system_location,
                       delim = "_",
                       names = c("system", "location")) |> 
  mutate(date_sample = "2023-11-04") |> 
  mutate(date_sample = as_date(date_sample)) |> 
  relocate(date_sample)


# combine data ----

data_clean <- bind_rows(data_day1_out,
                        data_day2_out,
                        data_day3_out,
                        data_day4_out) |> 
  mutate(id = 1:n()) |> 
  relocate(id)


# save data ---------------------------------------------------------------

write_csv(data_clean, "data/processed/tbl-01-faecal-sludge-samples.csv")
