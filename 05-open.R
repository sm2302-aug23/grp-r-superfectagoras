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

## Calculate summary statistics for Odd, Even and Odd_Even_Ratio
summary_data <- collatz_sequence %>%
  gather(key = "type", value = "value", Even, Odd, Even_Odd_Ratio) %>%
  group_by(type) %>%
  summarize(
    Average = mean(value),
    Maximum = max(value)
  )

## Explore and visualize the distribution of even and odd numbers
## For example, create a barchart:
collatz_sequence %>%
  gather(key = "type", value = "count", Even, Odd) %>%
  ggplot(aes(x = count, y = type, fill = type)) +
  geom_bar(stat = "identity", position = "fill") +
  labs(title = "Statistics of Even & Odd Numbers in Collatz Sequences",
       x = "Count",
       y = "Number Type") +
  theme_classic()

