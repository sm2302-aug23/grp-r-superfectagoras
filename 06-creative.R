parity_table <- 
  tibble(
    "ints" = rep(1:10000, times = 2),
    "even_odds_count" = c(collatz_sequence$even, collatz_sequence$odd)
  ) %>%
  arrange(ints) %>%
  mutate(
    "parity" = rep(c("Even", "Odd"), times = 10000)
  )

count <- parity_table$even_odds_count
parity_df <- parity_table[rep(seq_len(nrow(parity_table)), times = count), ]

parity_df %>%
  ggplot(
    aes(
      x = ints,
      fill = parity
    )
  ) +
  
  geom_histogram(
    binwidth = 1,
    position = "fill") +
  
  theme_classic()

## Another way of plotting ratio

odd_wins <-
  collatz_sequence %>%
  filter(even_odd_ratio <= 1)

top10ratio <-
  collatz_sequence %>%
  arrange(desc(even_odd_ratio)) %>%
  slice(1:10)

collatz_sequence %>%
  ggplot(
    aes(
      x = start,
      y = even_odd_ratio
    )
  ) +
  
  geom_point(
  ) +
  
  geom_point(
    data = odd_wins,
    color = "red"
  ) +
  
  geom_point(
    data = top10ratio,
    color = "blue",
    size = 1.5
  ) +
  
  geom_text_repel(
    data = top10ratio,
    aes(label = start,
        vjust = -0.5)
  ) +
  
  theme_classic()
