# Task 5

# Question: Are there common stopping times that appear frequently across different starting integeres?

#Below is the Rcode examples to investigate and to explore collatz conjecture sequences in common stopping times

## Function to calculate stopping time for a given starting integer
collatz_stopping_time <- function(starting_integer) {
  n <- starting_integer
  steps <- 0
  
  while (n != 1) {
    if (n %% 2 == 0) {
      n <- n / 2
    } else {
      n <- 3 * n + 1
    }
    steps <- steps + 1
  }
  
  return(steps)
}

## Generate Collatz stopping times for a range of starting integers
starting_integers <- 1:1000
stopping_times <- sapply(starting_integers, collatz_stopping_time)

## Create a histogram of stopping times
hist(stopping_times, breaks = 30, main = "Distribution of Collatz Stopping Times", xlab = "Stopping Time")

## Calculate summary statistics









