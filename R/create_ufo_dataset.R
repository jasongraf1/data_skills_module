# ----------------------------------------------------------------------------
# file: create_ufo_dataset.R
# author: Jason Grafmiller
# date: 2024-12-06
# description:
# Code for collecting and cleaning the UFO datasets from the tidyTuesdayR site:
# <https://github.com/rfordatascience/tidytuesday/blob/main/data/2023/2023-06-20/>
# ----------------------------------------------------------------------------

library(here) # for pathing to/from project directory
library(tidyverse) # for dplyr, ggplot, etc.
library(janitor) # for cleaning data

# the sighting info
tidy_ufos <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-06-20/ufo_sightings.csv')

# the sighting location info
places <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-06-20/places.csv')

# clean up the `places` dataframe
places <- places |>
  mutate(
    country = str_to_title(country),
    country = ifelse(str_detect(country, "U[sS][aA]"), "USA", country),
    country = ifelse(str_detect(country, "U\\.s\\."), "U.S.", country),
    country = ifelse(str_detect(country, "Great Britain"), "United Kingdom", country),
    country = str_remove_all(country, " \\(.*?\\)")
  ) |>
  distinct(city, state, country_code, .keep_all = TRUE)

# join the two 
ufos <- tidy_ufos |>
  left_join(
    places,
    by = c("city", "state", "country_code")
  )

ufos

# this is a large file, so save as .rds (for compact storage) as well as .csv
saveRDS(ufos, here("data", "ufo_sightings_global.rds"))
write_csv(ufos, here("data", "ufo_sightings_global.csv"))
