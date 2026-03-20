# ----------------------------------------------------------
# file: create_plots_for_week_8_lecture_2026.R
# author: Jason Grafmiller
# date: 2025-03-03
# description:
# What the name says...
# ----------------------------------------------------------

library(here) # for pathing to/from project directory
library(tidyverse) # for dplyr, ggplot, etc.
library(janitor) # for cleaning data
library(lemon)
library(ggrepel)
library(patchwork)
library(tidytext)

# set theme for plot
theme_set(theme_classic())

df1 |> 
  filter(Word %in% c("mother", "silence", "neighbour", "errand", "creeping", "opposing", "tabloid", "nigh", "fuchsia", "unappealing", "stylishly")) |> 
  mutate(length = str_length(Word),
         diff = length - 8.9,
         dev = abs(diff),
         sqdiff = diff^2) |> 
  select(-c(2:7))


# Lyrics plots ----------------------------------------

# Lyrics data
bbd_lyrics <- read_csv("https://raw.githubusercontent.com/jasongraf1/data_skills_module/refs/heads/main/data/billboard_top100_lyrics_1960-2022_fixed.csv") |> 
  filter(lyrics != "") 

# Tidy data
bbd_tidy <- bbd_lyrics |> 
  unnest_tokens(word, lyrics)

bbd_tidy |> 
  count(title) |> 
  filter(n < 1500) |> 
  summary()

# join datasets
bbd_lyrics <- bbd_lyrics |> 
  left_join(
    bbd_tidy |> 
      count(title, name = "length"),
    by = "title"
  )

bbd_lyrics |> 
  summarise(
    Min = min(length),
    SD_low = mean(length) - sd(length),
    Q1 = quantile(length, .25),
    Median = median(length),
    Mean = mean(length),
    Q3 = quantile(length, .75),
    SD_hi = mean(length) + sd(length),
    Max = max(length),
    SD = sd(length)
  )


## simple histogram -----
song_hist1 <- bbd_tidy |> 
  count(title) |> 
  filter(n < 1500) |> 
  ggplot(aes(n)) +
  geom_histogram(binwidth = 25, colour = "white", fill = "grey30") +
  labs(x = "Length in words", y = "") +
  lemon::coord_capped_cart(left = "bottom", bottom = "left")

ggsave(
  here("images", "hot100_song_lengths1.tiff"),
  plot = song_hist1,
  device = "tiff",
  dpi = 300, 
  width = 300*7,
  height = 300*3.5,
  units = "px"
)

# Add mean and median
mean <- bbd_tidy |> 
  count(title) |> 
  pull(n) |> 
  mean()

median <- bbd_tidy |> 
  count(title) |> 
  pull(n) |> 
  median()

bbd_tidy |> 
  count(title) |> 
  filter(n < 1500) |> 
  ggplot(aes(n)) +
  geom_histogram(binwidth = 25, colour = "white", fill = "grey30") +
  geom_vline(
    xintercept = c(mean, median), 
    colour = c("red", "blue"),
    linewidth = 1
  ) +
  labs(x = "Length in words", y = "") +
  lemon::coord_capped_cart(left = "bottom", bottom = "left")

ggsave(
  here("images", "hot100_song_lengths2.tiff"),
  device = "tiff",
  dpi = 300, 
  width = 300*7,
  height = 300*3.5,
  units = "px"
)

## add boxplot -----

song_box <- bbd_tidy |> 
  count(title) |> 
  filter(n < 1500) |> 
  ggplot(aes(n)) +
  geom_boxplot(fill = "grey", width = .5) +
  theme_void()

(song_box / song_hist1) +
  plot_layout(heights = c(1, 8))
  
ggsave(
  here("images", "hot100_song_lengths3.tiff"),
  device = "tiff",
  dpi = 300, 
  width = 300*7,
  height = 300*3.5,
  units = "px"
)

## add mean and SD plot -----

song_mean_sd <- bbd_tidy |> 
  count(title) |> 
  summarise(
    mean = mean(n),
    SD = sd(n),
    lower = mean - SD,
    upper = mean + SD
  ) |> 
  ggplot(aes(x = mean, y = 0)) +
  geom_point(shape = 15, size = 4, , colour = "grey20") +
  geom_errorbar(aes(xmin = lower, xmax = upper),
                width = .4, linewidth = 1, colour = "grey20") +
  scale_x_continuous(limits = c(0, 1500)) +
  scale_y_continuous(limits = c(-.5, .5)) +
  theme_void()

(song_mean_sd / song_hist1) +
  plot_layout(heights = c(1, 8))

ggsave(
  here("images", "hot100_song_lengths4.tiff"),
  device = "tiff",
  dpi = 300, 
  width = 300*7,
  height = 300*3.5,
  units = "px"
)


# find some example songs
bbd_tidy |> 
  count(word, sort = T) |>
  filter(n >= 860, n <= 880) |> 
  slice_sample(n = 200) |> 
  print(n = Inf)


# Dummy assessment example

df_test <- tibble(
  Mark = c(rnorm(40, 55, 6), rnorm(40, 54, 18)),
  Test = rep(c("Test 1", "Test 2"), each = 40)
)

df_test |> 
  group_by(Test) |> 
  summarise(
    min = min(Mark),
    mean = mean(Mark),
    median = median(Mark),
    max = max(Mark),
    range = max - min
  )

dummy_plot <- df_test |> 
  ggplot(aes(Test, Mark, color = Test)) +
  geom_point(position = position_jitter(width = .1)) +
  scale_colour_manual(
    guide = "none",
    values = c("#fe019a", "#0084FF")
  ) + 
  labs(x = "", y = "Mark") +
  scale_y_continuous(limits = c(0, 100)) +
  coord_capped_cart(left = "both") + 
  theme(axis.line.x = element_blank())

ggsave(
  here("images", "dummy_test_scatterplot.tiff"),
  device = "tiff",
  height = 300*4,
  width = 300*4,
  units = "px"
)

# Bivariate plots -------------------------------------

sharma <- here("data", "uk_accents_sharma_et_al.csv") |> 
  read_csv()

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
  scale_x_continuous(limits = c(3, 5.6), breaks = 1:7) +
  scale_y_continuous(limits = c(3, 5), breaks = 1:7) +
  geom_smooth(method = "lm", se = F) +
  theme_classic()

ggsave(
  here("images", "accents_sharma_scatterplot3.tiff"),
  device = "tiff",
  height = 300*4,
  width = 300*4,
  units = "px"
)

cov(sharma$Prestige, sharma$Attractiveness)
cor(sharma$Prestige, sharma$Attractiveness)


titanic |> 
  ggplot(aes(Sex, fill = Survived)) +
  geom_bar(position = "dodge", width = .7) +
  scale_fill_manual(values = c("black", "orange"))

titanic |> 
  ggplot(aes(Sex, fill = Survived)) +
  geom_bar(position = "fill", width = .7) +
  scale_fill_manual(values = c("black", "orange")) +
  labs(y = "proportion")










