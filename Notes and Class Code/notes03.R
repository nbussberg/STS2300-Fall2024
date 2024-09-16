### Code for Notes 03

## Importing data

# see what your current working directory is
getwd()
  # make sure to set your working directory to wherever you stored your
    # datasets and script files

# After using the Import Dataset feature in the Environment window:
library(readr)
NC_Bridges <- read_csv("NC Bridges.csv")
View(NC_Bridges)


## The Pipe Operator

# Example 1 - no pipe operator; each step in separate lines of code
library(dplyr)

View(mtcars)

# Select only cars with automatic transmission
auto <- filter(mtcars, am==0)

# Create a new variable for weight in pounds
auto <- mutate(auto, wt_lbs = wt * 1000)

# Calculate the mean weight for each number of cylinders
mean_wt_by_cyl <- summarize(auto, 
                            mean_wt = mean(wt_lbs), 
                            .by = cyl)

# Arrange in order by number of cylinders
mean_wt_by_cyl <- arrange(mean_wt_by_cyl, cyl)

mean_wt_by_cyl


# Example 2 - put all of Example 1 into one line of code

mean_wt_by_cyl <- arrange(summarize(mutate(filter(mtcars,
                                                  am == 0), 
                                           wt_lbs = 1000*wt),
                                    mean_wt = mean(wt_lbs),
                                    .by = cyl),
                          cyl)
mean_wt_by_cyl

# Example 3 - use the pipe operator
mean_wt_by_cyl <- mtcars %>%
  filter(am == 0) %>%
  mutate(wt_lbs = wt * 1000) %>%
  summarize(mean_wt = mean(wt_lbs), .by = cyl) %>%
  arrange(cyl)

mean_wt_by_cyl


## The filter() function to select rows

# Practice 1 - subset that only has bridges in Alamance Co.
table(NC_Bridges$COUNTY)
alam_bridges <- filter(NC_Bridges, COUNTY=="ALAMANCE")
table(alam_bridges$COUNTY)


# Practice 2 - bridges that are structurally deficient 
  # and functionally obsolete

table(NC_Bridges$STRUCTURALLYDEFICIENT, 
      NC_Bridges$FUNCTIONALLYOBSOLETE)
questionable <- filter(NC_Bridges, 
                       STRUCTURALLYDEFICIENT=="SD" &
                         FUNCTIONALLYOBSOLETE=="FO")
table(questionable$STRUCTURALLYDEFICIENT)
table(questionable$FUNCTIONALLYOBSOLETE)
table(questionable$STRUCTURALLYDEFICIENT, 
      questionable$FUNCTIONALLYOBSOLETE)


# Practice 3 - Alamance bridges that are either SD or FO

alam_question <- filter(NC_Bridges, COUNTY=="ALAMANCE" &
                        (STRUCTURALLYDEFICIENT=="SD" |
                          FUNCTIONALLYOBSOLETE=="FO"))
table(alam_question$STRUCTURALLYDEFICIENT, 
      alam_question$FUNCTIONALLYOBSOLETE)

# alternative 1

alam_question1 <- filter(alam_bridges, 
                        STRUCTURALLYDEFICIENT=="SD" |
                          FUNCTIONALLYOBSOLETE=="FO")

# alternative 2 

alam_question2 <- NC_Bridges %>%
  filter(COUNTY=="ALAMANCE") %>%
  filter(STRUCTURALLYDEFICIENT=="SD" |
           FUNCTIONALLYOBSOLETE=="FO")


## The select() function

# Practice - update alam_bridges to only include:
  # ROUTE, ACROSS, YEARBUILT, SR

alam_bridges <- select(alam_bridges, 
                       ROUTE, ACROSS, YEARBUILT, SR)
str(alam_bridges)


## The mutate() function

mycars <- mutate(mtcars, wt_lbs = wt * 1000)

mycars %>%
  select(wt, wt_lbs) %>%
  head(n = 5)

# Practice problem - create new AGE variable

bridge_ages <- mutate(NC_Bridges, AGE = 2024 - YEARBUILT)
bridge_ages %>%
  select(AGE, YEARBUILT) %>%
  tail(n = 10)


## Long vs. Wide Data

birds_wide <- read.csv("https://raw.githubusercontent.com/nbussberg/STS2300-Fall2024/main/Data/nestbox_lands_wide.csv")

birds_long <- read.csv("https://raw.githubusercontent.com/nbussberg/STS2300-Fall2024/main/Data/nestbox_lands_long.csv")

library(tidyr)

# Convert wide format to long format
birds_wide %>%
  pivot_longer(cols = -Species, names_to = "Year",
               values_to = "Fledged") %>%
  head(n = 5)

# Convert long format to wide format
birds_long %>%
  pivot_wider(names_from = Year, 
              values_from = Fledged)









