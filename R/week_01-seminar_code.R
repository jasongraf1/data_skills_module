# ----------------------------------------------------------------------------
# file: week_01-seminar_code.R
# author: Jason Grafmiller
# date: 2025-01-20
# Goals of the session:
# 1. build confidence in debugging by demonstrating common errors and 
# strategies to investigate and resolve them.
# 2. see some useful options for working in RStudio
# ----------------------------------------------------------------------------

# Start with a FRESH workspace. Either close and restart RStudio, or type 
# Ctrl/Cmd+Shift+F10 to restart your R session


# Exercise 1: What to do when things don't work ---------------------------

# When your code breaks, which it will, DON'T PANIC!

# Mistakes are normal and a crucial part of learning! Key steps to debugging:
# - read the error message carefully.
# - check your code line by line.
# - use `help()` or search online for clarification.
# - isolate problematic sections of the code.


# a) Syntax errors (this will happen ALL the time!)
 
# Why does this code not work?
my_variable <- 10
my_varaible

# Why does this code not work?
print("Hello, world!"


# Why does this code not work?
sumary(mtcars)
      

# b) "Object Not Found" 

# Why does this code not work?
print(my_name)


# c) Incorrect Data Type

# Why does this code not work?
sum("Hello, World!")

# How do you find the type or class of an object in R?


# d) Package Not Loaded

# Why does this code not work?
ggplot(data = mtcars, aes(x = mpg, y = wt)) + 
  geom_point()


# e) Debugging practice. 

# Find the error in the code below and fix it
my_data <- c(1, 2, 3, 4, 5)
sum_data <- sum(mydata)
print(sum_data)

# Find the error in the code below and fix it
my_dataframe <- data.frame(
  names = c("Alice", "Bob", "Carla", "Dennis"),
  ages = c(25, 30, 35, 50)
)
mean(my_dataframe$Ages)

# f) Using the `help()` documentation.

# Find out what the following functions do:
# `round`, `tolower`, `paste`, `write.csv`



# Exercise 2: Working in RStudio ------------------------------------------

# Learning to customize RStudio can improve productivity and reduce you 
# frustration as you're learning to do stuff. Let's explore some 
# beginner-friendly settings and features.
  

# a) Change appearance and layout
 
# A comfortable theme reduces eye strain and makes it easier to spot errors. 

# Do the following:

# - Go to "Tools" > "Global Options" > "Appearance"
# - Choose a font size and theme (light or dark mode) that is easy on your eyes
# - Click "Apply"



# Next let's arrange our panels in a useful way. For example, I prefer to have 
# my scripts (Source pane) on one side, and the actual R console and 
# environment on the other. This way I can see more of my scripts (which is 
# where I do most of the work), since modern screens are much wider than they are
# tall.

# Do the following:

# - Go to "Tools" > "Global Options" > "Pane Layout"
# - Explore different options for organizing your Source, Console, and Environment panes
# - Click "Apply"


# Finally, do the following:

# - Go to "Tools" > "Global Options" > "General"
# - UNcheck the box that says "Restore .RData ito workspace at startup"
# - Set "Save workspace to .RData on exit" to "Never"
# - Click "Apply"



# b) Use the "Environment" tab to explore the objects you've created in 
# Exercise 1: `my_variable` and `my_dataframe`


# c) Keyboard shortcuts for efficiency

# Keyboard shortcuts save time and make coding smoother. Try to keep your 
# hands on your keyboard as much as possible by using these. You will hopefully
# become very proficient with some of these as you go, and you'll find that it
# is SO much faster to use shortcuts than pointing and clicking things!

# You may know some common ones used by many applications already, e.g. 
# (Mac users replace Ctrl with Cmd)
# Ctrl + C = copy
# Ctrl + V = paste
# Ctrl + X = cut
# Ctrl + Z = undo last edit

# Ctrl + S = save current file
# Ctrl + O = open file


# We've already seen some RStudio specific ones too:

# Ctrl + Enter = executes code in the Source pane
# Ctrl + Shift + F10 = restart R session
# Ctrl + Shift + N = open new R script

# Type the following commands to see what they do (don't type the quotes, I've
# just added them to note that these are keys to type):

# Ctrl + Shift + C
# Alt + '-'
# Ctrl + Shift + M
# Alt + Shift + K
# Ctrl + '-'
# Ctrl + '+'


# d) Installing and Managing Packages

# Use the "Packages" Tab to search for the `stats` package. 

# Click "Install" to open the install packages window. Type "ggplot2" and click
# "Install" (only if you are on your own computer)













