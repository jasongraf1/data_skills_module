# -------------------------------------------------------
# file: week_02-workshop_exercises.R
# author: Jason Grafmiller
# date: 2025-01-26
# description:
# Exercises for Week 2 workshop. Full code will be posted after class
# -------------------------------------------------------

# Start in a fresh R session in our data_skills project.


# Load in the 'tidyverse' package -----------------------



# Loading data -------------------------------------------

# Let's load the `baby_names_top100_eng_wales.csv` dataset.

# from a local file in out "data" folder:


# from an online site (our course GitHub repo):



# Inspect the data ---------------------------------------

# Let's find the basic dimensions:


# Use `glimpse()` to look at the structure:


# Look at the first 8 rows with `head()`:



# Look at the last 8 rows with `tail()`:


# Look at the header (column) names:



# Selecting specific columns -----------------------------

# Let's select only the `year`, `name`, and `rank` columns:



# Let's select the 2nd through the 5th columns



# Let's select all but the `nation` column:



# Renaming columns ----------------------------------------

# Let's rename the `n` column as "count"




# Mutating, Adding, and Pulling columns ------------------

# Let's `mutate` (transform) our names to all uppercase.
# We can edit this "in place", that is, change the existing `name` column itself,
# or we can create a new column containing the uppercase version of the names.
# Which do you think might be better, and why?



# Let's "pull" (extract) the values of the `name` column into a vector. Then we
# will count the number of unique names in our dataset.




# Sorting, Slicing, and Filtering data -------------------
# Let's sort the data by `name`:


# Let's sort the data by `sex`, then by `count` (did you remember to rename this
# column?):


# Let's sort by `year` but descending from 2023 down:



## Slicing --------------------------------

# Let's look at rows 40 through 80 with `slice()`:



# Let's randomly sample 20 rows with `slice_sample()`:



## Filtering -------------------------------- 

# Let's filter only the female names:


# Let's filter only the male names after the year 2013:




# Counting -----------------------------------------------

# Let's count the number of times each name occurs in our data:



# Let's count the number of times each name occurs and sort by the count (`n`):




# Pivoting -----------------------------------------------

# Let's see how to pivot data from wide to long and long to wide. 

# Let's look at the `uk_accents_sharma_et_al.csv` dataset. 
# 
# This is from a study in which 821 British participants were asked to rate 38 
# English accents for prestige and attractiveness on a scale from 1 (very low) 
# to 7 (very high)

# Load in the dataset as `sharma_accents` and inspect it (did it load correctly? how many rows and
# columns does it have? what is in those columns?) 


# Is this a "long" or "wide" tibble/dataframe? What does each row represent? 
# Does a row represent a single observation?


## Pivoting from wide to long ----------------------------

# We want to pivot the tibble so that we have two new but different columns: 
# - one column whose values are the traits (attractiveness and prestige) being
# evaluated
# - one column whose values are the ratings  

# We use `pivot_longer()`:



## Pivoting from long to wide ----------------------------

# Let's pivot back to the wide format using `pivot_wider()`:




# Question: Which version do you find easier to read and comprehend?







# References ---------------------------------------------

# Sharma, D., Levon, E. and Ye, Y. (2022). 50 years of British accent bias: 
# Stability and lifespan change in attitudes to accents. English World-Wide. 
# A Journal of Varieties of English. doi:10.1075/eww.20010.sha.


