# Task 2

library(tidyverse)

## 1. Find the top 10 integers that produce the longest sequence.

top10longest <- collatz_df %>%
  arrange(desc(length)) %>%
  head(10) %>%
  pull("start")

## 2. Find out which starting integer produces a sequence
##    that reaches the highest max value.

max_val_int <- collatz_df %>%
  arrange(desc(max_val)) %>%
  head(1) %>%
  pull("start")

## 3. Find the difference between the average length and standard deviation of
##    the sequence for even and odd starting integers.

# Getting all the length of all even starting integers.
even_len <- collatz_df %>%
  filter(parity == "EVEN") %>%
  pull("length")

# Getting all the length of all odd starting integers.
odd_len <- collatz_df %>%
  filter(parity == "ODD") %>%
  pull("length")

# Comparing the average of even starting integers length with odd ones.
even_odd_avg_len <- c(mean(even_len), mean(odd_len))

# Comparing the standard deviation of
# even starting integers length with odd ones.
even_odd_sd_len <- c(sd(even_len), sd(odd_len))
