# ----------------------------------------------------------------------------
# file: week_01-workshop_exercises.R
# author: Jason Grafmiller
# date: 2025-01-20
# description:
# Exercises for Week 1 workshop. Answers will be posted after class
# ----------------------------------------------------------------------------


# Exercise 1: Simple Calculations -----------------------------------------

# Instructions: Use R as a calculator to solve these problems.
# Just enter your code below and type Ctrl/Cmd+Enter

# a) What is 25 + 17?
25 + 17

# b) Subtract 56 from 89
89 - 56

# c) Multiply 8 by 12
8 * 12

# d) Divide 100 by 4
100/4

# e) Multiply pi by 2
pi*2
pi


# Exercise 2: Assigning variables -----------------------------------------

# Instructions: Create variables to store data and use them in calculations.

# a) Assign the value 42 to a variable called `x`.
x <- 42

# b) Create another variable `y` and assign it the value 18.
y <- 18

# c) Add `x` and `y` together and store the result in a variable `z`.
z <- x + y

# Print the value of `z` to check your result.
print(z)

# d) Create a variable `my_name` and assign it the value of your name as 
# a string (use quotes " " or ' ')
my_name <- "Jason"


# Exercise 3: Basic Functions ---------------------------------------------

# Instructions: Use built-in R functions to perform tasks.

# a) Find the square root of 144 with the `sqrt()` function
sqrt(144)

# b) Calculate the sum of 3, 5, and 9 using the `sum()` function.
sum(3,5,9)

# c) Find the minimum value in the numbers 7, 15, 3, 9 with `min()`.
min(7,15,3,9)



# Exercise 4: Working with Vectors ----------------------------------------

# Instructions: Create and manipulate vectors.

# a) Create a vector named `numbers` containing the values 2, 4, 6, 8, 10.
numbers <- c(2,4,6,8,10)

# b) Find the mean (average) of the values in `numbers`.
mean(numbers)

# c) Add 5 to each element of the `numbers` vector.
numbers + 5 

# d) Find the length of `numbers` with `length()`
length(numbers)

# Exercise 5: Logical Comparisons -----------------------------------------

# Instructions: Perform logical comparisons and understand TRUE/FALSE outputs.

# a) Check if 15 is greater than 10
15 > 10

# b) Check if 7 is equal to 9
7 == 9

# c) Check if `x` is not equal to `y`
x == y
x != y # not equal

# d) Check if the length of `numbers` is greater than or equal to 5
length(numbers) >= 5

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
str(students)

# c) Show the `Score` column from the data frame
students$Score

# c) Calculate the average score of all students using `mean()`
mean(students$Score)

# d) Round the output of `mean()` to 2 decimal places with `round(..., digits = 2)`
round(mean(students$Score), digits = 2)

sqrt(round(mean(students$Score), digits = 2))


