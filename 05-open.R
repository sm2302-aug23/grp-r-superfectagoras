# Task 5

# Question: Investigate if there are patterns or trends related to the occurrence of odd and even numbers across different starting integers

#Below is the Rcode examples to explore collatz conjecture sequences in distribution of odd and even numbers

## Function to generate Collatz sequence for a given starting integer
collatz_sequence <- function(n) {
  sequence <- c(n)
  while (n != 1) {
    if (n %% 2 == 0) {
      n <- n / 2
    } else {
      n <- 3 * n + 1
    }
    sequence <- c(sequence, n)
  }
  return(sequence)
}

## Define the range of starting integers
start_range <- 1
end_range <- 10000

## Generate Collatz sequences for each starting integer in the range
sequences <- lapply(start_range:end_range, collatz_sequence)

## Analyze the distribution of odd and even numbers in the sequences
odd_even_counts <- sapply(sequences, function(seq) {
  odd_count <- sum(seq %% 2 == 1)
  even_count <- sum(seq %% 2 == 0)
  return(list(odd_count = odd_count, even_count = even_count))
})

## Visualize the distribution of odd and even numbers, or perform further analysis

