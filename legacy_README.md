Collatz Conjecture
================

## Task 1: Generating The Collatz Conjecture

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.2     ✔ readr     2.1.4
    ## ✔ forcats   1.0.0     ✔ stringr   1.5.0
    ## ✔ ggplot2   3.4.3     ✔ tibble    3.2.1
    ## ✔ lubridate 1.9.2     ✔ tidyr     1.3.0
    ## ✔ purrr     1.0.2     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

### The Collatz Generator Function

``` r
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
```

### Creating The Collatz Database

``` r
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
```

## Task 2: Exploratory Data Analysis

## Task 3: Investigating “Backtracking” In Sequences

## Task 4: Visualisations

## Task 5: Open-ended Exploration

## Task 6: Creative Visualisation Challenge

## Contributors

- **Task 1:** Waqi

- **Task 2:** Ros

- **Task 3:** Waqi

- **Task 4:** Wana

- **Task 5:** Fizah

- **Task 6:** Ros

- **README:** All
