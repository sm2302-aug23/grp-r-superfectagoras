# Task 4

library(tidyverse)
library(ggplot2)
install.packages("ggrepel")
library(ggrepel)

# Q1 Scatterplot of Sequence Lengths vs. Starting Integers ---------------------

# Filtering the top 10 results from collatz_df
top10data <- collatz_df %>%
  filter(start %in% top10longest)

# Create complex plots from data in a data frame using ggplot
ggplot(
  data = collatz_df,
  mapping = aes(
    x = start,
    y = length
  )
) +
  # Create scatter plot and labelling
  geom_point() +
  labs(
    title = "Starting Integers vs Sequence Lengths",
    x = "Starting Integers",
    y = "Sequence Lengths"
  ) +
  geom_point(
    data = top10data, aes(x = start, y = length),
    col = "red", size = 3, shape = 15
  ) +
  # To avoid overlaps by repelling text labels
  geom_text_repel(
    data = top10data,
    aes(x = start, y = length, label = start),
    vjust = -0.5,
    hjust = 0.5,
    size = 3
  )

# Q2 Scatterplot of Highest Sequence Value vs. Starting Integers ---------------

# Identifying the top 10 starting integers (highest value reached)
top10highvalue <- backtracks_df %>%
  # Rearranging the data frame or starting integers in descending order
  arrange(desc(max_val_int)) %>%
  # Selecting top 10 starting integers
  head(10)
# Create scatter plot of highest value reach with labels
ggplot(
  data = backtracks_df,
  aes(x = start, y = max_val_int)
) +
  geom_point() +
  labs(
    title = "Highest Sequence Value vs Starting Integers",
    x = "Starting Integers",
    y = "Highest Sequence Value Reached"
  ) +
  geom_point(
    data = top10highvalue,
    aes(x = start, y = max_val_int),
    col = "purple4",
    size = 3,
    shape = 15
  ) +
  geom_text(
    data = top10highvalue,
    aes(x = start, y = max_val_int, label = start),
    vjust = -0.5, # Adjust vertical position of labels
    hjust = 0.5, # Adjust horizontal position of labels
    size = 3, # Size of the labels
    color = "orange2" # Text color for top 10 label
  )


# Q3 Boxplot Comparison of Sequence Lengths for Even and Odd Starting Integers -
