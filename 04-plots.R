# Task 4

# Load the ggplot2 library if not already loaded
library(ggplot2)

# Create a scatterplot of all sequence lengths
ggplot(data = collatz_df, aes(x = Starting_Integer, y = Sequence_Length)) +
  geom_point() +
  labs(x = "Starting Integer", y = "Sequence Length") +
  ggtitle("Scatterplot of Sequence Lengths") +
  theme_minimal()

# Create another scatterplot, highlighting the top 10 starting integers with a different color
top_10_starting_integers <- collatz_df %>%
  count(Starting_Integer) %>%
  top_n(10) %>%
  pull(Starting_Integer)

ggplot(data = collatz_df, aes(x = Starting_Integer, y = Highest_Value_Reached)) +
  geom_point(aes(color = Starting_Integer %in% top_10_starting_integers)) +
  labs(x = "Starting Integer", y = "Highest Value Reached") +
  scale_color_manual(values = c("TRUE" = "red", "FALSE" = "blue")) +
  ggtitle("Scatterplot of Highest Value Reached (Top 10 Highlighted)") +
  theme_minimal()

# Create a boxplot comparing sequence lengths for even and odd starting integers
ggplot(data = collatz_df, aes(x = factor(Starting_Integer %% 2 == 0), y = Sequence_Length)) +
  geom_boxplot() +
  labs(x = "Starting Integer (Even/Odd)", y = "Sequence Length") +
  scale_x_discrete(labels = c("Even", "Odd")) +
  ggtitle("Boxplot of Sequence Lengths (Even vs. Odd)") +
  theme_minimal()
