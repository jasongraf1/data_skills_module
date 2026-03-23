# ---------------------------------------------------------
# file: create_log-transformed_plots.R
# author: Jason Grafmiller
# date: 2026-03-13
# description:
# Code for showing log transformed data
# ---------------------------------------------------------

# Make sure to install packages first!
suppressMessages(library(here)) # for pathing to/from project directory
suppressMessages(library(tidyverse)) # for dplyr, ggplot, etc.
suppressMessages(library(patchwork)) # for dplyr, ggplot, etc.
suppressMessages(library(ggrepel)) # for labeling points in ggplot
suppressMessages(library(lemon)) # for freshening up ggplots

theme_set(theme_classic())

# `{MASS}` package installed as part of the standard R installation.
animals <- MASS::Animals |> 
  rownames_to_column("animal")


# Raw data plot ---------------------------------------

animals |> 
  ggplot(aes(body, brain)) +
  geom_point() +
  geom_text_repel(aes(label = animal)) +
  labs(
    x = "Body mass (kg)",
    y = "Brain mass (g)",
    title = "Body (kg) vs. brain (g) weight for 28 animals"
  ) +
  coord_capped_cart(
    left = "bottom",
    bottom = "left"
  )

ggsave(
  file = here("images", "animal_mass_raw.png"),
  dpi = 300,
  width = 300*5,
  height = 300*3.5,
  units = "px"
)


# Log transformed plot --------------------------------

animals |> 
  mutate(
    body_log10 = log10(body),
    brain_log10 = log10(brain),
  ) |> 
  ggplot(aes(body_log10, brain_log10)) +
  geom_point() +
  geom_text_repel(aes(label = animal)) +
  labs(
    x = "Body mass (log10 scale)",
    y = "Brain mass (log10 scale)",
    title = "Body (kg) vs. brain (g) weight for 28 animals"
  )

ggsave(
  file = here("images", "animal_mass_log.png"),
  dpi = 300,
  width = 300*5,
  height = 300*3.5,
  units = "px"
)
