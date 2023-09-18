# TASK 3

library(tidyverse)

# backtracks_df
## function to check for backtracking
backtrack <- function(x) {
  # Need ar least length 3 to go down and go up
  print("length(x)")
  print(length(x))
  if (length(x) < 3) {
    return(FALSE)
  }
  
  # initialize
  print("initial")
  initial <- x[1]
  print(initial)
  current <- 2
  below_init <- FALSE
  above_init <- FALSE
  
  while (current <= length(x)) {
    # check for when current value is less than initial
    print("x[current]")
    print(x[current])
    
    if (x[current] < initial) {
      below_init <- TRUE
    }
    
    # check for when current value is higher than initial
    # but only after below_init is TRUE
    if ((x[current] > initial) & (below_init == TRUE)) {
      above_init <- TRUE
    }
    
    # increment current by 1
    current <- current + 1
  }
  
  ifelse(below_init & after_init, TRUE, FALSE)
}

## doing the actual filtering with the function
backtracks_df <- 
  collatz_df %>%
  filter(backtrack(seq))