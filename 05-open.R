# Task 5

# Question: What is the distribution of even and odd numbers in Collatz sequences?

#Below is the Rcode examples to explore collatz conjecture sequences in distribution of odd and even numbers
library(tidyverse)
library(lintr)
library(styler)
library(dplyr)

## Initialize
collatz_sequence <- collatz_df

## Wrangle the data to identify odd and even numbers in each sequence
## and Calculate the ratio
collatz_sequence <- collatz_sequence %>%
  mutate(Even = sapply(seq, function(x) {sum(x %% 2 == 0)}),
         Odd = sapply(seq, function(x) {sum(x %% 2 == 1 )}),
         Even_Odd_Ratio = Even / Odd)

## Summarize statistics for Even, Odd and Even_Odd_Ratio
EvenOdd_Avg_Max <- collatz_sequence %>%
  gather(key = "type", value = "value", Even, Odd) %>%
  group_by(type) %>%
  summarize(
    Average = mean(value),
    Maximum = max(value)
  )

Ratio_Avg_Max <- collatz_sequence %>%
  gather(key = "type", value = "value", Even_Odd_Ratio) %>%
  group_by(type) %>%
  summarize(
    Average = mean(value),
    Maximum = max(value)
  )

