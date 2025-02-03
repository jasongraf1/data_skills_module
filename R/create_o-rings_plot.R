# ----------------------------------------------------------------------------
# file: create_o-rings_plot.R
# author: Jason Grafmiller
# date: 2025-02-03
# description:
# Create visualisatoin of shuttle O-rings data
# ----------------------------------------------------------------------------

library(tidyverse)
library(lemon) # for freshening up ggplots

theme_set(theme_classic())

# The package DAAG has a dataset called `orings` which contains data on 
# temperatures and O-ring damage during launches prior to the Challenger incident. 
library(DAAG)

orings

# The documentation will tell us a bit about the data
help(orings)

# Let's first create a new column of temperature in Celsius. We'll also create
# a column indicating whether the shuttle launched or not 

orings <- orings |> 
  mutate(
    Temp_C = (Temperature - 32) * 5/9,
    Launch = ifelse(Total == 0, "yes", "no")
  )

orings

# Now let's create a simple scatterplot showing temperature on the x-axis
# and amount of damage (number of incidents) on the y-axis. Colour the points
# by launch

(p <- orings |> 
    ggplot(aes(x = Temp_C, y = Total)) +
    geom_point(aes(color = Launch), position = position_jitter(height = .1), size = 3) +
    labs(x = 'Temperature (C) of joints at time of launch', y = 'O-Ring Damage') +
    scale_x_continuous(limits = c(9, 29.5), breaks = seq(10, 30, 2)) +
    scale_y_continuous(limits = c(-.2, 6), breaks = 0:6) +
    scale_color_manual(guide = "none", values = c("red3", "green4")) +
    theme(
      axis.title.x = element_text(face = "bold", margin = margin(20, 0, 0, 0),
                                  size = 14),
      axis.title.y = element_text(face = "bold", margin = margin(0, 20, 0, 0),
                                  size = 14)
    )
)

p + 
  geom_smooth(se = F, formula = y ~ x)

p + # Modify the x and y limits
  geom_smooth(se = F, formula = y ~ x) +
  scale_x_continuous(limits = c(-3.88, 29.5), breaks = seq(-5, 30, 5)) +
  # Add a red rectangle for the forecasted temperature on launch day
  annotate("rect", xmin = -3.33, xmax = -1.667,  ymin = 0, ymax = 6,
           alpha = 0.3, fill = "red") +
  # Add text
  annotate("text", x = 2, y = 3, fontface = "bold", color = "red",
           label = "Forecast \n temperature \n on launch day \n -3° to -1.5° C")
