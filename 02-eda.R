# Task 2

library(tidyverse)

## 1. Find the top 10 integers that produce the longest sequence.

top10longest <- collatz_df %>%
  arrange(desc(length)) %>%
  head(10)%>%
  pull("start")

## 2. Find out which starting integer produces a sequence that reaches the highest max value.

max_val_int <- collatz_df %>%
  arrange(desc(max_val))%>%
  head(1)%>%
  pull("start")
