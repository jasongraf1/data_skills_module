#
# file: week_05-seminar_code.R
# author: Jason Grafmiller
# date: 2025-02-18
# description: 
# Code for cleaning text data with regular expressions
# We're going to continue with our consideration of song
# lyrics, but this time we'll get some of our own data
# that we can eventually compare to the DeWall et al. 
# study.

# Setup -----------------------------------------------

# Load our `here` and `tidyverse` packages:



# Next we install the `billboard` package (only do this
# once), then load it:

install.packages("billboard")
library(billboard)

# This package contains 4 datasets for the top 100 songs 
# for each year from 1960 to 2016.
# 
# - wiki_hot_100s: A dataset containing names and ranks,
# scraped from Wikipedia
# - lyrics: A dataset containing lyrics for most songs
# - spotify_track_data: A datset containing features of 
# all of the tracks
# - spotify_playlists: A dataset contaning 56 playlists 
# from Spotify that were used to get the songs for the 
# feature extraction 

# More info here: 
# https://cran.r-project.org/web/packages/billboard/index.html

# We'll focus on the first two for now:

lyrics <- billboard::lyrics |> 
  as_tibble()

ranks <- billboard::wiki_hot_100s |> 
  as_tibble()


# Inspect the data ------------------------------------

# Use `glimpse()` and call the data objects to see what
# is in them






# Merging dataframes with `*_join()` ------------------

# Note that the `lyrics` data does not contain the rank,
# while the `ranks` data lacks the lyrics... How can we
# combine these?

# In the tidyverse, the 'join' functions from the `dplyr` 
# package are used to combine two dataframes based on a 
# common column or columns (like a key or ID). Think of it 
# like merging two spreadsheets where they share some 
# common information.

# There are several functions, but we'll use `left_join()`,
# which keeps all rows from the first dataframe and adds 
# matching data from a second one. 

# The idea is that we try to merge the `lyrics` and `ranks`
# dataframes based on their shared columns.
# The result is the first dataframe `lyrics` with the 
# additional columns from `ranks` (here only `no`)

left_join(lyrics, ranks, by = c("title", "artist", "year"))

# store this output as a new dataframe

hot_songs <- left_join(lyrics, ranks, by = c("title", "artist", "year"))

# Let's export this to a file we could look at outside
# of R. 





# Cleaning text data ----------------------------------

# Look at just the lyrics with `hot_songs$lyrics` and 
# `head()`



## Replacing newline characters ("\n") ----------

# Let's replace these with a simple space " "




## Removing markup text----------

# Markup text is any information that is used to describe
# the data, e.g. things like "[Hook]", "[Chorus]", or
# "VERSE"

# I'f we look at a few more examples, we can see there are
# lots of different variations 
# (try `head(hot_songs$lyrics, n = 10)`)




# Here we can use Regex to identify and remove or replace
# these various options.






# Add another remove to get rid of everything inside
# the square brackets.




## Removing extra spaces ----------

# Let's replace multiple spaces with a single space, and
# trim any trailing space








## Fixing missing spaces ----------

# Consider the first part of the third song: 
# "Don't want your love any moreDon't want your kisses" 

# That "moreDon't" is a problem. It seems that in some 
# cases, a newline was not included (we didn't cause this
# problem), and so the last word of one line is right 
# next to the first word of the next line. 
 
# We clearly need to separate these words, but how?
# This is a MUCH trickier problem... 

# We can take advantage of the fact that we want to 
# split strings like "moreDon't" or "clownI've" where a
# lowercase letter is followed by an UPPERCASE one. 
# This is incidentally referred to as "camelCase"
# No English words naturally have this pattern so if we can 
# identify the boundaries, we can then replace with a 
# space.  

# I admit I had to go to google to find a solution. I 
# searched for "regex match camel case and split string"
# and found the following:
# https://stackoverflow.com/questions/7593969/regex-to-split-camelcase-or-titlecase-advanced

# Here is one solution we can split our "camelWords" in our lyrics.

head(hot_songs$lyrics, n = 10) |> 
  str_replace_all("\n", " ") |> 
  str_remove_all("(CHORUS|VERSE \\d)") |> 
  str_remove_all("\\[.*?\\]") |> 
  str_replace_all("\\s+", " ") |> 
  str_trim() |> 
  str_replace_all("(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])|(?<=[0-9])(?=[A-Z][a-z])|(?<=[a-zA-Z])(?=[0-9])", " ") 



# Export our results ----------------------------------

# Now let's do this to the entire dataset. Since we are 
# transforming an existing column, we'll use `mutate()`

# This may take a sec, as we're running this over 5700 
# rows:

hot_songs <- hot_songs |> 
  mutate(
    lyrics = lyrics |> 
      str_replace_all("\n", " ") |> 
      str_remove_all("(CHORUS|VERSE \\d)") |> 
      str_remove_all("\\[.*?\\]") |> 
      str_replace_all("\\s+", " ") |> 
      str_trim() |> 
      str_replace_all("(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])|(?<=[0-9])(?=[A-Z][a-z])|(?<=[a-zA-Z])(?=[0-9])", " ") 
  )

hot_songs

  
# Export the new dataframe.

write_csv(
  hot_songs, 
  here("data", "billboard_hot_songs_cleaned.csv")
)

# There is likely more cleaning to do, but this is a great
# start. We've accomplished a *huge* amount of data 
# cleaning in less than an hour!


