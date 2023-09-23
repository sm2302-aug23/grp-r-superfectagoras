Collatz Conjecture
================

## Task 1: Generating The Collatz Conjecture

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

### Part 1: backtracks_df

#### backtrack function for use in filtering

``` r
## function backtrack to check for backtracking
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
```

#### Filtering for backtracks_df

``` r
## doing the actual filtering with the function
backtracks_df <-
  collatz_df %>%
  filter(
    sapply(seq, backtrack)
  )
```

### Part 2: mode_backtrack

#### backtrack_count for counting number of backtracks in a sequence

``` r
## backtrack count
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
```

#### mode_calculator for counting the mode for number of backtracks

``` r
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
```

#### Filtering for mode_backtrack

``` r
## doing the actual filtering with backtrack_count
mode_backtrack <-
  backtracks_df %>%
  mutate(
    "freq" = sapply(seq, backtrack_count)
  ) %>%
  summarize(
    "mode" = mode_calculator(freq)
  ) %>%
  pull(1)
```

### Part 3: max_after_backtrack

#### max_backtrack function to look for the highest number right after backtracks

``` r
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
```

#### Filtering for max_after_backtrack

``` r
## doing the actual filtering with max_after_backtrack
max_after_backtrack <-
  backtracks_df %>%
  mutate(
    "max_backtrack" = sapply(seq, max_backtrack)
  ) %>%
  pull(max_backtrack)
```

### Part 4: even_odd_backtrack

#### Filtering for even_odd_backtrack

``` r
## only need to filter by parity
even_odd_backtrack <-
  backtracks_df %>%
  count(parity) %>%
  pull(n)
```

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
