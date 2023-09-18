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
  start <- n
  current <- n
  seq <- c(n)
  parity <- ifelse(n %% 2 == 0, "EVEN", "ODD")
  max_val <- n

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

    # check if it is bigger than the current max_val
    if (current > max_val) {
      max_val <- current
    }
  }

  # check length of the sequence by the end
  length <- length(seq)

  # return what is needed
  # (don't forget to change seq into a list!)
  return(list("start" = start,
              "seq" = list(seq),
              "length" = length,
              "parity" = parity,
              "max_val" = max_val)
  )
}

# Time to create a tibble!
collatz_df <- tibble(
  "start" = 1,
  "seq" = gen_collatz(1)$seq,
  "length" = gen_collatz(1)$length,
  "parity" = gen_collatz(1)$parity,
  "max_val" = gen_collatz(1)$max_val
)

n <- 2

while (n <= 10000) {
  collatz_df <-
    collatz_df %>%
    add_row(
      "start" = n,
      "seq" = gen_collatz(n)$seq,
      "length" = gen_collatz(n)$length,
      "parity" = gen_collatz(n)$parity,
      "max_val" = gen_collatz(n)$max_val
    )

  n <- n + 1
}
