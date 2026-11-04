library(tidyverse)

top_songs <- read_rds("clean_data.rds")

billboard_plot <- top_songs |>
	ggplot(aes(x = week, y = rank, color = song)) +
	geom_line(linewidth = 1.1, alpha = 0.9) +
	scale_x_continuous(breaks = scales::breaks_pretty()) +
	scale_y_reverse(
		breaks = c(1, 20, 40, 60, 80, 100),
		limits = c(100, 1)
	) +
	scale_color_viridis_d(option = "D", end = 0.9) +
	labs(
		title = "How hit songs move through the Hot 100",
		subtitle = "Weekly rankings for the eight longest-charting songs",
		x = "Week on chart",
		y = "Billboard Hot 100 rank",
		color = NULL
	) +
	theme_minimal(base_size = 12) +
	theme(
		legend.position = "bottom",
		legend.text = element_text(size = 8),
		panel.grid.minor = element_blank()
	) +
	guides(color = guide_legend(ncol = 2))

ggsave("billboard_plot.png", plot = billboard_plot)
