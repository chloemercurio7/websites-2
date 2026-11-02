library(tidyverse)

data("billboard", package = "tidyr")

billboard_long <- billboard |>
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    names_prefix = "wk",
    values_to = "rank"
  ) |>
  filter(!is.na(rank)) |>
  mutate(week = as.integer(week))

top_tracks <- billboard_long |>
  count(track, artist, name = "weeks_on_chart") |>
  slice_max(weeks_on_chart, n = 8, with_ties = FALSE) |>
  mutate(song = paste(track, artist, sep = " — "))

top_songs <- billboard_long |>
  semi_join(top_tracks, by = c("track", "artist")) |>
  mutate(song = paste(track, artist, sep = " — "))
