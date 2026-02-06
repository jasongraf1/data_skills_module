# -------------------------------------------------------
# file: week_01-seminar_code.R
# author: Jason Grafmiller
# date: 2026-01-20
# Goals of the session:
# 1. practice working with R
# 2. build confidence in debugging by demonstrating common 
# errors and strategies to investigate and resolve them.
# 3. see some useful options for working in RStudio
# --------------------------------------------------------

# Start with a FRESH workspace. Either close and restart 
# RStudio, or type Ctrl/Cmd+Shift+F10 to restart your R 
# session

# Instructions: Use R as a calculator to solve these problems.
 
# Just enter your code below and type Ctrl/Cmd+Enter

# a) What is 25 + 17?
# 

# b) Subtract 56 from 89


# c) Multiply 8 by 12

# d) Divide 100 by 4

# e) Multiply pi by 2


# Exercise 2: Assigning variables -------------------------

# Instructions: Create variables to store data and use them in calculations.

# a) Assign the value 42 to a variable called `x`.


# b) Create another variable `y` and assign it the value 18.


# c) Add `x` and `y` together and store the result in a variable `z`.


# Print the value of `z` to check your result.


# d) Create a variable `my_name` and assign it the value of your name as 
# a string (use quotes " " or ' ')



# Exercise 3: Basic Functions ----------------------------

# Instructions: Use built-in R functions to perform tasks.

# a) Find the square root of 144 with the `sqrt()` function


# b) Calculate the sum of 3, 5, and 9 using the `sum()` function.


# c) Find the minimum value in the numbers 7, 15, 3, 9 with `min()`.




# Exercise 4: Working with Vectors ------------------------

# Instructions: Create and manipulate vectors. 
# A vector is a sequence of elements of the same type

# a) Create a vector named `numbers` containing the values 2, 4, 6, 8, 10.
numbers <- c(2,4,6,8,10)

# b) Find the mean (average) of the values in `numbers`.


# c) Add 5 to each element of the `numbers` vector.


# d) Find the length of `numbers` with `length()`


# Exercise 5: Logical Comparisons -------------------------

# Instructions: Perform logical comparisons and understand TRUE/FALSE outputs.

# a) Check if 15 is greater than 10


# b) Check if 7 is equal to 9


# c) Check if `x` is not equal to `y`



# d) Check if the length of `numbers` is greater than or equal to 5



# Exercise 6: Data Frames -------------------------------------------------

# Instructions: Create and manipulate a data frame.

# a) Create a data frame named `students` with the following data:
# Name: "Buster", "Charlie", "Harold"
# Age: 22, 25, 23
# Score: 88, 76, 90
students <- data.frame(
  Name = c("Buster", "Charlie", "Harold"),
  Age = c(22, 25, 23),
  Score = c(88, 76, 90)
)


# b) Display the structure of the `students` data frame using the `str()` function.


# c) Show the `Score` column from the data frame using the syntax: df$column


# c) Calculate the average score of all students using `mean()`


# d) Round the output of `mean()` to 2 decimal places with `round(..., digits = 2)`





# Exercise 7: What to do when things don't work -----------

# When your code breaks, which it will, DON'T PANIC!

# Mistakes are normal and a crucial part of learning! 
# Key steps to debugging:
# - read the error message carefully
# - check your code line by line
# - use `help()` or search online for clarification
# - isolate problematic sections of the code
# - search online if all else fails. 

# Here is a detailed list of common errors and solutions: 
# <https://statsandr.com/blog/top-10-errors-in-r/>


## a) Syntax errors and typos (this will happen ALL the time!) ------------
 
# Why does this code not work?
my_variable <- 10
my_varaible


# Why does this code not work?
print("Hello, world!"))


# Why does this code not work?
sum(2 3)


# What happens with this code?
print(("Hello, world!")
      
      

## b) "Object not found" -----------------------------

# Why does this code not work?
print(my_name)


## c) Incorrect data type -----------------------------

# Why does this code not work?
sum("Hello, World!")

# How do you find the type or class of an object in R?


## d) Could not find function -----------------------------

# Why does this code not work?
my_function("Jason")

# Why does this code not work?
ggplot(data = mtcars, aes(x = mpg, y = wt)) + 
  geom_point()



## e) Debugging practice -----------------------------

# Find the error in the code below and fix it
my_data <- c(1, 2, 3, 4, 5)
sum_data <- sum(mydata)
print(sum_data)


# Find the error in the code below and fix it
my_dataframe <- data.frame(
  names = c("Alice", "Bob", "Carla", "Dennis")
  ages = c(25, 30, 35, 50)
)


# Find the error in the code below and fix it
mean(my_dataframe$Ages)



## f) Using the `help()` documentation -------------------

# Find out what the following functions do:
# `round`, `tolower`, `paste`, `write.csv`



# Exercise 8: Working in RStudio --------------------------

# Learning to customize RStudio can improve productivity 
# and reduce you frustration as you're learning to do 
# stuff. Let's explore some beginner-friendly settings 
# and features.
  

## a) Change appearance and layout -----------------------
 
# A comfortable theme reduces eye strain and makes it 
# easier to spot errors. 

# Do the following:

# - Go to "Tools" > "Global Options" > "Appearance"
# - Choose a font size and theme (light or dark mode) that is easy on your eyes
# - Click "Apply"


# Next let's arrange our panels in a useful way. For 
# example, I prefer to have my scripts (Source pane) on 
# one side, and the actual R console and environment on the
# other. This way I can see more of my scripts (which is 
# where I do most of the work), since modern screens are 
# much wider than they are tall.

# Do the following:

# - Go to "Tools" > "Global Options" > "Pane Layout"
# - Explore different options for organizing your Source, 
# Console, and Environment panes
# - Click "Apply"


# Finally, do the following:

# - Go to "Tools" > "Global Options" > "General"
# - UNcheck the box that says "Restore .RData to workspace 
# at startup"
# - Set "Save workspace to .RData on exit" to "Never"
# - Click "Apply"



## b) Environments -----------------------------
 
# Use the "Environment" tab to explore the objects you've 
# created in Exercise 1:
# `my_variable` and `my_dataframe`


## c) Keyboard shortcuts for efficiency ------------------

# Keyboard shortcuts save time and make coding smoother. 
# Try to keep your hands on your keyboard as much as 
# possible by using these. You will hopefully become very 
# proficient with some of these as you go, and you'll find 
# that it is SO much faster to use shortcuts than pointing 
# and clicking things!

# You may know some common ones used by many applications 
# already, e.g. 
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

# Type the following commands to see what they do (don't 
# type the quotes, I've just added them to note that these 
# are keys to type):

# Ctrl + Shift + C
# Alt + '-'
# Ctrl + Shift + M
# Alt + Shift + K
# Ctrl + '-'
# Ctrl + '+'


## d) Installing and managing packages --------------------

# Use the "Packages" Tab to search for the `stats` package. 

# Click "Install" to open the install packages window. 
# Type "ggplot2" and click "Install" 

# Alternatively, go to the top menu "Tools" > "Install Packages..."

# Once you've installed ggplot2 enter the following:
ggplot(data = mtcars, aes(x = wt, y = mpg)) +
  geom_point()

# What error do you see?

# Now add a line containing `library(ggplot2)` above the 
# previous code and run all 3 lines. 






