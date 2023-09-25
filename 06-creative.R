# Task 6

library(ggplot2)

## 1. Heatmap showcasing the absolute length difference of random pairs of starting integers.

### Making pairs of random starting integers
pairs_df <- collatz_df %>%
  expand(start1 = start, start2 = start)

### Calculating the absolute difference between the length of the pairs
pairs_df <- pairs_df %>%
  mutate(abs_length_diff = abs(length[start == start1] - length[start == start2]))

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
