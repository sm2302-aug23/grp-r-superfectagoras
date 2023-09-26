# Task 7

## Task 5 graph

## Explore and visualize the distribution of even and odd numbers
## For example, create a bar chart:
library(tidyverse)
library(ggplot2)

collatz_sequence %>%
  gather(key = "type", value = "count", Odd, Even) %>%
  ggplot(aes(x = type, y = count, fill = type)) +
  geom_bar(stat = "identity") +
  labs(title = "Counts of Odd & Even Numbers in Collatz Sequences",
       x = "Number Type",
       y = "Count") +
  theme_classic()

## Old Task 6

## 1. Heatmap showcasing the absolute length difference of random pairs of starting integers.

### Making pairs of random starting integers
pairs_df <- collatz_df %>%
  expand(start1 = start[1:1000], start2 = start[1:1000])

### Calculating the absolute difference between the length of the pairs
pairs_df <- pairs_df %>%
  mutate(abs_length_diff = abs(collatz_df$length[start1] - 
                                 collatz_df$length[start2]))

### Making the heatmap of the absolute length difference 
heatmap_plot <- ggplot(pairs_df, aes(x = start1,
                                     y = start2,
                                     fill = abs_length_diff)) +
  geom_tile() +
  scale_fill_gradient(low = "blue",
                      high = "red") +
  labs(title = "Collatz Conjecture Heatmap - Absolute Length Difference",
       x = "1st Starting Integer",
       y = "2nd Starting Integer") +
  theme_minimal()

print(heatmap_plot)
