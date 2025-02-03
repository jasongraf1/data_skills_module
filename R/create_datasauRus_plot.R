# ----------------------------------------------------------------------------
# file: create_datasauRus_plot.R
# author: Jason Grafmiller
# date: 2025-01-30
# description:
# 
# ----------------------------------------------------------------------------

library(here)
library(tidyverse)
# install.packages(c("datasauRus", "gganimate"))
library(datasauRus)
library(gganimate) # for animated gifs

datasaurus_dozen |> 
  ggplot(aes(x, y)) +
  geom_point(size = 3, alpha = .8, color = "midnightblue") +
  theme_minimal() + 
  theme(
    axis.title = element_blank()
  ) +
  transition_states(
    states = dataset,
    transition_length = 40,
    state_length = 20
  )

anim_save(
  filename = here("images", "datasaurus_dozen.gif")
)

