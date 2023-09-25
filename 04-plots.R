# Task 4

library(tidyverse)
library(ggplot2)
install.packages("ggrepel")
library(ggrepel)

# Q1 Scatterplot of Sequence Lengths vs. Starting Integers --------------------

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
  ) +
  theme_classic() 

# Q2 Scatter plot of Highest Sequence Value vs. Starting Integers -------------

# Identifying the top 10 starting integers (highest value reached)
top10highvalue <- collatz_df %>%
  # rearranging the data frame or starting integers in descending manners
  arrange(desc(max_val)) %>%
  # selecting top 10 starting integers from above code
  top_n(10)

# Create the scatterplot for highest value vs. starting integers
ggplot(data = collatz_df, aes(x = start, y = max_val)) +
  geom_point() + # Scatterplot for all integers
  labs(
    title = "Highest Sequence Value vs. Starting Integers",
    x = "Starting Integers",
    y = "Highest Sequence Value"
  ) +
  geom_point(
    data = top10highvalue,
    aes(x = start, y = max_val),
    col = "purple4", # Color for the top 10 starting integers
    size = 2, # Size of the points for the top 10
    shape = 15 # Shape of the points for the top 10 (square)
  ) +
  geom_text_repel(
    data = top10highvalue,
    aes(x = start, y = max_val, label = start),
    vjust = -0.5, # Adjust vertical position of labels
    hjust = 0.5, # Adjust horizontal position of labels
    size = 3, # Size of the labels
    col = "orange2" # Color for labeling top 10 value points
  ) +
  scale_y_log10() + # Add logarithmic scale to the y-axis
  theme_classic()
  
# Q3 Comparing Sequence Lengths: Even vs. Odd Starting Integers ----------------

# Create a boxplot to compare the distributions
ggplot(data = collatz_df, aes(x = parity, y = length, fill = parity)) +
  geom_boxplot() +
  labs(
    title = "Sequence Lengths: Even vs Odd",
    x = "Parity (Even/Odd)",
    y = "Sequence Lengths"
  ) +
  theme_classic()