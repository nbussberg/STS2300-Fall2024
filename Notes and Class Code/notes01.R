1+1

2*7

mynumbers <- c(4, 8, 15, 16, 23, 42)
mynumbers2 <- mynumbers * 2

max(mynumbers)
max(mynumbers2)

# Q5
mynums <- c(2, 7, 11, 19, 22)
my_max <- max(mynums)
my_max
mynums

min(mynums)
mean(mynums)
median(mynums)


# Q6
Max(mynums)

# Q7
my numbers <- c(1, 2, 3)
# this won't work b/c we can't have spaces in the name



mywords <- c("frog", "pizza", "Elon U")
myNumsAndWords <- c("frog", 42)


# Data Frames
View(mtcars)
help(max)
?mtcars


# Exploring a Data Set

head(mtcars, n = 5)
head(mtcars, n = 10)
tail(mtcars, n = 10)

# We need to install 2 R packages: dplyr and skimr
  # We don't need to run the install command in a script file b/c 
  # we only need to install a package once. 
# install.packages("dplyr")
# install.packages("skimr")

# Load packages
library(dplyr)
library(skimr)

summary(mtcars)
View(mtcars)
glimpse(mtcars)
skim(mtcars)


# The $ Operator
mtcars$hp
summary(mtcars$hp)


# Practice Questions
# Print all car weights
help(mtcars)
mtcars$wt

# Find minimum miles per gallon
min(mtcars$mpg)
summary(mtcars$mpg)

# In Loblolly dataset, find oldest tree and shortest tree
help("Loblolly")
head(Loblolly)

max(Loblolly$age)
min(Loblolly$height)
View(Loblolly)

