# Task 2

library(tidyverse)

## 1. Find the top 10 integers that produce the longest sequence
   #Finding the top 10 integers with longest sequence
top10 <- collatz_df %>%
  arrange(desc(length)) %>%
  head(10)
   #Extracting the integers with longest sequence
top10longest <- top10 %>%
  pull("start")