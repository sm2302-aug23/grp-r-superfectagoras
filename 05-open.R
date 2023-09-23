# Task 5

# Question: Investigate if there are patterns or trends related to the occurrence of odd and even numbers across different starting integers

#Below is the Rcode examples to explore collatz conjecture sequences in distribution of odd and even numbers
library(tidyverse)
library(lintr)
library(styler)
library(dplyr)
library(ggplot2)

## Initialize
collatz_sequence <- collatz_df

## Wrangle the data to identify odd and even numbers in each sequence
## and Calculate the ratio
collatz_sequence <- collatz_sequence %>%
  mutate(Even = sapply(seq, function(x) {sum(x %% 2 == 0)}),
         Odd = sapply(seq, function(x) {sum(x %% 2 == 1 )}),
         Even_Odd_Ratio = Even / Odd)

## Summarize statistics for Even, Odd and Even_Odd_Ratio
sum_even_odd <- collatz_sequence %>%
  gather(key = "type", value = "value", Even, Odd) %>%
  group_by(type) %>%
  summarize(
    Average = mean(value),
    Maximum = max(value)
  )

whole_ratio <- collatz_sequence %>%
  gather(key = "type", value = "value", Even_Odd_Ratio) %>%
  group_by(type) %>%
  summarize(
    Average = mean(value),
    Maximum = max(value)
  )

