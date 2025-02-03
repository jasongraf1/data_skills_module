# ----------------------------------------------------------------------------
# file: create_anscombe_plots.R
# author: Jason Grafmiller
# date: 2025-02-03
# description:
# Make the plots illustrating the anscombe quartet
# ----------------------------------------------------------------------------

library(ggplot2)

# set nice theme
theme_set(theme_classic())

# make plot for each set
p1 <- anscombe |> 
  ggplot(aes(x1, y1)) +
  geom_smooth(method = "lm", se = F, formula = y ~ x) +
  geom_point(color = "darkorange3", size = 4) +
  labs(x = "x", y = "y")

p2 <- anscombe |> 
  ggplot(aes(x2, y2)) +
  geom_smooth(method = "lm", se = F, formula = y ~ x) +
  geom_point(color = "darkorange3", size = 4) +
  labs(x = "x", y = "y")

p3 <- anscombe |> 
  ggplot(aes(x3, y3)) +
  geom_smooth(method = "lm", se = F, formula = y ~ x) +
  geom_point(color = "darkorange3", size = 4) +
  labs(x = "x", y = "y")

p4 <- anscombe |> 
  ggplot(aes(x4, y4)) +
  geom_smooth(method = "lm", se = F, formula = y ~ x) +
  geom_point(color = "darkorange3", size = 4) +
  labs(x = "x", y = "y")


# Use `patchwork` package to combine plots
library(patchwork)

(p1 + p2) / (p3 + p4)
