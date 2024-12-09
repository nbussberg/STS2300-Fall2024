## Notes 15 - Other Hypothesis Tests (Chi-squared & ANOVA)

library(ggplot2)
library(infer)
library(dplyr)

 
### Chi-squared Hypothesis Tests

## Step 2 - Gathering and summarizing data

# Load/create data
college <- data.frame(worthit = factor(c(rep("def_yes", 263), rep("prob_yes", 197),
                                         rep("prob_no", 90), rep("def_no", 47),
                                         rep("def_yes", 527), rep("prob_yes", 331),
                                         rep("prob_no", 88), rep("def_no", 29)),
                                       levels = c("def_yes", "prob_yes",
                                                  "prob_no", "def_no")),
                      firstgen = c(rep("yes", 263 + 197 + 90 + 47),
                                   rep("no", 527 + 331 + 88 + 29)))

# Contingency table
table(college$worthit, college$firstgen)

# Make a graph to visualize the data
ggplot(data = college, aes(x = worthit, fill = firstgen)) + 
  geom_bar(position = "fill")

# Calculate Chi-squared statistic
college_Chisq <- college %>%
  specify(worthit ~ firstgen) %>%
  calculate(stat = "Chisq")


## Step 3 - create null distribution and calculate p-value
set.seed(4532)
college_null_dist <- college %>%
  specify(formula = worthit ~ firstgen) %>%
  hypothesize(null = "independence") %>%
  generate(reps = 1000, type = "permute") %>%
  calculate(stat = "Chisq")

# graph null distribution with p-value
visualise(college_null_dist) +
  shade_p_value(obs_stat = college_Chisq, direction = "right")

# calculate p-value
get_p_value(college_null_dist, obs_stat = college_Chisq,
            direction = "right")



### ANOVA Tests

## Step 2 - Gathering and summarizing data

# Load/create data
cereal <- data.frame(design = c(rep("A", 5), rep("B", 5), 
                                rep("C", 5), rep("D", 5)),
                     sales = c(19, 17, 16, 19, 15, 12, 18, 15, 19, 11,
                               23, 20, 18, 17, 24, 27, 33, 22, 26, 20))

# Create a graph
ggplot(cereal, aes(x = design, y = sales)) +
  geom_boxplot() +
  geom_jitter(height = 0, width = 0.1, size = 3)

# Calculate F statistic
cerealF <- cereal %>%
  specify(sales ~ design) %>%
  calculate(stat= "F")

aov(sales ~ design, data = cereal) %>%
  summary()


## Step 3 - simulate null distribution and find p-value

# Create null distribution
set.seed(5643742)
cereal_null_dist <- cereal %>%
  specify(sales ~ design) %>%
  hypothesize(null = "independence") %>%
  generate(reps = 1000, type = "permute") %>%
  calculate(stat= "F")

# Visualize null distribution with p-value
visualize(cereal_null_dist) + 
  shade_p_value(obs_stat = cerealF, direction = "right")

# Calculate p-value
get_p_value(cereal_null_dist, 
            obs_stat = cerealF, 
            direction = "right")






