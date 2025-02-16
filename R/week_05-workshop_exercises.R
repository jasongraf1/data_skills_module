# ------------------------------------------------------
# file: week_05-workshop_exercises.R
# author: Jason Grafmiller
# date: 2025-02-16
# description:
# 
# ------------------------------------------------------

# Let's load our packages.



# Let's load in our baby names data too.



# Now we will create a data frame of only the unique 
# names with `distinct()`


# Basic string manipulation ----------------------------


## Measure the length of strings -----------------------

# Let's measure the length of each name with `str_length()` 
# and plot a histogram of the results



## Filter with `str_detect()` ---------------------

# Let's filter our original data frame to get only names
# beginning with "J"


# Let's filter our original data frame to get only names
# beginning with "J"


## splitting strings ---------------------

# assign the string "the quick brown fox jumped over the lazy dog"
# to `sent` 


# now use `str_split(sent, " ")`


# What do you see?


# Next, enter the code below:
first_lines <- c(
  "call me Ishmael. ", 
  " it is a truth universally acknowledged, that a single man in possession of a good fortune, must be in want of a wife.", 
  " we were somewhere around Barstow on the edge of the desert when the drugs began to take hold. ", 
  "in a hole in the ground there lived a hobbit.", 
  "it was a bright cold day in April, and the clocks were striking thirteen."
)

# Now enter `str_split(first_lines, " ")` 


## trimming empty space ----------------

# Notice that some of the strings in `first_lines` had empty
# whitespace at the beginning and/or ends. This resulted in
# empty words when we split the data.
# We can trim empty space with `str_trim()`

# Compare closely:
first_lines

str_trim(first_lines)


## Changing case ---------------------

# There are several functions form changing the case of a string, 
# which can be useful at times.
# - str_to_lower()
# - str_to_upper()
# - str_to_title(): first letter of every content word is upper,
# all else are lower
# - str_to_sentence: first letter of string is upper, all else 
# are lower

# Let's fix the first lines to trim whitespace and set to 
# sentence case


# Notice anything wrong with this result? (Hint: look at proper
# names). 


# Regular expressions ------------------------------


# Start simple with our `baby_names` data.

# Let's filter our original data frame to get only names
# with "G", then do it for only names with "g". 




# Is this very efficient? How could we search for names with
# either "G" or "g" in one go?



# Try running the same code but with this patter: `[gG]`.
# This tells it to look for single characters that match any 
# of the individual characters inside the `[ ]`, i.e. "g" 
# or "G".


# Antyhing can go in the `[ ]`. The `[ ]` denotes a set or 
# range of characters, e.g. `[abc]` matches any of 
# "a", "b", or "c". Some preset ranges include:
# | `[a-z]` | Matches any lowercase alphabet character 
# | `[A-Z]` | Matches any uppercase alphabet character 
# | `[0-9]` | Matches any digit from 0-9 character 


# Now let's look for names matching "Jason", "Joseph", 
# "Joshua", "Jasmine", etc. 
# So we want names with "J" followed by "a" or "o", 
# followed by "s".






## Anchors -------------------

# The special characters `^` and `$` match the beginning 
# and end of a string

# So if we can e.g. filter baby names by whether they *end*
# in a vowel ("a", "e", "i", "o", "u"), by adding `$` after
# `[aeiou]` 





## Replacing --------------------

# Replacing works just as before. Let's replace any vowel
# in a name with "@". We'll use the `mutate()` tidy 
# function for this.

# Unleashing the power of Regex ----------------------------

## Special Regex Characters --------------------------------

# There are *many* special characters that are used in regex. For 
# example, the `.` matches any single character, including digits, 
# spaces, and punctuation. This is useful for when we're not sure what 
# could be there.

# Try filtering by `str_detect(name, "T.[aeiou]")`





# Some more very useful characters:
# | `\\w` | Matches any word character 
# | `\\d` | Matches any digit character
# | `\\s` | Matches any space character
# | `\\W` | Matches any NON-word character 
# | `\\D` | Matches any NON-digit character
# | `\\S` | Matches any NON-space character





## Quantifiers -------------------------

# Quantifiers in regular expressions specify how many times a 
# particular pattern should match. They allow you to control the 
# number of occurrences of characters, groups, or other patterns. 

# | `*` | Matches 0 or more of the preceding item
# | `+` | Matches 1 or more of the preceding item
# | `?` | Matches 0 or 1 of the preceding item 
# | `{n}` | Matches the preceding item exactly n times
# | `{n,}` | Matches the preceding item n or more times
# | `{n,m}` | Matches the preceding item at least n times but no 
# more than m times 

# Let's looks for names with double "n"s using `"n{2}"` as our
# search pattern.




# This can be used in combination with other variables. So suppose
# we have some inconsistencies in case like so:
bad_names <- c("Aaron", "AAron", "JASON", "JAson", "GRAce", "Grace")

# We can find names with repeated uppercase letters. 
# `"[A-Z]"` matches an uppercase letter, and `{2,}` looks for 2 
# or more of those.


## Groups ----------------------------

# The `[ ]` operator works with single characters, but we can search 
# for entire groups of characters with `( )`. We can include options 
# by separating the groups with `|`.

# For the heck of it, let's look at all names beginning with either 
# "Mar" or "So", and names *ending* with "na". 






# Groups can be used to **capture** matches, which can then be 
# referred to in the same regex. 
# Suppose we want to look at names that have double letters of 
# any kind. We don't know exactly which letters may be doubled, 
# so we want to be as general as possible. 

# To do this we might use a regex like so:

baby_names |> 
  filter(str_detect(name, "(\\w)\\1")) 

# Let's break this down. There are two main parts of the above regex:

# - The `\\w` matches any word character. The parentheses `( )` around it create a **capture group**, storing the matched character.
# - The `\\1` is a **backreference** to the first (only in this case) capture group. It matches the same character that was captured in `(\\w)`.

