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


# Q3 Boxplot Comparison of Sequence Lengths for Even and Odd Starting Integers -