# ----------------------------------------------------------------------------
# file: clean_lyrics_dataset.R
# author: Jason Grafmiller
# date: 2025-02-14
# description:
# script for cleaning the lyrics dataset downloaded from Kaggle
# ----------------------------------------------------------------------------

library(here)
library(tidyverse)
library(janitor) # for cleaning names

# Download data from 
# https://www.kaggle.com/datasets/rhaamrozenberg/billboards-top-100-song-1946-to-2022-lyrics/data

df <- here("data", "billboard_top_100_1946_2022_lyrics.csv") |> 
  read_csv()

# clean up the column names and rename `year`

df_clean <- df |> 
  clean_names() |> 
  rename(year = "hot100_ranking_year") 


# Now we want to clear the text of the artist names and the lyrics. Three steps
# - use regular expression to remove all "[", "]" or "'" from artist names
# - change artist names to title case 
# - use regular expression to remove all "[", "]", "'" or "," from lyrics

df_clean <- df_clean |> 
  mutate(
    artist_names = str_remove_all(artist_names, "(\\[|\\]|')"),
    artist_names = str_to_title(artist_names),
    lyrics = str_remove_all(lyrics, "(\\[|\\]|'|,)")
  )

# The early data is very spotty so we'll only save data from 1955 on. We'll 
# save this as a "Tab-separated value" file `.tsv` with `write_delim()`. 
# I like to use .tsv files rather than (comma-separated) .csv files for text 
# data because R can sometimes have issues parsing the file when commas are 
# used to separate columns, but the text column(s) also has commas in it. 
# Text data rarely has tabs, so it is safer in my expreience.

write_delim(
  df_clean,
  here("data", "billboard_top_100_1955_2022_lyrics.tsv"),
  delim = "\t"
)

