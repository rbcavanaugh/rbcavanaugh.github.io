
## ---- warning = FALSE, message = FALSE----------------------------------------------------------------------------
# load packages needed
library(tidyverse)
library(readxl)
library(janitor)


## -----------------------------------------------------------------------------------------------------------------
# read in data 2016
data_2016 = readxl::read_excel(
  here::here("_posts", "2022-06-25-aphasia-access-awareness-survey", "NAA-2016-National-Survey-Raw-Data.xlsx"),
  sheet = 2 ,col_types = "text")
# read in data 2020
data_2020 = readxl::read_excel(
  here::here("_posts", "2022-06-25-aphasia-access-awareness-survey", "2020-NAA-National-Survey-Raw-Data-Cleaned-.xlsx"),
  sheet = 1 ,col_types = "text")
# read in data 2022
data_2022 = readxl::read_excel(
  here::here("_posts", "2022-06-25-aphasia-access-awareness-survey", "2022-Aphasia-Awareness-Survey_raw_cleaned.xlsx"),
  sheet = 1 ,col_types = "text") 


## -----------------------------------------------------------------------------------------------------------------
# need to deal with inconsistent column names. They're in different orders and
# varied across the three datasets so for time I'm just going to manually create
# short variable names that are easier to work with. 

names2016 = c("date_utc", "country", "state", "metro_area", "gender", "age", "os", "browser",
           "introduction", "q_heard_of", "q_own_words", "q_describes", "q_common_cva",
           "q_intellect", "q_first_heard", "q_diagnosed", "q_how_long_ago", "q_know_someone_else",
           "q_know_someone", "q_causes", "q_causes_cva", "q_causes_tumor", "q_causes_tbi",
           "q_causes_heart", "q_causes_notsure", "q_past_year", "q_last_place")

colnames(data_2016) = names2016

names2020 = c("date_utc", "tz", "date_local", "length_seconds", "country", "state",
              "metro_area", "zip", "zip_med_income", "zip_range_income", "urbanicity", 
              "region", "division" , "city", "gender", "age", "os", "browser",
           "introduction", "q_heard_of", "q_own_words", "q_describes", "q_common_cva",
           "q_intellect", "q_black_fingerprint", "q_first_heard", "q_diagnosed", "q_how_long_ago", "q_know_someone_else",
           "q_know_someone", "q_causes", "q_causes_cva", "q_causes_tumor", "q_causes_tbi",
           "q_causes_heart", "q_causes_notsure", "q_past_year", "q_last_place")

colnames(data_2020) = names2020

names2022 = c("start_date", "end_date", "q_intellect", "q_common_cva", "q_heard_of", 
              "q_own_words", "q_describes", "q_first_heard", "q_first_heard_other", 
              "q_diagnosed", "q_how_long_ago", "q_know_someone_else",  "q_know_someone", "q_causes_cva",
              "q_causes_tumor", "q_causes_tbi", "q_causes_heart", "q_causes_notsure",
              "q_past_year", "q_last_place", "region", "hh_income", "device", "age", "gender")

colnames(data_2022) = names2022


## -----------------------------------------------------------------------------------------------------------------
# clean up individual data files
data_2016 = data_2016 %>%
  mutate(
    q_past_year = 
        case_when(
          q_past_year == "1 -3" ~ "1 to 3",
          q_past_year == "4 - 6" ~ "4 to 6",
          q_past_year == "7 - 9" ~ "7 to 9",
          TRUE ~ q_past_year
        )
  ) %>%
  slice(-1) 

data_2020 = data_2020 %>%
  mutate(
    q_past_year = 
        case_when(
          q_past_year == "1 -3" ~ "1 to 3",
          q_past_year == "4 - 6" ~ "4 to 6",
          q_past_year == "7 - 9" ~ "7 to 9",
          TRUE ~ q_past_year
        )
  )


data_2022 = data_2022 %>%
  mutate(
    q_past_year = 
        case_when(
          q_past_year == "44564" ~ "1 to 3",
          q_past_year == "44657" ~ "4 to 6",
          q_past_year == "44751" ~ "7 to 9",
          TRUE ~ q_past_year
        )
  ) %>%
  slice(-1) %>%
  mutate(across(q_causes_cva:q_causes_notsure, ~ ifelse(q_heard_of=="No", NA,
                                                         ifelse(is.na(.), "0", "1")))) %>%
  drop_na(device) %>%
  mutate(q_describes = ifelse(str_detect(q_describes, "sure"), "I'm not sure", q_describes))
  
## -----------------------------------------------------------------------------------------------------------------
# combind the three dataframes and select on the common columns
data_list <- mget(ls(pattern = "data_20"))
common_cols <- Reduce(intersect, lapply(data_list, names))
data_all = bind_rows(lapply(data_list, `[`, common_cols), .id = "year") %>%
  mutate(year = str_remove(year, "data_"))


## -----------------------------------------------------------------------------------------------------------------
# helpful for eyeballing values to ID discrepancies for each column
unique_string = function(col){
  paste(sort(unique(col), na.last = TRUE), collapse = ", ")
}

t = data_all %>%
  mutate_all(tolower) %>%
  group_by(year) %>%
  summarize(vals = across(.cols = everything(), unique_string))

## -----------------------------------------------------------------------------------------------------------------
# save data
# write.csv(data_all,
#          here::here("_posts", "2022-06-25-aphasia-access-awareness-survey", "2022-06-26_data-cleaned.csv"), row.names = FALSE)

rm(list=setdiff(ls(), "data_all"))