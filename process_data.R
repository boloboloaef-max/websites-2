library(tidyverse)

data("billboard", package = "tidyr")

billboard_long <- billboard |>
	pivot_longer(
		cols = starts_with("wk"),
		names_to = "week",
		names_prefix = "wk",
		names_transform = list(week = as.integer),
		values_to = "rank",
		values_drop_na = TRUE
	) |>
	mutate(song = str_c(track, " - ", artist))

featured_songs <- billboard_long |>
	count(song, name = "weeks_on_chart") |>
	slice_max(weeks_on_chart, n = 8, with_ties = FALSE) |>
	pull(song)

top_songs <- billboard_long |>
	filter(song %in% featured_songs)

write_rds(top_songs, file = "clean_data.rds")
