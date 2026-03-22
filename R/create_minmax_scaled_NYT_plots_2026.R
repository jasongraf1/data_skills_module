# ---------------------------------------------------------
# file: create_minmax_scaled_NYT_plots_2026.R
# author: Jason Grafmiller
# date: 2026-03-13
# description:
# 
# ---------------------------------------------------------

suppressMessages(library(here)) # for pathing to/from project directory
suppressMessages(library(tidyverse)) # for dplyr, ggplot, etc.
suppressMessages(library(janitor)) # for cleaning data
suppressMessages(library(patchwork)) # combine ggplot objects
suppressMessages(library(scales)) # for various scales and plot options
suppressMessages(library(directlabels)) # for apply labels to plots
suppressMessages(library(ggthemes)) # custom ggplot themes
suppressMessages(library(ggpubr)) # custom ggplot themes
suppressMessages(library(ggrepel)) # for labeling points in ggplot
suppressMessages(library(ggtext)) # for markdown text in ggplot
suppressMessages(library(lemon)) # for freshening up ggplots

# set theme for plot
theme_set(theme_classic())

# minmax scaling function
minmax <- function(x) {
  return((x - min(x)) /(max(x) - min(x)))
}


# data wrangling --------------------------------------

# Load data
nyt <- here("data", "newpaper_terms_1820-2010.csv") |> 
  read_csv(col_types = "cnnn") |> 
  filter(Decade >= 1900)

# Get per million word frequency and scaled frequency
nyt <- nyt |> 
  group_by(Word) |> 
  mutate(
    Freq_Per_Mil = 1000000*Raw_Freq/Total_Words_Decade,
    Freq_MinMax = minmax(Freq_Per_Mil)
  ) |> 
  ungroup()

nyt

# Scaled counts ---------------------------------------

nyt |> 
  ggplot(aes(Decade, Freq_MinMax)) +
  geom_line(color = "steelblue4", linewidth = 1) +
  facet_wrap(~Word) +
  labs(x = "", y = "") +
  scale_y_continuous(limits = c(0, 1),
                     breaks = c(0, .5, 1)) +
  theme(
    # axis.text.y = element_blank(),
    strip.background = element_rect(color = NA),
    strip.text = element_text(size = 12),
    panel.background = element_rect(color = "black")
  )

ggsave(
  file = here("images", "nyt_minmax_counts.png"),
  dpi = 300,
  width = 300*5.8,
  height = 300*4.6,
  units = "px"
)


# PMW frequency counts --------------------------------

nyt |> 
  ggplot(aes(Decade, Freq_Per_Mil)) +
  geom_line(color = "steelblue4", linewidth = 1) +
  facet_wrap(~Word) +
  labs(x = "", y = "Freq per million words") +
  theme(
    # axis.text.y = element_blank(),
    strip.background = element_rect(color = NA),
    strip.text = element_text(size = 12),
    panel.background = element_rect(color = "black")
  )

ggsave(
  file = here("images", "nyt_pmw_counts.png"),
  dpi = 300,
  width = 300*5.8,
  height = 300*4.6,
  units = "px"
)

# Version without "war"
nyt |> 
  filter(Word != "war") |> 
  ggplot(aes(Decade, Freq_Per_Mil)) +
  geom_line(color = "steelblue4", linewidth = 1) +
  facet_wrap(~Word) +
  labs(x = "", y = "Freq per million words") +
  theme(
    # axis.text.y = element_blank(),
    strip.background = element_rect(color = NA),
    strip.text = element_text(size = 12),
    panel.background = element_rect(color = "black")
  )



