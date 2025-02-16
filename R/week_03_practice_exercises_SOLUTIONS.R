# ----------------------------------------------------------------------------
# file: week_02_practice_exercises_SOLUTIONS.R
# author: Jason Grafmiller
# date: 2025-01-29
# description:
# Exercises for Week 2 introduction to tidy data
# ----------------------------------------------------------------------------

# Helpful Keyboard shortcuts:
# - type "Alt+-" to insert the assignment arrow `<-` 

# - type "Cmd/Ctrl+Shift+M" to insert the pipe `|>` 

# - type "Cmd/Ctrl+Shift+R" to add sections to R scripts 


# Libraries ---------------------------------------------------------------

# Load in the `here` and `tidyverse` library:
library(here)
library(tidyverse)


# Data --------------------------------------------------------------------

# load in the `baby_names_top100_eng_wales.csv` as `baby_names`

baby_names <- here("data", "baby_names_top100_eng_wales.csv") |> 
  read_csv()

# OR

baby_names <- read_csv("https://raw.githubusercontent.com/jasongraf1/data_skills_module/refs/heads/main/data/baby_names_top100_eng_wales.csv")

# Check the data:
baby_names


# Exercise 1: Filter the data --------------------------

# Create a new tibble containing only the data for the name "Chloe".
# Call that `chloe_data`. Hint: use the `filter()` function to filter only
# `name == "Chloe"`

chloe_data <- baby_names |> 
  filter(name == "Chloe")

# Exercise 2: Simple scatter plot --------------------------------

# Using this new tibble as the data, make a ggplot with 
# `year` on the x axis and `n` on the y axis

ggplot(chloe_data, aes(x = year, y = n))

# Next add a `geom_point()` layer

ggplot(chloe_data, aes(x = year, y = n)) +
  geom_point()

## Change the shape, size and colour -----------------
# Inside `geom_point()`, add `shape = 17`, `size = 3`, 
# and `colour = "red"`
# Make sure to separate each argument with a comma

ggplot(chloe_data, aes(x = year, y = n)) +
  geom_point(shape = 2, size = 3, colour = "red")

# You can find out more about point shapes here:
# https://www.sthda.com/english/wiki/ggplot2-point-shapes
# Try some other values on your own


# Exercise 3: Lines ---------------------------------

# What we're really looking at is a trend over years 
# (the technical term is a "time series"). This kind 
# of information is well-suited to presenting as a
# trend LINE.

# Using this same tibble, make a ggplot with 
# `Year` on the x axis and `Mean` on the y axis.
# This time add `geom_line()` instead of `geom_point()`

ggplot(chloe_data, aes(x = year, y = n)) +
  geom_line()

# Copy this same code and now add a `geom_point()` 
# after the `geom_line()`.

ggplot(chloe_data, aes(x = year, y = n)) +
  geom_line() +
  geom_point()

# Now inside `geom_line()`, add `linewidth = 2` and 
# change the colour to blue (same as with points).

ggplot(chloe_data, aes(x = year, y = n)) +
  geom_line(linewidth = 2, colour = "blue") +
  geom_point()

# experiment with changing the size (and colour) 
# of the points to make them more visible


# Exercise 4: Bar plots ---------------------------------

# load in the `uk_accents_bishop_coupland.csv` as `bishop_accents`
# This is a similar dataset to the Sharma et al. data we saw
# in class, but from 2004

bishop_accents <- here("data", "uk_accents_bishop_coupland.csv") |> 
  read_csv()

# OR 
bishop_accents <- read_csv("https://raw.githubusercontent.com/jasongraf1/data_skills_module/refs/heads/main/data/uk_accents_bishop_coupland.csv")

bishop_accents

# Using this new tibble as the data, make a ggplot with 
# `Label` on the x axis and `Prestige` on the y axis 

ggplot(
  data = bishop_accents,
  aes(x = Label, y = Prestige)
) 

# Add a `geom_col()` layer

ggplot(
  data = bishop_accents,
  aes(x = Label, y = Prestige)
) +
  geom_col()

## Color and width -----------------

# Inside `geom_col()`, add `width = 0.6`, `fill = "orchid"`
# Make sure to separate each argument with a comma

ggplot(
  data = bishop_accents,
  aes(x = Label, y = Prestige)
) +
  geom_col(width = 0.6, fill = "orchid")


## Flip coordinates -----------------

# Add a `coord_flip()` layer:

ggplot(
  data = bishop_accents,
  aes(x = Label, y = Prestige)
) +
  geom_col(width = 0.6, fill = "orchid") +
  coord_flip()


## Reorder bars by Prestige -----------------

# Inside the `aes()` function, change the `x` value to 
# `reorder(Label, Prestige)`

ggplot(
  data = bishop_accents,
  aes(x = reorder(Label, Prestige), y = Prestige)
) +
  geom_col(width = 0.6, fill = "orchid") +
  coord_flip()


# Exercise 5: Themes ---------------------------------

# Add different theme layers to change the look of the plot
# Try `theme_bw()`, `theme_minimal()`, `theme_classic()`
# and `theme_void()` (Not all at once!)

ggplot(
  data = bishop_accents,
  aes(x = reorder(Label, Prestige), y = Prestige)
) +
  geom_col(width = 0.6, fill = "orchid") +
  coord_flip() +
  theme_bw()

ggplot(
  data = bishop_accents,
  aes(x = reorder(Label, Prestige), y = Prestige)
) +
  geom_col(width = 0.6, fill = "orchid") +
  coord_flip() +
  theme_minimal()

ggplot(
  data = bishop_accents,
  aes(x = reorder(Label, Prestige), y = Prestige)
) +
  geom_col(width = 0.6, fill = "orchid") +
  coord_flip() +
  theme_void()


# Exercise 6: Titles and axis labels ---------------------------------

# Use `labs()` to add a titles and axis labels
# axis labels.
# Change the x label to ""
# Change the y label to "Mean prestige rating"
# Add a title: "Some English accents are more prestigious than others"

ggplot(
  data = bishop_accents,
  aes(x = reorder(Label, Prestige), y = Prestige)
) +
  geom_col(width = 0.6, fill = "orchid") +
  coord_flip() +
  theme_minimal() +
  labs(x = "", y = "Mean prestige rating",
       title = "Some English accents are more prestigious than others")

# Next, add two more arguments inside `labs()`
# `subtitle = "Rating scale from 1 (low prestige) to 7 (high prestige)"`
# `caption = "Data from Coupland & Bishop (2007)"`

ggplot(
  data = bishop_accents,
  aes(x = reorder(Label, Prestige), y = Prestige)
) +
  geom_col(width = 0.6, fill = "orchid") +
  coord_flip() +
  theme_classic() +
  labs(x = "", y = "Mean prestige rating",
       title = "Some English accents are more prestigious than others",
       subtitle = "Rating scale from 1 (low prestige) to 7 (high prestige)",
       caption = "Data from Coupland & Bishop (2007)"
         )


# Exercise 7: Faceting and colouring by column -----------------

# Let's go back to the `baby_names` dataset. We'll look
# at 4 specific names names in this data, and track 
# them over time. We'll look at the top 2 names in 1996
# and the top 2 names in 2020

## 7a. Filter --------------------

# See what the top names are in 1996 and 2020 by filtering 
# `rank == 1`, `year %in% c(1996, 2020)`

baby_names |> 
  filter(rank == 1, year %in% c(1996, 2020))

# create a new tibble for just these names with 
# `filter(name %in% c("Sophie", ...))`. Fill in all the
# names in here

baby_names_top4 <- baby_names |> 
  filter(name %in% c("Sophie", "Jack", "Olivia", "Oliver"))

# Check the data
baby_names_top4


## 7b. Lines by colour and type --------------------

# Let's go back to our line plots in Exercise 3.

ggplot(baby_names_top4, aes(x = year, y = n)) +
  geom_line() 

# Aaah! The lines should be zig-zagging. This is because 
# there are several values for each year (one for each name).

# Copy your code, but inside the `aes()` function, 
# add another argument: `colour = name`

ggplot(baby_names_top4, 
       aes(x = year, y = n, colour = name)) +
  geom_line()

# This time inside the `aes()` function, 
# add the argument: `linetype = name`

ggplot(baby_names_top4, 
       aes(x = year, y = n, linetype = name)) +
  geom_line()


# Now let's add another layer showing the rank for each name
# in each year.
# Add a label layer: `geom_label(aes(label = rank))`

ggplot(baby_names_top4, 
       aes(x = year, y = n, colour = name)) +
  geom_line() +
  geom_label(aes(label = rank))


## 7c. Lines by Facets --------------------

# Using the last code above, add a facet layer to 
# break the plot into subplots for each name
# Add `facet_wrap(~name)`

ggplot(baby_names_top4, 
       aes(x = year, y = n, colour = name)) +
  geom_line() +
  geom_label(aes(label = rank)) +
  facet_wrap(~name)

# Change this to `facet_wrap(~name, ncol = 4)`

ggplot(baby_names_top4, 
       aes(x = year, y = n, colour = name)) +
  geom_line() +
  geom_label(aes(label = rank)) +
  facet_wrap(~name, ncol = 4)

# Change this to `facet_wrap(~name, ncol = 1)`

ggplot(baby_names_top4, 
       aes(x = year, y = n, colour = name)) +
  geom_line() +
  geom_label(aes(label = rank)) +
  facet_wrap(~name, ncol = 1)





# References --------------------------------------------------------------

# Coupland, N. and Bishop, H. (2007) Ideologised values for 
# British accents. Journal of Sociolinguistics, 11 (1): 74–93. 
