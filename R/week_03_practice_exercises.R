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



# Data --------------------------------------------------------------------

# load in the `baby_names_top100_eng_wales.csv` as `baby_names`


# Check the data:



# Exercise 1: Filter the data --------------------------

# Create a new tibble containing only the data for the name "Chloe".
# Call that `chloe_data`. Hint: use the `filter()` function to filter only
# `name == "Chloe"`



# Exercise 2: Simple scatter plot --------------------------------

# Using this new tibble as the data, make a ggplot with 
# `year` on the x axis and `n` on the y axis



# Next add a `geom_point()` layer



## 2b. Change the shape, size and colour -----------------
# Inside `geom_point()`, add `shape = 17`, `size = 3`, 
# and `colour = "red"`
# Make sure to separate each argument with a comma



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



# Copy this same code and now add a `geom_point()` 
# after the `geom_line()`.



# Now inside `geom_line()`, add `linewidth = 2` and 
# change the colour to blue (same as with points).



# experiment with changing the size (and colour) 
# of the points to make them more visible


# Exercise 4: Bar plots ---------------------------------

# load in the `uk_accents_bishop_coupland.csv` as `bishop_accents`
# This is a similar dataset to the Sharma et al. data we saw
# in class, but from 2004



# Using this new tibble as the data, make a ggplot with 
# `Label` on the x axis and `Prestige` on the y axis 


# Add a `geom_col()` layer


## 4a. Color and width -----------------

# Inside `geom_col()`, add `width = 0.6`, `fill = "orchid"`
# Make sure to separate each argument with a comma



## 4b. Flip coordinates -----------------

# Add a `coord_flip()` layer:



## 4c. Reorder bars by Prestige -----------------

# Inside the `aes()` function, change the `x` value to 
# `reorder(Label, Prestige)`



# Exercise 5: Themes ---------------------------------

# Add different theme layers to change the look of the plot
# Try `theme_bw()`, `theme_minimal()`, `theme_classic()`
# and `theme_void()` (Not all at once!)





# Exercise 6: Titles and axis labels ---------------------------------

# Use `labs()` to add a titles and axis labels
# axis labels.
# Change the x label to ""
# Change the y label to "Mean prestige rating"
# Add a title: "Some English accents are more prestigious than others"



# Next, add two more arguments inside `labs()`
# `subtitle = "Rating scale from 1 (low prestige) to 7 (high prestige)"`
# `caption = "Data from Coupland & Bishop (2007)"`


# Exercise 7: Faceting and colouring by column -----------------

# Let's go back to the `baby_names` dataset. We'll look
# at 4 specific names names in this data, and track 
# them over time. We'll look at the top 2 names in 1996
# and the top 2 names in 2020

## 7a. Filter --------------------

# See what the top names are in 1996 and 2020 by filtering 
# `rank == 1`, `year %in% c(1996, 2020)`


# create a new tibble for just these names with 
# `filter(name %in% c("Sophie", ...))`. Fill in all the
# names in here


# Check the data



## 7b. Lines by colour and type --------------------

# Let's go back to our line plots in Exercise 3. Copy the
# code from there, but change the data to the new tibble
# you just created



# Aaah! The lines should be zig-zagging. This is because 
# there are several values for each year (one for each name).

# Copy your code but inside the `aes()` function add another 
# argument: `colour = name`



# This time inside the `aes()` function, 
# add the argument: `linetype = name`



# Now let's add another layer showing the rank for each name
# in each year.
# Add a label layer: `geom_label(aes(label = rank))`




## 7c. Lines by Facets --------------------

# Using the last code above, add a facet layer to 
# break the plot into subplots for each name

# to your previous code, add `facet_wrap(~name)`



# Change this to `facet_wrap(~name, ncol = 4)`


# Change this to `facet_wrap(~name, ncol = 1)`



# References --------------------------------------------------------------

# Coupland, N. and Bishop, H. (2007) Ideologised values for 
# British accents. Journal of Sociolinguistics, 11 (1): 74–93. 
