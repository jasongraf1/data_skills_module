# ----------------------------------------------------------------------------
# file: week_02-workshop_exercises.R
# author: Jason Grafmiller
# date: 2025-01-26
# description:
# Exercises for Week 2 workshop. Full code will be posted after class
# ----------------------------------------------------------------------------

# Start in a fresh R session in our data_skills project.


# Load in the 'here' and 'tidyverse' packages -----------------------------
library(here)
library(tidyverse)

mtcars
mtcars_tib <- as_tibble(mtcars)
mtcars_tib
select(mtcars_tib, mpg, wt)

mtcars_tib |> 
  select(mpg, wt)


# Loading data ------------------------------------------------------------

# Let's load the `baby_names_top100_eng_wales.csv` dataset.

# from a local file in out "data" folder:
here()
here("data")
here("data", "baby_names_top100_eng_wales.csv")

# Tip: typing Alt + '-' (Alt and minus keys) inserts an assignment arrow `<-` 

baby_names <- read_csv(here("data", "baby_names_top100_eng_wales.csv"))

# or with the pipe

baby_names <- here("data", "baby_names_top100_eng_wales.csv") |> 
  read_csv()

# Tip: remember to go to "Tools" > "Global Options..." and in the "Code" section
# make sure the "Use native pipe operator" button is checked

# type "Cmd/Ctrl+Shift+M" to insert the pipe `|>`

# from an online site, e.g. our course GitHub repository:
# https://github.com/jasongraf1/data_skills_module
# Go to this link and find the "data" folder, and inside that folder click the 
# `baby_names_top100_eng_wales.csv` file.
# Remember that you then have to click the "Raw" button to get the URL for 
# the actual raw data.
# It should look like nothing but a bunch of text with lots of commas    

baby_name <- read_csv("https://raw.githubusercontent.com/jasongraf1/data_skills_module/refs/heads/main/data/baby_names_top100_eng_wales.csv")


# Inspect the data --------------------------------------------------------

# Let's find the basic dimensions:
baby_names

# Use `glimpse()` to look at the structure:
glimpse(baby_names)

# Look at the first 8 rows with `head()`:
head(baby_names, n = 8)


# Look at the last 8 rows with `tail()`:
tail(baby_names, n = 8)

# Look at the header (column) names:
names(baby_names)


# Selecting specific columns ----------------------------------------------

# Let's select only the `year`, `name`, and `rank` columns:

baby_names |> 
  select(year, name, rank)

# Let's select the 2nd through the 5th columns

baby_names |> 
  select(2:5)

# Let's select all but the `nation` column:

baby_names |> 
  select(-nation)

# Renaming columns --------------------------------------------------------

# Let's rename the `n` column as "count"

baby_names |> 
  rename(count = "n")

# If we want to change this for good in the data frame, we need to assign the
# output to a variable. Here it's just the same variable as before

baby_names <- baby_names |> 
  rename(count = "n")

# Mutating, Adding, and Pulling columns -----------------------------------

# Let's `mutate` (transform) our names to all uppercase.
# We can edit this "in place", that is, change the existing `name` column itself,
# or we can create a new column containing the uppercase version of the names.
# Which do you think might be better, and why?

# change a column 'in place':
baby_names |> 
  mutate(
    name = toupper(name)
  )

# add a new column:
baby_names |> 
  mutate(
    name_upper = toupper(name)
  )


# Let's "pull" (extract) the values of the `name` column into a vector. Then we
# will count the number of unique names in our dataset.

# `pull()` does NOT create a tibble, notice. Its output is just a vector of names.

baby_names |> 
  pull(name)

# R stops showing elements after 1000. 

# We can sort these names:

baby_names |> 
  pull(name) |> 
  sort()

# Notice there are lots of repetitions, which makes sense because some names
# are very popular every year.

# we can get only the unique names with `unique()`.  

baby_names |> 
  pull(name) |> 
  sort() |> 
  unique() 

# Note that `unique()` is not a tidyverse function so it will not work with 
# tibbles

baby_names |> 
  unique(name) # does not work!


# Sorting, Slicing, and Filtering data ------------------------------------

# Let's sort the data by `name`:

baby_names |> 
  arrange(name)

# Let's sort the data by `sex`, then by `count` (did you remember to rename this
# column?):

baby_names |> 
  arrange(sex, count)

# Let's sort by `year` but descending from 2023 down:

baby_names |> 
  arrange(desc(year))


## Slicing --------------------------------

# Let's look at rows 40 through 80 with `slice()`:

baby_names |> 
  slice(40:80)

# Let's randomly sample 20 rows with `slice_sample()`:

baby_names |> 
  slice_sample(n = 20)


## Filtering -------------------------------- 

# Let's filter only the female names:

baby_names |> 
  filter(sex == "F")

# Let's filter only the female names and sort by `name`:

baby_names |> 
  filter(sex == "F") |> 
  arrange(name)


# Let's filter only the male names after the year 2013:

baby_names |> 
  filter(sex == "M", year > 2013) 



# Counting ----------------------------------------------------------------

# Let's count the number of times each name occurs in our data:

baby_names |> 
  count(name)

# Note that this is a new tibble with two columns and 411 rows. This is because
# there are only 411 unique names in the data. 

# Let's count the number of times each name occurs and sort by the count (`n`):

baby_names |> 
  count(name) |> 
  arrange(n)

baby_names |> 
  count(name) |> 
  arrange(desc(n))

# There are only 28 years in the data (1996-2023). How come "Charlie" shows up
# 34 times? Does this make sense? (there is a valid reason for this...) 

# It's always important to stop and check whether what you are getting makes
# sense with what you know about your data. 


# Pivoting ----------------------------------------------------------------

# Let's see how to pivot data from wide to long and long to wide. 

# Let's look at the `uk_accents_sharma_et_al.csv` dataset. 
# 
# This is from a study in which 821 British participants were asked to rate 38 
# English accents for prestige and attractiveness on a scale from 1 (very low) 
# to 7 (very high)

# Load in the dataset as `sharma_accents` and inspect it (did it load correctly? 
# how many rows and columns does it have? what is in those columns?) 

sharma <- here("data", "uk_accents_sharma_et_al.csv") |> 
  read_csv()

sharma

# Is this a "long" or "wide" tibble/dataframe? What does each row represent? 
# Does a row represent a single observation?

# We didn't get to this in class, but you can see more about this here:
# https://r4ds.hadley.nz/data-tidy.html#sec-pivoting

## Pivoting from wide to long --------------------------------

# We want to pivot the tibble so that we have two new but different columns: 
# - one column whose values are the traits (attractiveness and prestige) being
# evaluated
# - one column whose values are the ratings  

# We use `pivot_longer()`:

sharma_long <- sharma |> 
  pivot_longer(
    cols = Attractiveness:Prestige,
    names_to = "Trait",
    values_to = "Rating"
  )

sharma_long

## Pivoting from long to wide --------------------------------

# Let's pivot back to the wide format using `pivot_wider()`:

sharma_long |> 
  pivot_wider(
    names_from = "Trait",
    values_from = "Rating"
  )


# Question: Which version do you find easier to read and comprehend?


# References --------------------------------------------------------------

# Sharma, D., Levon, E. and Ye, Y. (2022). 50 years of British accent bias: 
# Stability and lifespan change in attitudes to accents. English World-Wide. 
# A Journal of Varieties of English. doi:10.1075/eww.20010.sha.


