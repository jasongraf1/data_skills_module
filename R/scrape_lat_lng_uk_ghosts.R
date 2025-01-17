# ----------------------------------------------------------------------------
# file: scrape_lat_lng_uk_ghosts.R
# author: Jason Grafmiller
# date: 2024-12-23
# description:
# Scrapes the latitude and longitude data for hauntings in the UK Haunted 
# Locations Database: http://paullee.com/ghosts/ghostgeo/
# ----------------------------------------------------------------------------

suppressMessages(library(here)) # for pathing to/from project directory
suppressMessages(library(tidyverse)) # for dplyr, ggplot, etc.
suppressMessages(library(janitor)) # for cleaning data
suppressMessages(library(httr))
suppressMessages(library(jsonlite))
suppressMessages(library(rvest))
suppressMessages(library(polite))

ghost_url <- read_html("http://paullee.com/ghosts/ghostgeo/listghostdata.php")

# check for robots.txt file
session <- bow("http://paullee.com/ghosts/ghostgeo/listghostdata.php")
session

# scrape the links
links <- scrape(session) |> 
  html_elements("a") |> 
  html_attr("href")

# Simple function for getting the lat and lng information from the link text
get_lat_long <- function(x){
  # all links have the form: "http://www.paullee.com/ghosts/ghostgeo/extractghostdata.php?location=50o027955_-5o242824_NAME.txt"
  # where the location is given in "location=50o027955_-5o242824", so we can just
  # split on '(=|_)' to get [url, lat, lng, name]  
  data <- str_split(x, "(=|_)") |> 
    unlist()
  data[4] <- str_remove(data[4], "\\.txt")
  data <- data[2:4]
  names(data) <- c("latitude", "longitude", "name")
  return(data)
}


ghost_uk_df <- map_df(links, ~get_lat_long(.x)) |> 
  # the coords are given in degrees with 'o' rather than a decimal, so we need
  # to replace this and coerce to numeric vector
  mutate(
    latitude = str_replace(latitude, "o", ".") |> 
      as.numeric(),
    longitude = str_replace(longitude, "o", ".") |> 
      as.numeric()
  )

# check that it worked
head(ghost_uk_df)

write_csv(ghost_uk_df, "C:/Users/grafmilj/Dropbox/datasets/ghosts_uk.csv")
