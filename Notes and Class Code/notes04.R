### Code for Notes 04

# Load ggplot2 package
library(ggplot2)

## The ggplot2 package intro
ggplot(data = mtcars) + 
  geom_point(aes(x = wt, y = mpg))

# Practice Question 2 - scatter plot for hp vs. mpg
ggplot(data = mtcars) + 
  geom_point(aes(x = hp, y = mpg))

# Practice Question 3 - bar graph for transmission (am)
ggplot(data = mtcars) + 
  geom_bar(aes(am))


## Scatterplots

# Practice problem - change color, size, shape, and transparency

ggplot(data = mtcars) + 
  geom_point(aes(x = hp, y = mpg),
             color = "purple",
             size = 5, 
             shape = "triangle",
             alpha = 0.5)
  # note: shape = 17 will produce the same thing


## Histograms

# Practice problem - write code to match the graph
ggplot(data = airquality) + 
  geom_histogram(aes(x = Temp), 
                 binwidth = 5, boundary = 55,
                 fill = "orange", 
                 color = "white")
  
# alternative to above: use bins= instead of binwidth=
ggplot(data = airquality) + 
  geom_histogram(aes(x = Temp), 
                 bins = 9, boundary = 55,
                 fill = "orange", 
                 color = "white")


## Boxplots

# Practice problem - reproduce the boxplot in the notes
ggplot(data = ToothGrowth) +
  geom_boxplot(aes(x=supp, y=len), 
               fill = "black", 
               color = "pink")


## Bar Graphs

# Practice problem - replicate the graph in the notes

View(diamonds)
  # data looks like it's in raw format

ggplot(data = diamonds) + 
  geom_bar(aes(x = cut, fill = cut), 
           color = "black")


## Adding variables to graphs
ggplot(mtcars) + 
  geom_point(aes(x = wt, y = mpg,
                 shape = as.factor(am),
                 color = drat))

ggplot(mtcars) + 
  geom_point(aes(x = wt, y = mpg,
                 color = as.factor(am),
                 shape = as.factor(am),
                 alpha = drat))


