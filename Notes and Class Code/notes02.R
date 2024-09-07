# Notes 02 Code

View(mtcars)

# Look at structure of data and determine variable types
str(mtcars)
is.numeric(mtcars$am)

# Quantitative Data Summaries

# mean miles per gallon
mean(mtcars$mpg)

# minimum horsepower
min(mtcars$hp)

# 80th percentile for weight
quantile(mtcars$wt, probs = 0.8)

# standard deviation for displacement
sd(mtcars$disp)

# get quick numerical summary
summary(mtcars$mpg)

# Use dplyr for a summary (need to install the dplyr package)
library(dplyr)
summarize(mtcars, 
          min_mpg = min(mpg),
          max_mpg = max(mpg),
          avg_hp = mean(hp),
          sd_hp = sd(hp))

car_sum <- summarize(mtcars, 
          min_mpg = min(mpg),
          max_mpg = max(mpg),
          avg_hp = mean(hp),
          sd_hp = sd(hp))

car_sum$avg_hp


# Summarizing Categorical Data
  # need to install the moderndive package
library(moderndive)
?MA_schools
str(MA_schools)

school.tbl <- table(MA_schools$size)
school.prop <- prop.table(table(MA_schools$size))


# Summaries by Group

summarize(MA_schools,
          count = n(),
          .by = size)

# Practice question 1
summarize(mtcars, 
          .by = am,
          min_mpg = min(mpg),
          max_mpg = max(mpg),
          avg_hp = mean(hp),
          sd_hp = sd(hp))

summarize(mtcars, 
          count = n(),
          .by = c(am, cyl),
          min_mpg = min(mpg),
          max_mpg = max(mpg),
          avg_hp = mean(hp),
          sd_hp = sd(hp))





