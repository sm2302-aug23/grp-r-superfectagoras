# TASK 1

library(tidyverse)

# accepts a single integer
gen_collatz <- function(n) {
  # Input should all be numerical
  if (is.numeric(n) == FALSE) {
    stop("Invalid input: Not a numerical value")
  }

  # Input should all be integers
  if ((n == as.integer(n)) == FALSE) {
    stop("Invalid input: Not an integer")
  }

  # Input should be 1 or more
  if (n < 1) {
    stop("Invalid input: Value is less than 1")
  }

  # Initialize values
  current <- n
  seq <- c(n)


  # Initialize values
  current <- n
  seq <- c(n)

  # The actual function
  while (current > 1) {
    # check if odd or even
    if (current %% 2 == 0) {
      current <- current / 2
    } else {
      current <- (current * 3) + 1
    }

    # save the new number into the sequence
    seq <- c(seq, current)
  }

  # return the sequence
  return(seq)
}

# Time to create a tibble!
collatz_df <- tibble(
  "start" = 1,
  "seq" = list(gen_collatz(1)),
  "length" = length(unlist(seq)),
  "parity" = ifelse((start %% 2) == 0, "EVEN", "ODD"),
  "max_val" = max(unlist(seq))
)

n <- 2

while (n <= 10000) {
  collatz_df <-
    collatz_df %>%
    add_row(
      "start" = n,
      "seq" = list(gen_collatz(n)),
      "length" = length(unlist(seq)),
      "parity" = ifelse((start %% 2) == 0, "EVEN", "ODD"),
      "max_val" = max(unlist(seq))
    )

  n <- n + 1
}
