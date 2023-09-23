# Task 5

# Question: Investigate if there are patterns or trends related to the occurrence of odd and even numbers across different starting integers

#Below is the Rcode examples to explore collatz conjecture sequences in distribution of odd and even numbers
library(tidyverse)
library(lintr)
library(styler)
library(dplyr)

## Initialize
collatz_sequence <- collatz_df

## Define the range of starting integers
start_range <- 1
end_range <- 10000

## Generate collatz sequences for each starting integer in the range and create a data frame
collatz_df <- data.frame(
  starting_integer = rep(start_range:end_range, each = end_range - start_range + 1),
  sequence = unlist(lappy(start_range:end_range, collatz_sequence))
)

## Wrangle the data to identify odd and even numbers in each sequence
collatz_df <- collatz_df %>%
  mutate(is_odd = sequence %% 2 == 1,
         is_even = sequence %% 2 == 0)


## Explore and visualize the distribution of odd and even numbers
## For example, create a histogram:
library(ggplot2)

ggplot(collatz_df, aes(x = sequence, fill = is_odd)) +
  geom_histogram(binwidth = 1, position = "dodge") +
  labs(x = "Value in Collatz Sequence", y = "Count") +
  ggtitle("Distribution of Odd and Even Numbers in Collatz Sequences")
  
