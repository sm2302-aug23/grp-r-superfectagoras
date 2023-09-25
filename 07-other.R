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
