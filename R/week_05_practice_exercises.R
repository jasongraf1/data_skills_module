# ----------------------------------------------------------------------------
# file: week_05_practice_exercises.R
# author: Jason Grafmiller
# date: 2025-02-17
# description:
# Exercises for Week 5 working with strings and Regex
# ----------------------------------------------------------------------------

# Data: create a vector of strings for 10 of your favourite 
# films stars with the `c(...)` function, e.g.
# `stars <- c("Charlie Chaplin", "Judy Garland", ...)`

# if you can't think of ten people, or you are not much of a film
# watcher, you can get some examples of movie stars here: 
# https://www.imdb.com/list/ls058011111/


# Exercise 1 ------------------------------------------------

# Use `str_length()` to find the length of each name:



# Exercise 2 ------------------------------------------------

# 2a. Use `str_detect()` to check if any of your names contain 
# the letter "h":


# 2b. Use `str_subset()` to return only those names containing 
# the letter "h" (if there are any):



# Exercise 3 ------------------------------------------------

# Split your names into individual strings with `str_split()`:




# Exercise 4 ------------------------------------------------

# 4a. Collapse all your names into a single string with 
# `str_c(..., collapse = ", ")`. Store this as another vector:



# 4b. Split this new vector back into your original form using
# `str_split()` followed by `unlist()`:

# (Hint: Pay attention to how you specify the pattern to split
# by... See `?str_split()`)




# Regular Expressions =======================================

# Exercise 5 ------------------------------------------------

# Using `str_subset()`, write a regex to return only those 
# names containing "h", "j", or "b":



# Exercise 6 ------------------------------------------------

# Write a regex to extract the last name of each star:



# Exercise 7 ------------------------------------------------

# Using the following vector of strings...
my_stars <- c("buster    Keaton", "Robert  de Niro", "Bette   davis")

# Write a regex to replace all occurrences of multiple spaces 
# with a single space in `my_stars`...



# Exercise 8 ------------------------------------------------

# Create a tibble containing a column called `name` whose values
# are the names in the vector you created 



# 8a. Clean the names by (i) removing multiple spaces, (ii) trimming
# any space at the start or end, and (iii) converting them to 
# title case:



# 8b. Create two new columns, one containing only the first name,
# and the other containing on the last name: 


# Did it work the way you intended? If not, how might you fix it?











