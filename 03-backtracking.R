# TASK 3

library(tidyverse)

# backtracks_df
## function to check for backtracking
backtrack <- function(x) {
  # initialize
  initial <- x[1]
  current <- 2
  below_init <- FALSE
  above_init <- FALSE

  while (current <= length(x)) {
    # check for when current value is less than initial
    if (x[current] < initial
        && (below_init == FALSE)) {
      below_init <- TRUE
    }

    # check for when current value is higher than initial
    # but only after below_init is TRUE
    if ((x[current] > initial)
        && (below_init == TRUE)
        && (above_init == FALSE)) {
      above_init <- TRUE
    }

    # increment current by 1
    current <- current + 1
  }

  ifelse(below_init & above_init, TRUE, FALSE)
}

## doing the actual filtering with the function
backtracks_df <-
  collatz_df %>%
  filter(
    length >= 3,
    sapply(seq, backtrack)
  )
