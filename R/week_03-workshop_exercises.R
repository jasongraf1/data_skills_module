# ----------------------------------------------------------------------------
# file: week_03-workshop_exercises.R
# author: Jason Grafmiller
# date: 2025-01-26
# description:
# Exercises for Week 3 workshop. Full code will be posted after class
# ----------------------------------------------------------------------------

# Load our libraries:




# Simple bar plot ---------------------------------------------------------

# We'll start with a look at the `uk_accents_sharma_et_al.csv` dataset. 
# 
# This is from a study in which 821 British participants were asked to rate 38 
# English accents for prestige and attractiveness on a scale from 1 (very low) 
# to 7 (very high).

# One of the aims of this study was to examine patterns in UK speakers' attitudes
# towards different accents, and compare these rankings to those from similar
# studies in previous decades.

# Load in the dataset as `sharma_accents` and inspect it (did it load correctly? how many rows and
# columns does it have? what is in those columns?) 


# Check the data!


# Let's plot the ratings for `Prestige` by the accent (`Label`). We have our
# data and mapping to x and y values:



# Now we want columns corresponding to the ratings. We add a `geom_col()` layer
# with `+`:




# Not a great plot... How could we make it better? 
# Let's think for a moment about what we might want to communicate with this 
# data.  





















## Ordering bars -----------------------




## Flipping axes -----------------------




## Styling plots -----------------------

# colour

# axis labels

# titles

# themes




# Comparing groups --------------------------------------------------------

# What if we want to compare rankings for Prestige and Attractiveness? Are
# these ratings correlated, i.e. if an accent is rated high in Prestige is it
# also rated higher in Attractiveness



# We will **pivot** our data from a wide format to a long one




## Option 1: Dodging bars




## Option 2: Facets



# Line plots --------------------------------------------------------------

# Let's try the same data but with a different geom: a line



# add points:


# plot both traits with different color lines
 


# Quantitative data -------------------------------------------------------

# The next dataset contains nutritional information collected (in 2021) from the official Starbucks Coffee Company’s published data. You can find more on the Tidy Tuesday page here: 
# https://github.com/rfordatascience/tidytuesday/blob/main/data/2021/2021-12-21/readme.md




# Check the data!





## Histograms -----------------------
# Histograms are typically used to show the distribution of a continuous variable
# in terms of bars.

# Let's look at the distribution of calories in Starbucks' drinks.




# We can change the size of the bars with 'bins' or `binwidth`





## Scatterplots -----------------------

# For scatterplots we use the `geom_point()` function

# Let's plot the relation between `total_carbs_g` on the x axis and `calories`
# on the y axis




# Change the shape of the markers. We use numeric values between 0 and 25. 
# Try different numbers to see what you get




# We can map shape (or colour) to values in the data. But let's for now just 
# focus on the three main size options: "tall", "grande" and "venti". We'll
# filter for rows with `size` in one of these values





