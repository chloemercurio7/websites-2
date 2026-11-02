library(tidyverse)

top_songs <- read_rds("clean_data.rds")

billboard_plot <- ggplot(top_songs, aes(x = week, y = rank)) +
  geom_line(color = "#287271", linewidth = 1) +
  geom_point(
    data = \(data) filter(data, rank == 1),
    color = "#E76F51",
    size = 2.5
  ) +
  facet_wrap(vars(song), ncol = 2) +
  scale_y_reverse(breaks = seq(10, 100, by = 10)) +
  labs(
    title = "The Long Haul: Billboard Hot 100",
    subtitle = "Weekly rank for the eight longest-charting songs in the dataset",
    x = "Week on the chart",
    y = "Billboard rank (1 = highest)",
    caption = "Each line follows one song; orange dots mark weeks it reached No. 1."
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold"),
    strip.text = element_text(face = "bold"),
    panel.grid.minor = element_blank()
  )

ggsave("billboard_plot.png", plot = billboard_plot)
