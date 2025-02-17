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

stars <- c("Charlie Chaplin", "Judy Garland", "Lauren Bacall",
           "Lon Chaney", "James Stewart", "Al Pacino", "Toshiro Mifune",
           "Michael Shannon", "Vivien Leigh", "Cate Blanchett")

# Exercise 1 ------------------------------------------------

# Use `str_length()` to find the length of each name:

str_length(stars)


# Exercise 2 ------------------------------------------------

# 2a. Use `str_detect()` to check if any of your names contain 
# the letter "h":

str_detect(stars, "h")

# 2b. Use `str_subset()` to return only those names containing 
# the letter "h" (if there are any):

str_subset(stars, "h")

# Exercise 3 ------------------------------------------------

# Split your names into individual strings with `str_split()`:

str_split(stars, " ")


# Exercise 4 ------------------------------------------------

# 4a. Collapse all your names into a single string with 
# `str_c(..., collapse = ", ")`. Store this as another vector:

stars_comb <- str_c(stars, collapse = ", ")
stars_comb

# 4b. Split this new vector back into your original form using
# `str_split()` followed by `unlist()`:

# (Hint: Pay attention to how you specify the pattern to split
# by... See `?str_split()`)

stars_comb |> 
  str_split(", ") |> 
  unlist()



# Regular Expressions =======================================

# Exercise 5 ------------------------------------------------

# Using `str_subset()`, write a regex to return only those 
# names containing "h", "j", or "b":

str_subset(stars, "[jhb]")

# Exercise 6 ------------------------------------------------

# Write a regex to extract the first name of each star:

str_extract(stars, "^\\w+")


# Exercise 7 ------------------------------------------------

# Using the following vector of strings add the following vector 
# to your existing one with `c()`
new_stars <- c(" buster    Keaton", "Robert  de  Niro", "Bette   davis ")

stars <- c(stars, new_stars)

# Write a regex to replace all occurrences of multiple spaces 
# with a single space in your vector

str_replace_all(stars, "\\s+", " ") 


# Exercise 8 ------------------------------------------------

# Create a tibble containing a column called `name` whose values
# are the names in the vector you created 

film_data <- tibble(
  name = stars
)

# 8a. Clean the names by (i) removing multiple spaces, (ii) trimming
# any space at the start or end, and (iii) converting them to 
# title case

film_data <- film_data |> 
  mutate(
    name = str_replace_all(name, "\\s+", " ") |> 
      str_trim() |> 
      str_to_title()
  )
film_data

# 8b. Create two new columns, one containing only the first name,
# and the other containing on the last name: 

# I'll use **anchors** to fine the first and last set of one 
# or more letter characters "\\w+"
film_data |> 
  mutate(
    first = str_extract(name, "^\\w+"),
    last = str_extract(name, "\\w+$") 
  )

# Did it work the way you intended? If not, how might you fix it?

# Answer: not equite. I want "De Niro" for Robert De Niro, but I 
# only get "Niro". 
# One way I could fix this by simply removing the first name, 
# which is just one set of letters, rather than trying to identify 
# all the possible variations of last names
film_data |> 
  mutate(
    first = str_extract(name, "^\\w+"),
    last = str_remove(name, "^\\w+ ") # notice the extra space here 
  )







