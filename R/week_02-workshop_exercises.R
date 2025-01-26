# ----------------------------------------------------------------------------
# file: week_02-workshop_exercises.R
# author: Jason Grafmiller
# date: 2025-01-26
# description:
# Exercises for Week 2 workshop. Full code will be posted after class
# ----------------------------------------------------------------------------

# Start in a fresh R session in our data_skills project.


# Load in the 'here' and 'tidyverse' packages -----------------------------



# Loading data ------------------------------------------------------------

# Let's load the `baby_names_top100_eng_wales.csv` dataset.

# from a local file in out "data" folder:


# from an online site (our course GitHub repo):



# Inspect the data --------------------------------------------------------

# Let's find the basic dimensions:


# Use `glimpse()` to look at the structure:


# Look at the first 8 rows with `head()`:



# Look at the last 8 rows with `tail()`:


# Look at the header (column) names:



# Selecting specific columns ----------------------------------------------

# Let's select only the `year`, `name`, and `rank` columns:



# Let's select the 2nd through the 5th columns



# Let's select all but the `nation` column:



# Renaming columns --------------------------------------------------------

# Let's rename the `n` column as "count"




# Mutating, Adding, and Pulling columns -----------------------------------

# Let's `mutate` (transform) our names to all uppercase.
# We can edit this "in place", that is, change the existing `name` column itself,
# or we can create a new column containing the uppercase version of the names.
# Which do you think might be better, and why?



# Let's "pull" (extract) the values of the `name` column into a vector. Then we
# will count the number of unique names in our dataset.




# Sorting, Slicing, and Filtering data ------------------------------------

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





# Pivoting ----------------------------------------------------------------

# Let's see how to pivot data from wide to long and long to wide



