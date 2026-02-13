# ---------------------------------------------------------
# file: create_pretty_knaflic_plot.R
# author: Jason Grafmiller
# date: 2026-02-11
# description:
# This code recreates the nicer version of the ticket trends plot from Knaflic (2016)
# ---------------------------------------------------------

# Setup -----------------------------------------------

# Load libraries
library(tidyverse)

# Load dataset
trends <- read_csv("data/knaflic_ticket_trend.csv")

# Abbreviate month names
trends <- trends |> 
  mutate(
    month_short = str_extract(month, "^...")
  )
 
# Setting the global theme
theme_set(theme_classic())


# First pass line plot --------------------------------

trends |> 
  ggplot(aes(
    x = reorder(month_short, month_num),
    y = number,
    colour = type,
    group = type
  )) +
  geom_line() 

# A simpler way might be to just plot the month_num directly on the x axis, and then change the axis labels. We'll start with that and come back to the labels

trends |> 
  ggplot(aes(
    x = month_num,
    y = number,
    colour = type,
    group = type
  )) +
  geom_line() 


# Add points to lines ---------------------------------

# In the nice plot there are points where the lines begin to diverge (august and after).
# We can add points to one a subset of the data by specifying the data inside the geom object.

# add points with `geom_point()`
trends |> 
  ggplot(aes(
    x = month_num,
    y = number,
    colour = type,
    group = type
  )) +
  geom_line() +
  geom_point(data = filter(trends, month_num >= 8)) 


# Add text around points ------------------------------

# Remember we also have to set a new aesthetic to tell which column in our data will be mapped to the text. We'll add an `aes()` inside `geom_text()` after the data
trends |> 
  ggplot(aes(
    x = month_num,
    y = number,
    colour = type,
    group = type
  )) +
  geom_line() +
  geom_point(data = filter(trends, month_num >= 8)) +
  geom_text(
    data = filter(trends, month_num >= 8),
    aes(label = number)
    )

# This is not great. We want to nudge our text off the lines. We saw how to do this with `nudge_y` in which we adjust the y position by a fixed number of space up or down. But what if we want to nudge some text (the received numbers) up and some text (the processed numbers) down?
 
# One way to do this is to go back to our data and add a new column telling us how much to nudge each observation. So we could add a 

trends$type

# So this alternates "received", "processed", ... Knowign this we could add a new column in several ways.

# the old-school 'base' R way:
trends$nudge <- c(15, -15, 15, -15, 15, -15, 15, -15, 15, -15, 15, -15, 15, -15, 15, -15, 15, -15, 15, -15, 15, -15, 15, -15)

# the tidyverse way:
trends <- trends |> 
  mutate(
    nudge = c(15, -15, 15, -15, 15, -15, 15, -15, 15, -15, 15, -15, 15, -15, 15, -15, 15, -15, 15, -15, 15, -15, 15, -15)
  )

# But these require us to type out all the values in the new column. This is ok here, but in a larger dataframe with hundreds or thousands of rows, that will not work. 
# Another approach is assign the new column values programmatically based on 
trends <- trends |> 
  mutate(
    nudge = ifelse(type == "received", 15, -15)
  )

# The `ifelse()` outputs one of two possible values depending on whether the test (here `type == "received"`) is TRUE or FALSE. This says, "create a new column `nudge` whose value is 15 if the corresponding `type` column value is 'received' (`type == "received"` is TRUE) and -15 if `type` is not 'received'" (`type == "received"` is FALSE). 

# Check
trends

# Now we add another aesthetic mapping for the `nudge_y` variable in `geom_text`
trends |> 
  ggplot(aes(
    x = month_num,
    y = number,
    colour = type,
    group = type
  )) +
  geom_line() +
  geom_point(data = filter(trends, month_num >= 8)) +
  geom_text(
    data = filter(trends, month_num >= 8),
    aes(label = number, nudge_y = nudge) # notice that it is inside `aes()`
  )


# Add vertical line -----------------------------------

# The lines begin diverging after May, so we add a line highlighting this

trends |> 
  ggplot(aes(
    x = month_num,
    y = number,
    colour = type,
    group = type
  )) +
  geom_vline(xintercept = 5, colour = "grey") + # add vertical grey line at x = 5 (may)
  geom_line() +
  geom_point(data = filter(trends, month_num >= 8)) +
  geom_text(
    data = filter(trends, month_num >= 8),
    aes(label = number, nudge_y = nudge) # notice that it is inside `aes()`
  ) 


# Polishing axis text and labels ----------------------

# Let's start with fixing the months on the x axis. 
# We'll edit the x axis with the `scale_x_continous()` layer. Note that we want to show months here, but the day itself is actually numbers (`month_num`) so this is a continous scale

trends |> 
  ggplot(aes(
    x = month_num,
    y = number,
    colour = type,
    group = type
  )) +
  geom_vline(xintercept = 5, colour = "grey") + # add vertical grey line at x = 5 (may)
  geom_line() +
  geom_point(data = filter(trends, month_num >= 8)) +
  geom_text(
    data = filter(trends, month_num >= 8),
    aes(label = number, nudge_y = nudge) # notice that it is inside `aes()`
  ) +
  scale_x_continuous(
    breaks = 1:12     # put ticks at position 1-12
  )

# now we set the labels for the ticks
trends |> 
  ggplot(aes(
    x = month_num,
    y = number,
    colour = type,
    group = type
  )) +
  geom_vline(xintercept = 5, colour = "grey") + # add vertical grey line at x = 5 (may)
  geom_line() +
  geom_point(data = filter(trends, month_num >= 8)) +
  geom_text(
    data = filter(trends, month_num >= 8),
    aes(label = number, nudge_y = nudge) # notice that it is inside `aes()`
  ) +
  scale_x_continuous(
    breaks = 1:12,     # put ticks at position 1-12
    labels = c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec") 
    )

# Now let's adjust the y axis limits. We'll use `scale_y_continuous()` for this.

trends |> 
  ggplot(aes(
    x = month_num,
    y = number,
    colour = type,
    group = type
  )) +
  geom_vline(xintercept = 5, colour = "grey") + # add vertical grey line at x = 5 (may)
  geom_line() +
  geom_point(data = filter(trends, month_num >= 8)) +
  geom_text(
    data = filter(trends, month_num >= 8),
    aes(label = number, nudge_y = nudge) # notice that it is inside `aes()`
  ) +
  scale_x_continuous(
    breaks = 1:12,     # put ticks at position 1-12
    labels = c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec") 
  ) +
  scale_y_continuous(
    limits = c(0, 300) # set the y value range from 0 to 300
  )

# Next we can set the axis titles. This is NOT done as part of the `scale_` layer, but with the `labs()` layer. We'll also add a title and subtitle. In this case, we want the title to communicate the main action that we want the intended audience, the company bosses, to take. The subtitle will describe the graph.

trends |> 
  ggplot(aes(
    x = month_num,
    y = number,
    colour = type,
    group = type
  )) +
  geom_vline(xintercept = 5, colour = "grey") + # add vertical grey line at x = 5 (may)
  geom_line() +
  geom_point(data = filter(trends, month_num >= 8)) +
  geom_text(
    data = filter(trends, month_num >= 8),
    aes(label = number, nudge_y = nudge) # notice that it is inside `aes()`
  ) +
  scale_x_continuous(
    breaks = 1:12,     # put ticks at position 1-12
    labels = c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec") 
  ) +
  scale_y_continuous(
    limits = c(0, 300) # set the y value range from 0 to 300
  ) +
  labs(
    x = "", # leave this blank as it is clear these are months
    y = "Number of tickets",
    title = "Please approve the hire of 2 FTEs",
    subtitle = "Ticket volume over time"
  )


# Changing colour -------------------------------------

# Just as with x and y scales, we can edit the scale of any aesthetic variable, including colour, fill, shape, etc.
# There are many predefined colour palettes such as `scale_colour_brewer(palette = "Dark2")`, but i like to set my colours manually. We'll add this layer to our plot:
# scale_colour_manual(values = c("darkblue", "darkgrey"))

trends |> 
  ggplot(aes(
    x = month_num,
    y = number,
    colour = type,
    group = type
  )) +
  geom_vline(xintercept = 5, colour = "grey") + 
  geom_line() +
  geom_point(data = filter(trends, month_num >= 8)) +
  geom_text(
    data = filter(trends, month_num >= 8),
    aes(label = number, nudge_y = nudge) 
  ) +
  scale_x_continuous(
    breaks = 1:12,     
    labels = c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec") 
  ) +
  scale_y_continuous(
    limits = c(0, 300) 
  ) +
  # colour palette values
  scale_colour_manual(values = c("darkblue", "darkgrey")) +
  #
  labs(
    x = "", 
    y = "Number of tickets",
    title = "Please approve the hire of 2 FTEs",
    subtitle = "Ticket volume over time"
  )


# Add type labels directly to lines -------------------

# Annotations can be added directly to ggplots with `annotate()`. 
# From the help description:
# > This function adds geoms to a plot, but unlike a typical geom function, the properties of the geoms are not mapped from variables of a data frame, but are instead passed in as vectors. This is useful for adding small annotations (such as text labels) or if you have your data in vectors, and for some reason don't want to put them in a data frame.

# We need to specify the following to add our text labels:
# - the type of geom we want to add, i.e. "text"
# - the x and y coordinates for our text
#   + note that we want to plot two labels, so we need sets of 2 x values and 2 y values, one for each label
# - `label` argument indicating the content of the text we are plotting
#   + we will have a vector of two labels, `c("Processed", "Received")`
# - we also want the colours to match the lines so we'll include that
# - we'll also include an `hjust = 0` argument to set the horizontal justification (alignment) of the text to the left. Alignment works like so 
#   + left: `hjust = 0`
#   + right: `hjust = 1`
#   + centre: `hjust = 0.5`

trends |> 
  ggplot(aes(
    x = month_num,
    y = number,
    colour = type,
    group = type
  )) +
  geom_vline(xintercept = 5, colour = "grey") + 
  geom_line() +
  geom_point(data = filter(trends, month_num >= 8)) +
  geom_text(
    data = filter(trends, month_num >= 8),
    aes(label = number, nudge_y = nudge) 
  ) +
  scale_x_continuous(
    breaks = 1:12,     
    labels = c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec") 
  ) +
  scale_y_continuous(
    limits = c(0, 300) 
  ) +
  # colour palette values
  scale_colour_manual(values = c("darkblue", "darkgrey")) +
  #
  labs(
    x = "", 
    y = "Number of tickets",
    title = "Please approve the hire of 2 FTEs",
    subtitle = "Ticket volume over time"
  ) +
  # ANNOTATION for ticket type label
  annotate(
    geom = "text", 
    label = c("Processed", "Received"),
    x = c(12.25, 12.25), # set this slightly to the right of the last point (12)
    y = c(140, 177), # match these to the numbers for december
    colour = c("darkblue", "grey40"),
    hjust = 0
  ) 



# Final plot ------------------------------------------

# Here we make some cosmetic tweaks

# - thicken the lines and increase size of points
# - remove the legend since we don't need it with the labels
# - add extra breaks (at multiples of 50) on the y axis
# - change the size and colours of our main title and y axis title
# - expand the x axis to the right to make room for the labels
# - add annotation for the blurb explaining how 2 employees quite. Putting this text directly on the plot allows us to take advantage of dual coding with images and words

# For the last part we'll use some functionality in another package, `ggtext`
install.packages("ggtext")
library(ggtext)
# The `ggtext` library gives us some additional functionality for working with so-called richtext that enables us to use html and markdown syntax in our plot text (https://www.markdownguide.org/cheat-sheet/). With this we can add line breaks, bold and italics, and other useful styling.


# I'll store this as `plot_final` then call it after
plot_final <- trends |> 
  ggplot(aes(
    x = month_num,
    y = number,
    colour = type,
    group = type
  )) +
  geom_vline(xintercept = 5, colour = "grey") + # add vertical grey line at x = 5 (may)
  geom_line(
    linewidth = 1        # thicken the line
    ) +
  geom_point(
    data = filter(trends, month_num >= 8),
    size = 3,            # increase the point size
    ) +
  geom_text(
    data = filter(trends, month_num >= 8),
    aes(label = number, nudge_y = nudge),
    size = 4            # change the text size (takes some trial and error)
  ) +
  scale_x_continuous(
    limits = c(1, 13),
    expand = expansion(add = c(0, 1)),
    breaks = 1:12,     # put ticks at position 1-12
    labels = c("jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec") 
  ) +
  scale_y_continuous(
    expand = expansion(mult = 0, add = 0),
    breaks = seq(0, 300, by = 50),
    limits = c(0, 300) # set the y value range from 0 to 300
  ) +
  scale_colour_manual(
    guide = "none",           # remove the guide (legend) since we don't need it
    values = c("darkblue", "grey40")
    ) +
  labs(
    x = "", # leave this blank as it is clear these are months
    y = "Number of tickets",
    title = "Please approve the hire of 2 FTEs",
    subtitle = "Ticket volume over time"
  ) +
  annotate(
    geom = "text", 
    label = c("Processed", "Received"),
    x = 12.25,
    y = c(140, 177),
    colour = c("darkblue", "grey40"),
    hjust = 0
  ) +
  # ANNOTATION for the blurb in richtext format
  annotate(
    geom = "richtext",     # this is the `geom_richtext` option
    label = "**2 employees quit in May**. We nearly kept up with incoming volume<br>
             in the following two months, but fell behind with the increase in Aug<br>
             and haven't been able to catch up since.",
    x = 3.5,
    y = 290,
    hjust = 0,            # left-aligned text
    vjust = 1,            # the vertical alignment. Here 1 is for top-aligned text
    label.color = NA      # tell it not to put a border around the text box
  ) +
  # now we change the 
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.title.y = element_text(colour = "grey30", hjust = 1),
    axis.ticks.x = element_blank(),
    axis.line = element_line(colour = "grey30"),
    axis.text = element_text(colour = "grey30")
  )

# Sjow the plot
plot_final

# Save the plot ---------------------------------------

# We'll use `ggsave()` to save our plot.
# Getting the right size and proportions can be tricky. I like to play around manually with resizing the plot until I get one I like, and then use that in my code so that I get the same result every time.  
# After some testing, I found a ratio of 400 height and 700 width to be nice. So I have a 4:7 height to width ratio, so I multiple 4*300 and 7*300 to get my dimensions and use units as "px".
 
ggsave(
  file = "images/knaflic_tickets_final_plot.png",
  plot = final_plot,
  device = "png",    # the kind of file, e.g. "png", "jpg", "pdf",...
  dpi = 300,         # resolution. 300 is a good default for print
  height = 1200,     # height of image in units
  width = 2100,      # width of image in units
  units = "px"       # units in pixels
)

# This method has worked well for me. If you're curious you can read more about the challenges of scaling ggplots here: https://tidyverse.org/blog/2020/08/taking-control-of-plot-scaling/


