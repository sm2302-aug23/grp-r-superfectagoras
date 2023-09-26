Collatz Conjecture
================

## Task 1: Generating The Collatz Conjecture

1.  **Objective**

- **gen_collatz**

  - Create a function gen_collatz which generates collatz dataframe for
    integers from 1 to 10000

  - Throw errors when input is:

    - not an integer

    - less than one

- **collatz_df**

  - Using gen_collatz for inputs ranging from 1:10000, create a tibble
    called collatz_df

  - The columns of collatz_df are:

    - **start:** The starting integer of the sequence

    - **seq:** The Collatz sequence saved as a list

    - **length:** The length of the sequences

    - **parity:** The parity of the starting sequences

    - **max_val:** The highest value inside the sequences

2.  **How**

- **gen_collatz**

  - Throws error if any of these are false (input n):

    - `is.numeric(n)`

    - `n == as.integer(n)`

    - `n < 1`

  - Saving the input inside a variable `current`

  - While `current < 1`

    - if current is odd, apply 3n+1 formula

    - if current is even, apply n/2 formula

    - these numbers are saved in a vector `seq`

  - returns the vector `seq`

- **collatz_df**

  - initialize the tibble with values for starting integer 1

    - **start:** the starting integer (in this case, 1)

    - **seq:** value obtained from putting the starting integer as
      argument for `gen_collatz`

    - **length:** length of seq

    - **parity:** simply check if starting integer is even or odd

    - **max_val:** finds the highest value in seq using `max()`, but not
      before changing seq from a list to a vector using `unlist()`

  - Create a for loop and use `add_row()` to add rows for integers 2 to
    10000

<!-- -->

    ## # A tibble: 10,000 × 5
    ##    start seq        length parity max_val
    ##    <dbl> <list>      <int> <chr>    <dbl>
    ##  1     1 <dbl [1]>       1 ODD          1
    ##  2     2 <dbl [2]>       2 EVEN         2
    ##  3     3 <dbl [8]>       8 ODD         16
    ##  4     4 <dbl [3]>       3 EVEN         4
    ##  5     5 <dbl [6]>       6 ODD         16
    ##  6     6 <dbl [9]>       9 EVEN        16
    ##  7     7 <dbl [17]>     17 ODD         52
    ##  8     8 <dbl [4]>       4 EVEN         8
    ##  9     9 <dbl [20]>     20 ODD         52
    ## 10    10 <dbl [7]>       7 EVEN        16
    ## # ℹ 9,990 more rows

## Task 2: Exploratory Data Analysis

### Part 1: top10longest

1.  **Objective**

- Get a list of 10 starting integers that have the longest sequence.

2.  **How**

- Using arange(desc(length)) function to arrange the length data from
  collatz_df from Task 1 in descending order.
- Using head(10) function to only take the first 10 data from the new
  arrangements of collatz_df.
- Using pull(“start”) to only take the starting integers of the new data
  table.

#### Resulting top10longest

    ##  [1] 6171 9257 6943 7963 8959 6591 9887 9897 7422 7423

### Part 2: max_val_int

1.  **Objective**

- Get the starting integer with the highest max value in the sequence.

2.  **How**

- Similar concepts with Part 1.
- Using arrange(desc(max_val)) function to arrange the max_val data from
  collatz_df from Task 1 in descending order.
- For the head function use head(1), so only 1 starting integer is
  obtained.
- Using pull(“start”) to only take the starting integers of the new data
  table.

#### Resulting max_val_int

    ## [1] 9663

### Part 3: even_odd_avg_len and even_odd_sd_len

1.  **Objectives**

- Get the length of all even and odd starting integers separately.
- Make a list that can compare the average length for even and odd
  starting integers.
- Make a list that can compare the standard deviation of the length for
  even and odd starting integers.

2.  **How**

- Using filter(parity == “EVEN”) function to only get the data from
  collatz_df from Task 1 that have the starting integer being an even
  number. Use filter(parity == “ODD”) for odd numbers.
- Using pull(“length”) function to only get the length data from the new
  even and odd data tables.
- Using c(mean(even_len), mean(odd_len)) function to combine the mean
  value of even lengths with the mean value of odd lengths.
- Using c(sd(even_len), sd(odd_len)) function to combine the standard
  deviation value of even lengths with the standard deviation value of
  odd lengths.

#### Resulting even_odd_avg_len and even_odd_sd_len

##### even_odd_avg_len

    ## [1] 79.5936 92.3396

##### even_odd_sd_len

    ## [1] 45.10308 47.18387

## Task 3: Investigating “Backtracking” In Sequences

### Part 1: backtracks_df

1.  **Objective:**

- Filter the data so that only rows where there is backtracking present
  in the sequences are kept. Save this new tibble as `backtracks_df`

2.  **How:**

- Create a new `backtrack` function to check if there are backtracks in
  sequences

  - If there is a point where the next number is less than the starting
    integer, set `below_init <- TRUE`

  - If there is a point after `below_init <- TRUE` where the next number
    is higher than the starting integer, set `above_init <- TRUE`

  - If both `below_init` and `above_init` is `TRUE`, then return `TRUE`

- Filtering the data

  - Simply use `filter()` on `collatz_df`, where it filters only rows
    that returns `TRUE` for the `backtrack` function. This will be saved
    inside `backtracks_df`

#### Resulting backtracks_df

    ## # A tibble: 8,229 × 5
    ##    start seq        length parity max_val
    ##    <dbl> <list>      <int> <chr>    <dbl>
    ##  1     6 <dbl [9]>       9 EVEN        16
    ##  2     7 <dbl [17]>     17 ODD         52
    ##  3     9 <dbl [20]>     20 ODD         52
    ##  4    10 <dbl [7]>       7 EVEN        16
    ##  5    11 <dbl [15]>     15 ODD         52
    ##  6    12 <dbl [10]>     10 EVEN        16
    ##  7    13 <dbl [10]>     10 ODD         40
    ##  8    14 <dbl [18]>     18 EVEN        52
    ##  9    15 <dbl [18]>     18 ODD        160
    ## 10    17 <dbl [13]>     13 ODD         52
    ## # ℹ 8,219 more rows

### Part 2: mode_backtrack

1.  **Objective:**

- Find out what is the most frequently occuring number of times
  backtracking occurs in a sequence . Save this value as
  `mode_backtrack`

2.  **How:**

- Create a new `backtrack_count` function to count number of backtracks
  in a sequence

  - Works similarly to `backtrack` except it immediately resets
    `below_init` and `above_init` as `FALSE` whenever both of them are
    `TRUE`

  - The function counts how many times it has done this, and returns
    that count

- Create a new function called `mode_calculator`, which checks the mode
  inside a list/vector/column.

- Filtering the data

  - Using `backtracks_df`, mutate the data so it has a new column for
    `freq`, whose value is obtained from using `backtrack_count`

  - Get the mode using `summarise()` and using `mode_calculator`

  - Do `pull(1)` to get the value as a vector/double

#### Resulting mode_backtrack

    ## [1] 1

This means that the mode of the number of backtracks is `1`.

### Part 3: max_after_backtrack

1.  **Objective:**

- Find out what is the maximum value reached after the first backtrack
  of these sequences. Save this vector as `max_after_backtrack`

2.  **How:**

- Create a new `max_backtrack` function to get the number after the
  first backtrack

  - Works similarly to `backtrack` except it also saves the current
    number that triggered `above_init` to be TRUE. Return this number.

- Filtering the data

  - Using `backtracks_df`, mutate the data so it has a new column
    `max_backtrack`, whose value is obtained from using
    `max_backtrack function`

  - Use `pull()` to get the new column as a vector. Save it in
    `max_after_backtrack`

#### Resulting max_after_backtrack

Converted to the tibble for the sake of the README. The original code
should output a very long vector instead.

    ## # A tibble: 8,229 × 1
    ##    max_after_backtrack
    ##                  <dbl>
    ##  1                  16
    ##  2                  16
    ##  3                  52
    ##  4                  16
    ##  5                  16
    ##  6                  16
    ##  7                  16
    ##  8                  52
    ##  9                  16
    ## 10                  40
    ## # ℹ 8,219 more rows

### Part 4: even_odd_backtrack

1.  **Objective:**

- Find the frequency count for even and odd bactracking integers. Save
  this vector as even_odd_backtrack.

2.  **How:**

- Filtering the data

  - Using `backtracks_df`, use `count()` to find the frequency for each
    unique values in `parity`, which are `EVEN` and `ODD`

  - Use `pull()` to get the result column as a vector. Save it in
    `even_odd_backtrack`

#### Resulting even_odd_backtrack

First value being the even count, second being the odd count.

    ## [1] 3943 4286

## Task 4: Visualizations

#### Sequence lengths x Starting integers scatter plot

1.  **Objective**

- Create a scatter plot showing the correlation between sequence lengths
  (y-axis) and starting integers (x-axis).
- Additionally, we want to find the top 10 starting integers with the
  longest sequences and highlight them.

2.  **How**

- Using the ggplot function to plot the top10integers and collatz_df
  data sets from tasks 1 and 2, respectively. Adjusting the color, size,
  and shape of the points brings focus on the top 10 points.
- Using the geom_text_repel() function to label the top 10 points.

Here’s how the plot for this scatter plot looks like:

![](README_files/figure-gfm/Task_4_1-1.png)<!-- -->

The whole code for this scatter plot can be found in
[04-plots.R](04-plots.R) in Q1.

#### Highest Sequence Value x Starting integers scatter plot

1.  **Objective**

- Similar to question 1, but with a relationship between the starting
  integers (x-axis) and the highest sequence value (y-axis).

2.  **How**

- By using the ggplot function.
- The scatter plot’s top 10 beginning integers with the highest sequence
  value were given a distinct color that made them stand out. As a
  result, it is simpler to find and examine these individual data
  points.
- Logarithmic scale was used for the y-axis as some of the values ended
  up being much higher than the others, making the rest of the points
  squished at the bottom originally.

Here’s how the plot for this scatter plot looks like:

![](README_files/figure-gfm/Task_4_2-1.png)<!-- -->

The whole code for this scatter plot can be found in
[04-plots.R](04-plots.R) in Q2.

#### Even x Odd starting integers box plot

1.  **Objective**

- To visually examine and compare the distributional characteristics of
  sequence lengths for even and odd starting integers in order to gain
  insights into their behavior and properties.

2.  **How**

- Similar to questions 1 and 2, make a box plot using ggplot for each
  category (even and odd).
- In these box plots, the y-axis represents the distribution of sequence
  lengths, and the x-axis the parity (even and odd).

Here’s how the plot for this scatter plot looks like:

![](README_files/figure-gfm/Task_4_3-1.png)<!-- -->

The whole code for this scatter plot can be found in
[04-plots.R](04-plots.R) in Q3.

These are the few differences that I can notice based on my
observations.

1.  **Overlap and Variability**
    - The distribution of sequence lengths for even and odd starting
      integers shows a significant overlap, indicating that there is a
      wide range of sequence lengths for both groups.
    - Even starting integers exhibit a broader range of sequence
      lengths, suggesting greater variability compared to odd starting
      integers.
2.  **Median length**
    - The lower position of the median line (inside the box) for even
      integers compared to odd integers suggests that, on average,
      sequences starting with even integers tend to be shorter.
3.  **Similar average length**
    - Despite the lower median line for even integers, you’ve noted that
      the difference in average sequence length between even and odd
      starting integers is not substantial. In other words, both groups
      tend to have sequences of roughly similar average lengths.

## Task 5: Open-ended Exploration

### Question

> What is the distribution of even and odd numbers in Collatz sequences?

**Objectives**

- To understand the distributions of odd and even numbers within these sequences.
- To estimate if there are patterns or trends related to the occurrence of these distributions using R.
- To investigate whether there is a relationship between even and odd numbers in terms of
their ratio.

### Methodology

#### Counts of Even and Odd Numbers

1.  **Objective**

- To calculate the sum of even and odd numbers, respectively, from each sequence.
- To analyse the distribution between the even and odd numbers for comparison.

2.  **How**

- Generate `collatz_sequence` using an existing data frame `collatz_df` from previous tasks by initialization.
- Wrangle the data to identify `Even` and `Odd` numbers in each sequence and then use the mutating function, respectively with the help of `sapply`.

The rcode can be found in [05-open.R](05-open.R) on the wrangling part.

#### Even-Odd Ratio

1.  **Objective**

- To calculate the even-to-odd ratio

2.  **How**

- Introduce the variable as `Even_Odd_Ratio`.
- Then have this variable compute the result by having even numbers divisible by odd numbers.

The rcode can be found in [05-open.R](05-open.R) on the wrangling mutate part.

#### Summary Statistics

1.  **Objective**

- To calculate the average and maximum values for even, odd and even-odd ratio

3.  **How**

- Create variables for even and odd numbers (`EvenOdd_Avg_Max`) and the `Even_Odd_Ratio` (`Ratio_Avg_Max`) separately.
- Using the `summarize()` with the help of `gather()` to accurately calculate the average and maximum values for `EvenOdd_Avg_Max` and `Ratio_Avg_Max`.

The rcode can be found in [05-open.R](05-open.R) on the summarize statistics part.

### Findings

The following are the differences noted based on my observations:-

#### Counts of Even and Odd Numbers

- The analysis revealed that there is a significant distribution of both even and odd numbers.
- There are more even total numbers compared to odd total numbers (refer to [7.5.1 Counts of Odd & Even Numbers in Collatz Sequences](https://github.com/sm2302-aug23/grp-r-superfectagoras#751-counts-of-odd--even-numbers-in-collatz-sequences)).
- Such distribution is important because it indicates that a pattern or trend can be further analyzed using the Collatz Conjecture to make comparisons.
- Below is how the column looks:

##### Count of even, odd and even-odd ratio numbers

      ## # A tibble: 10,000 × 8
      ##    start seq        length parity max_val  even   odd even_odd_ratio
      ##    <dbl> <list>      <int> <chr>    <dbl> <int> <int>          <dbl>
      ##  1     1 <dbl [1]>       1 ODD          1     0     1           0   
      ##  2     2 <dbl [2]>       2 EVEN         2     1     1           1   
      ##  3     3 <dbl [8]>       8 ODD         16     5     3           1.67
      ##  4     4 <dbl [3]>       3 EVEN         4     2     1           2   
      ##  5     5 <dbl [6]>       6 ODD         16     4     2           2   
      ##  6     6 <dbl [9]>       9 EVEN        16     6     3           2   
      ##  7     7 <dbl [17]>     17 ODD         52    11     6           1.83
      ##  8     8 <dbl [4]>       4 EVEN         8     3     1           3   
      ##  9     9 <dbl [20]>     20 ODD         52    13     7           1.86
      ## 10    10 <dbl [7]>       7 EVEN        16     5     2           2.5 
      ## # ℹ 9,990 more rows

#### Even-Odd Ratio

- We can see that except for starting 1 and 2, it appears that on even starting sequences, the ratio varies individually.
- The calculated `Even_Odd_Ratio` for each sequence varies individually but almost uniformly.
- If this result is visualized in a plot graph, one can tell that it is mostly likely to showcase almost uniformity.
- This indicates that there is a relationship between even and odd numbers in terms of their ratio, as its variations exhibit diverse patterns.
- The results can be seen in the above column.

#### Summary Statistics

- The summary statistics show the average and maximum counts for even and odd numbers (`EvenOdd_Avg_Max`), and even-odd ratios (`Ratio_Avg_Max`).
- This information helps in understanding the central tendency and variability of even, odd and their ratio, even if there is a slight variance.
- The summary statistics offer a concise overview of the data, aiding in comparisons and identifying sequences with unusual properties.
- Below is how the results looks:

##### Part 1: EvenOdd_Avg_Max results

    ## # A tibble: 2 × 3
    ##   type  average maximum
    ##   <chr>   <dbl>   <int>
    ## 1 even     56.8     165
    ## 2 odd      29.2      97

##### Part 2: Ratio_Avg_Max results

    ## # A tibble: 1 × 3
    ##   type           average maximum
    ##   <chr>            <dbl>   <dbl>
    ## 1 even_odd_ratio    2.18      13

### Conclusion

The analysis of Collatz Conjecture sequences reveals that these
sequences exhibit a distribution of both even and odd numbers (refer to
[7.5.1 Counts of Odd & Even Numbers in Collatz
Sequences](https://github.com/sm2302-aug23/grp-r-superfectagoras#751-counts-of-odd--even-numbers-in-collatz-sequences)).
The even-to-odd ratio varies across different sequences, with a few
sequences having higher ratios than others. This information can
contribute to a deeper understanding of the Collatz Conjecture sequences
and their patterns.

## Task 6: Creative Visualisation Challenge

### Question

Plotting the ratio of even and odd numbers in the sequences.

#### Method 1

- By using `ggplot2` with `geom_histogram`.
- First making `parity_table` with
  `c(collatz_sequence$even, collatz_sequence$odd)` which can be use to
  count the number of even and odd numbers in each sequence.
- Using
  `parity_table[rep(seq_len(nrow(parity_table)), times = count), ]` to
  put into `parity_df` which can be used as `fill` for the histogram.
- For x-axis of the histogram it would be the starting integers.

![](README_files/figure-gfm/Task_6_1-1.png)<!-- -->

#### Method 2

- By using `ggplot2` with `geom_point`.
- Using `even_odd_ratio` as the y-axis.
- The top ten highest ratio are labelled and colored in blue.
- The red dots represents the ratio that are `odd>=even`.

![](README_files/figure-gfm/Task_6_2-1.png)<!-- -->

## Task 7 : Other Data

### Task 5 append

#### 7.5.1 Plot for Counts of Odd & Even Numbers in Collatz Sequences

![](README_files/figure-gfm/collatz_sequence_plot_code-1.png)<!-- -->

### Sequence Length Heatmap

#### Question

Comparing pairs of starting integers with absolute length difference
using heatmap.

##### Method

- Make pairs of all possible starting integers using
  `expand(start1 = start[1:1000], start2 = start[1:1000])`
- Calculate the absolute difference between the length of the pair using
  `abs(collatz_df$length[start1] - collatz_df$length[start2]))`
- There are straight diagonal lines seen in blue color that shows the
  pairs that have the same sequence length.

![](README_files/figure-gfm/heatmap-1.png)<!-- -->

## Contributors

- **Task 1:** Waqi :computer: :sparkles:

- **Task 2:** Ros :octocat: :wilted_flower:

- **Task 3:** Waqi :computer: :sparkles:

- **Task 4:** Wana :books: :pill:

- **Task 5:** Fizah :partly_sunny: :milky_way:

- **Task 6:** Ros :octocat: :wilted_flower:

- **Task 7:** Fizah & Ros :partly_sunny: :milky_way: :octocat:
  :wilted_flower:

- **README:** All :computer: :sparkles: :octocat: :wilted_flower:
  :books: :pill: :partly_sunny: :milky_way:
