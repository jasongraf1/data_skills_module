# ----------------------------------------------------------------------------
# file: week_02_practice_exercises.R
# author: Jason Grafmiller
# date: 2025-01-29
# description:
# Exercises for Week 2 introduction to tidy data
# ----------------------------------------------------------------------------

# ***README: Before doing these exercise, it will help to go through the 
# `week_02-workshop_exercises_complete.R` file first.***

# We're going to investigate some data collected and reported by DeWall et al.
# (2011) in their study of popular songs in the U.S. from 1980-2007. They argue
# that patterns in pop-song lyrics reflect increasing cultural shifts towards 
# greater self-focus (narcissism), individualism, and anti-social behaviour 
# in U.S. culture.  

# I have a number of issues with this study, and we're going to explore some 
# questions about their methods, results and assumptions

# In this session we'll start by looking at their data, which I've collected 
# by scraping from the published paper (they did not publish their data or analysis
# code as far as I am aware).  

# Helpful Keyboard shortcuts:
# - type "Alt+-" to insert the assignment arrow `<-` 

# - type "Cmd/Ctrl+Shift+M" to insert the pipe `|>` 

# - type "Cmd/Ctrl+Shift+R" to add sections to R scripts 


# Libraries ---------------------------------------------------------------

# Load in the `here` and `tidyverse` library:
library(here)
library(tidyverse)

# Data --------------------------------------------------------------------

# load in the `DeWall_et_al_2011_dataset.csv` as `dewall_data`

dewall_data <- here("data", "DeWall_et_al_2011_dataset.csv") |> 
  read_csv()

# Exercise 1: Inspecting the data -----------------------------------------

# a. what do the last 10 rows of the data look like? 

dewall_data |> 
  tail(n = 10)

# OR

dewall_data |> 
  slice_tail(n = 10)


# b. what are the unique values of the `Feature` column? 

dewall_data |> 
  pull(Feature) |> 
  unique()


# Exercise 2: selecting ---------------------------------------------------

# Select only the `Year`, `Mean`, and `Feature` columns and store this as a new
# tibble called `dewall_simple`:

dewall_simple <- dewall_data |> 
  select(Year, Mean, Feature)

dewall_simple # always CHECK!


# Exercise 3: sorting -----------------------------------------------------

# Sort this new `dewall_simple` tibble by `Mean`:

dewall_simple |> 
  arrange(Mean)

# Sort `dewall_simple` tibble by `Year` descending:

dewall_simple |> 
  arrange(desc(Year))


# Exercise 4: filtering ---------------------------------------------------

# Filter `dewall_simple` to show only data from 2000 or later:

dewall_simple |> 
  filter(Year >= 2000)


# Exercise 5: creating new columns ----------------------------------------

# Using `mutate()`, create a new column in `dewall_data` called `Scaled_mean` 
# that divides `Mean` by `SD`.
# Make sure to assign this to `dewall_data`

dewall_data <- dewall_data |> 
  mutate(
    Scaled_mean = Mean / SD
  )

dewall_data # always CHECK!


# Exercise 6: pivoting ----------------------------------------------------

# With `dewall_simple`, use `pivot_wider()` to show the Mean values for each 
# `Feature` as separate columns

dewall_simple |> 
  pivot_wider(
    names_from = "Feature",
    values_from = Mean
  )

# Store the output of this as another tibble `dewall_wide`

dewall_wide <- dewall_simple |> 
  pivot_wider(
    names_from = "Feature",
    values_from = Mean
  )

dewall_wide # always CHECK!


# Next week we'll work with this same dataset and see how to create nice 
# visualisations and plots of the data, which we can compare to the published
# plots....

# References --------------------------------------------------------------

# DeWall, C.N., Pond, R.S., Campbell, W.K., et al. (2011) Tuning in to 
# psychological change: Linguistic markers of psychological traits and 
# emotions over time in popular U.S. song lyrics. Psychology of Aesthetics, 
# Creativity, and the Arts, 5 (3): 200–207. doi:10.1037/a0023195.
