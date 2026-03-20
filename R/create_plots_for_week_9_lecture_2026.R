# ---------------------------------------------------------
# file: create_plots_for_week_9_lecture_2026.R
# author: Jason Grafmiller
# date: 2026-03-13
# description:
# 
# ---------------------------------------------------------

library(here) # for pathing to/from project directory
library(tidyverse) # for dplyr, ggplot, etc.
library(janitor) # for cleaning data
library(lemon)
library(ggrepel)
library(patchwork)
library(tidytext)

# set theme for plot
theme_set(theme_classic())


# Data ------------------------------------------------

sharma <- here("data", "uk_accents_sharma_et_al.csv") |> 
  read_csv()

lm(Attractiveness ~ Prestige, sharma)


# scatterplots ----------------------------------------

sharma |> 
  ggplot(aes(Prestige, Attractiveness)) +
  geom_point(size = 2) +
  geom_text_repel(aes(label = Label), size = 2) +
  scale_x_continuous(limits = c(3, 5.6), breaks = 1:7) +
  scale_y_continuous(limits = c(3, 5), breaks = 1:7)

ggsave(
  here("images", "accents_sharma_scatterplot1.tiff"),
  device = "tiff",
  height = 300*4,
  width = 300*4,
  units = "px"
)

sharma |> 
  ggplot(aes(Prestige, Attractiveness)) +
  geom_point(size = 2) +
  scale_x_continuous(limits = c(3, 5.6), breaks = 1:7) +
  scale_y_continuous(limits = c(3, 5), breaks = 1:7)

ggsave(
  here("images", "accents_sharma_scatterplot2.tiff"),
  device = "tiff",
  height = 300*4,
  width = 300*4,
  units = "px"
)

sharma |> 
  ggplot(aes(Prestige, Attractiveness)) +
  geom_point(size = 2) +
  geom_smooth(se = F, method = "gam") +
  geom_smooth(se = F, method = "lm", colour = "red4") +
  scale_x_continuous(limits = c(3, 5.6), breaks = 1:7) +
  scale_y_continuous(limits = c(3, 5), breaks = 1:7)

ggsave(
  here("images", "accents_sharma_scatterplot3.tiff"),
  device = "tiff",
  height = 300*4,
  width = 300*4,
  units = "px"
)


# Regression ------------------------------------------

set.seed(6789)
d <- MASS::mvrnorm(
  n = 25, mu = c(0,0), Sigma = rbind(c(1, .75), c(.75, 1))
  ) |> 
  as.data.frame() |> 
  as_tibble() 

mean(d)

lm(V2 ~ V1, d)


ggplot(d, aes(V1, V2)) +
  geom_point(size = 2) +
  # geom_smooth(method = "lm", se = F) +
  geom_abline(
    slope = 0.788, intercept = 0.2272,
    colour = "blue1", linewidth = 1
  ) +
  labs(x = "", y = "") +
  # scale_x_continuous(limits = c(-2.5, 2)) +
  scale_y_continuous(limits = c(-2.25, 2.25))

ggsave(
  here("images", "regression_scatterplot1.tiff"),
  device = "tiff",
  height = 300*4,
  width = 300*4,
  units = "px"
)

