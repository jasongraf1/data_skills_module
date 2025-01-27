# ----------------------------------------------------------------------------
# file: week_02-seminar_code.R
# author: Jason Grafmiller
# date: 2025-01-27
# Goals of the session: 
# - Continue practice with loading and inspecting datasets
# - Take a look at some sources of interesting data that we might use for other projects
# ----------------------------------------------------------------------------

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

# Tip: type "Cmd/Ctrl+Shift+R" to add sections to R scripts 

# Libraries ---------------------------------------------------------------



# Data --------------------------------------------------------------------

# load in the `DeWall_et_al_2011_dataset.csv`



# Inspect the data:
# - how many rows?
# - how many columns?
# - What are the data types (numeric, character) of the columns?
# - what do the last 10 rows of the data look like? 


# - what are the values of the `Feature` column?


# Selecting, sorting and filtering ----------------------------------------

# Select only the `Year`, `Mean` and `Feature` columns and store this as a new
# tibble called `dewall_simple`:


# Sort this new tibble by `Year`:


# Filter the tibble to show only data from 2000 or later:



# Pivot to wider format ---------------------------------------------------

# Let's show the Mean values for each feature as separate columns using 
# `dewall_simple`

dewall_simple |> 
  pivot_wider(names_from = "Feature", values_from = "Mean")


# Store the output of this as another tibble `dewall_wide`






# Next week we'll work with this same dataset and see how to create nice 
# visualisations and plots of the data, which we can compar to the published
# plots....

# References --------------------------------------------------------------

# DeWall, C.N., Pond, R.S., Campbell, W.K., et al. (2011) Tuning in to 
# psychological change: Linguistic markers of psychological traits and 
# emotions over time in popular U.S. song lyrics. Psychology of Aesthetics, 
# Creativity, and the Arts, 5 (3): 200–207. doi:10.1037/a0023195.


