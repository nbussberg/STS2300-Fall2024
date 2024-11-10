## Notes 10 - Confidence Intervals for a Single Value

library(ggplot2)
library(dplyr)
library(infer)
library(palmerpenguins)


## Constructing confidence intervals for p

# Using a bootstrap distribution

house_of_reps <- read.csv("https://raw.githubusercontent.com/nbussberg/STS2300-Fall2024/refs/heads/main/Data/house_of_reps.csv")

house_of_reps <- house_of_reps %>%
  mutate(party = ifelse(party=="Democratic", "Democratic", "Not Democratic"))
table(house_of_reps$party)

set.seed(82720)
HOR_samp <- sample_n(house_of_reps, size = 30)
table(HOR_samp$party)

HOR_boot <- HOR_samp %>%
  specify(party ~ NULL, success = "Democratic") %>%
  generate(reps = 1000, type = "bootstrap") %>%
  calculate(stat = "prop")

visualize(HOR_boot)

# Practice: Calculate 90% CI using SE and percentile methods

# SE Method
HOR_phat <- mean(HOR_samp$party=="Democratic")

HOR_se <- HOR_boot %>%
  get_ci(level = 0.90, type = "se", point_estimate = HOR_phat)
HOR_se

# Percentile Method
HOR_perc <- HOR_boot %>%
  get_ci(level = 0.90, type = "percentile")
HOR_perc

# Theory-based Method
prop.test(x = 17, n = 30, conf.level = 0.90)



## Confidence intervals for µ

bill_xbar <- mean(penguins$bill_length_mm, na.rm = TRUE)
bill_xbar

set.seed(4392)
bill_boot <- penguins %>%
  specify(formula = bill_length_mm ~ NULL) %>%
  generate(reps = 1000, type = "bootstrap") %>%
  calculate(stat = "mean")

visualize(bill_boot)

# Practice: calculate 95% CI using SE method or percentile method

# SE method
penguin_se <- bill_boot %>%
  get_ci(level = 0.95, type = "se", point_estimate = bill_xbar)
penguin_se

# Percentile
penguin_perc <- bill_boot %>%
  get_ci(level = 0.95, type = "percentile")
penguin_perc


# Theory-based CI method
penguin_theory <- t.test(penguins$bill_length_mm,
                         conf.level = 0.95)
penguin_theory


