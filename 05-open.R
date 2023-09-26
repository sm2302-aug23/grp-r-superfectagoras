# Task 5

# Question: What is the distribution of even and odd numbers
# in Collatz sequences?

#Below is the Rcode examples to explore collatz conjecture sequences
# in distribution of odd and even numbers
library(tidyverse)
library(lintr)
library(styler)
library(dplyr)

## Initialize
collatz_sequence <- collatz_df

## Wrangle the data to identify odd and even numbers in each sequence
## and Calculate the ratio
collatz_sequence <- collatz_sequence %>%
  mutate(even = sapply(seq, function(x) {sum(x %% 2 == 0)}),
         odd = sapply(seq, function(x) {sum(x %% 2 == 1)}),
         even_odd_ratio = even / odd)

## Summarize statistics for even, odd and even_odd_ratio
even_odd_avg_max <- collatz_sequence %>%
  gather(key = "type", value = "value", even, odd) %>%
  group_by(type) %>%
  summarize(
    average = mean(value),
    maximum = max(value)
  )

ratio_avg_max <- collatz_sequence %>%
  gather(key = "type", value = "value", even_odd_ratio) %>%
  group_by(type) %>%
  summarize(
    average = mean(value),
    maximum = max(value)
  )
