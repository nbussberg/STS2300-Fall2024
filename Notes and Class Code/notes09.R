## Notes 09 - Using infer for Confidence Intervals

library(ggplot2)
library(dplyr)
library(infer)


## HoR Example

house_of_reps <- read.csv("https://raw.githubusercontent.com/nbussberg/STS2300-Fall2024/refs/heads/main/Data/house_of_reps.csv")

house_of_reps <- house_of_reps %>%
  mutate(party = ifelse(party=="Democratic", "Democratic", "Not Democratic"))
table(house_of_reps$party)

set.seed(82720)
mysamp <- sample_n(house_of_reps, size = 30)
table(mysamp$party)

bootstrap_dist <- mysamp %>%
  specify(party ~ NULL, success = "Democratic") %>%
  generate(reps = 1000, type = "bootstrap") %>%
  calculate(stat = "prop")

visualize(bootstrap_dist)


## Confidence Interval Approaches

# Theory-based approach
phat <- mean(mysamp$party == "Democratic")
phat

ci_theory <- c(phat - 1.645 * sqrt(phat * (1 - phat) / 30),
               phat + 1.645 * sqrt(phat * (1 - phat) / 30))
ci_theory


# Standard Error Method
boot_sd <- sd(bootstrap_dist$stat)
boot_sd

c(phat - 1.645 * boot_sd,
  phat + 1.645 * boot_sd)


ci_se <- bootstrap_dist %>%
  get_ci(level = 0.90, type = "se", point_estimate = phat)
ci_se


# Percentile Method
ci_perc <- bootstrap_dist %>%
  get_ci(level = 0.90, type = "percentile")
ci_perc


## Graphing confidence intervals
library(patchwork)

se <- visualize(bootstrap_dist) +
  shade_ci(ci_se)

perc <- visualize(bootstrap_dist) +
  shade_ci(ci_perc, fill="violet", color="lightpink")

se + perc

