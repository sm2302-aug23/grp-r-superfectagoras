# TASK 3

library(tidyverse)

# ---------------------------- backtracks_df ----------------------------------

## function backtrack to check for backtracking inside sequences
backtrack <- function(x) {
  # initialize
  initial <- x[1]
  current <- 2
  below_init <- FALSE
  above_init <- FALSE

  while (current <= length(x)) {
    # check for when current value is less than initial
    if (x[current] < initial) {
      below_init <- TRUE
    }

    # check for when current value is higher than initial
    # but only after below_init is TRUE
    if ((x[current] > initial) &&
          (below_init == TRUE)) {
      above_init <- TRUE
    }

    # increment current by 1
    current <- current + 1
  }

  # Both must be TRUE to be considered backtracking
  ifelse(below_init & above_init, TRUE, FALSE)
}

## doing the actual filtering with the function
backtracks_df <-
  collatz_df %>%
  # only keep integers which sequences will make backtrack function output TRUE
  filter(
    sapply(seq, backtrack)
  )

# -------------------------- mode_backtrack -----------------------------------

## backtrack_count to count the number of backtracks in a sequence
backtrack_count <- function(x) {
  # initialize
  initial <- x[1]
  current <- 2
  below_init <- FALSE
  above_init <- FALSE
  counter <- 0

  while (current <= length(x)) {
    # check for when current value is less than initial
    if (x[current] < initial &&
          (below_init == FALSE)) {
      below_init <- TRUE
    }

    # check for when current value is higher than initial
    # but only after below_init is TRUE
    if ((x[current] > initial) &&
          (below_init == TRUE) &&
          (above_init == FALSE)) {
      above_init <- TRUE
    }

    # if below_init and above_init is true, add 1 to counter
    # immediately change back the variables to their FALSE state
    if (below_init && above_init) {
      counter <- counter + 1
      below_init <- FALSE
      above_init <- FALSE
    }

    # increment current by 1
    current <- current + 1
  }

  # returns the backtrack count for each sequences
  return(counter)
}

## mode_calculator to find the mode for the freq column
mode_calculator <- function(x) {
  # initialize
  unique_nums <- c()
  num_freq <- c()

  # tally the numbers in the freq table
  for (i in x) {
    # If the number in freq is not in unique_nums yet, add to unique_nums
    # also add one to num_freq index that represents the new number (last ind)
    # else, look for index where the number appears on unique_nums
    # and then add 1 to the same index in num_freq
    if ((i %in% unique_nums) == FALSE) {
      unique_nums <- c(unique_nums, i)
      num_freq <- c(num_freq, 1)
    } else {
      index <- which(unique_nums == i)
      num_freq[index] <- num_freq[index] + 1
    }
  }

  # Find the index of the highest frequency
  # then find the number represented by that frequency
  index <- which(num_freq == max(num_freq))
  mode_freq <- unique_nums[index]

  # return the mode
  return(mode_freq)
}

## doing the actual filtering with backtrack_count and mode_calculator
mode_backtrack <-
  backtracks_df %>%
  # add freq, whose values come from backtrack_count with seq as argument
  mutate(
    "freq" = sapply(seq, backtrack_count)
  ) %>%
  # summarizes the whole data using result from using mode_calculator with freq
  summarize(
    "mode" = mode_calculator(freq)
  ) %>%
  # gets the first value from the tibble so it comes out as a vector/double
  pull(1)

# -------------------------- max_after_backtrack ------------------------------

## function to find the max after first backtrack
max_backtrack <- function(x) {
  # initialize
  initial <- x[1]
  current <- 2
  below_init <- FALSE
  above_init <- FALSE
  max_val <- 0

  while (current <= length(x)) {
    # check for when current value is less than initial
    if (x[current] < initial) {
      below_init <- TRUE
    }

    # check for when current value is higher than initial
    # but only after below_init is TRUE
    if ((x[current] > initial) &&
          (below_init == TRUE)) {
      above_init <- TRUE
    }

    # if below_init and above_init is true, start checking for max_val
    if (below_init && above_init) {
      if (x[current] > max_val) {
        max_val <- x[current]
      }
    }

    # increment current by 1
    current <- current + 1
  }

  # return the max_val
  return(max_val)
}

## doing the actual filtering with max_backtrack
max_after_backtrack <-
  backtracks_df %>%
  # adds max_backtrack whose values come from using max_backtrack with seq
  mutate(
    "max_backtrack" = sapply(seq, max_backtrack)
  ) %>%
  # pulls the new column as a vector
  pull(max_backtrack)

# ----------------------- even_odd_backtrack ----------------------------------

## only need to filter by parity
even_odd_backtrack <-
  backtracks_df %>%
  # counts the number of Even and Odd integers in backtracks_df
  count(parity) %>%
  # pulls the n column as a vector
  pull(n)
