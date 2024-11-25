## Notes 13 - Hypothesis Testing for a Single Value

library(ggplot2)
library(infer)
library(dplyr)


### Hypothesis Tests for p

## Step 2 - Gathering data

mice <- read.csv("https://raw.githubusercontent.com/nbussberg/STS2300-Fall2024/refs/heads/main/Data/mice.csv")

# Practice: Find the sample proportion of mice that have drug resistant bacteria

samp_p <- mice %>%
  specify(formula = drugresist ~ NULL, success = "Yes") %>%
  calculate(stat = "prop")
samp_p

# or

samp_pV2 <- mean(mice$drugresist == "Yes")
samp_pV2

## Step 3 - simulating a null distribution & finding p-values

# Practice: Generate null distribution that shades the p-value

set.seed(37)
mice_null <- mice %>%
  specify(formula = drugresist ~ NULL, success = "Yes") %>%
  hypothesize(null = "point", p = 0.25) %>%
  generate(reps = 1000, type = "draw") %>%
  calculate(stat = "prop")

visualize(mice_null) + 
  shade_p_value(samp_p, direction = "left")

# calculate p-value
mice_pval <- mice_null %>%
  get_pvalue(obs_stat = samp_p, direction = "left")
mice_pval


### Hypothesis tests for µ

## Step 2

# Create the data
bodytemps <- data.frame(temperature = c(97.39, 97.45, 97.96, 97.35, 96.74, 99.66,
                                        98.21, 99.02, 96.78, 97.70, 96.90, 97.29,
                                        97.99, 97.73, 98.18, 97.78, 97.17, 97.34,
                                        97.56, 98.13, 97.77, 97.07, 97.13, 96.74, 
                                        99.10, 96.76, 96.19, 97.84, 96.80, 98.09))

# Graph the sample data 

ggplot(bodytemps) + 
  geom_histogram(aes(x = temperature))

# Calculate the sample mean

bodytemps_samp_mean <- mean(bodytemps$temperature)
bodytemps_samp_mean

# or 

bodytemps_mean <- bodytemps %>%
  specify(formula = temperature ~ NULL) %>%
  calculate(stat = "mean")
bodytemps_mean


## Step 3 - simulate null distribution and calculate p-value

# simulate a null distribution
set.seed(2345678)
bodytemp_nulldist <- bodytemps %>%
  specify(formula = temperature ~ NULL) %>%
  hypothesize(null = "point", mu = 98.6) %>%
  generate(reps = 1000, type = "bootstrap") %>%
  calculate(stat = "mean")

# graphed the null distribution and shaded the p-value
visualize(bodytemp_nulldist) + 
  shade_p_value(obs_stat = bodytemps_samp_mean, direction = "both")

# calculate the p-value
bodytemp_pval <- bodytemp_nulldist %>%
  get_p_value(obs_stat = bodytemps_samp_mean, direction = "both")

bodytemp_pval


### Theory-based tests

## prop.test() for p

table(mice$drugresist)

prop.test(x = 95, n = 416, p = 0.25, alternative = "less")


## t.test() for µ

t.test(x = bodytemps$temperature, mu = 98.6, alternative = "two.sided")




