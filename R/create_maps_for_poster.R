# ---------------------------------------------------------
# file: create_maps_for_poster.R
# author: Jason Grafmiller
# date: 2026-03-03
# description:
# Create maps of the UK and the WM regions sampled in the More than Words
# project. 
# ---------------------------------------------------------

# Libraries
library(tidyverse)
library(leaflet)
library(sf)
library(maptiles)
library(ggspatial)
library(mapview)


# Create the dataframe of locations -------------------

# Lat and Lng collected by hand from google maps 
df <- tibble(
  name = c("Birmingham", "Solihull", "Rubery", "Wolverhampton", 
           "Coventry", "Walsall", "Wednesbury", "Sandwell", "Redditch"),
  lat = c(52.481, 52.412, 52.397, 52.583, 52.408, 52.582, 52.5495, 52.522, 52.306),
  lng = c(-1.897, -1.779, -2.0155, -2.129, -1.510, -1.983, -2.021, -2.013, -1.937)
  ) |> 
  mutate(
    include_label = ifelse(name %in% c("Rubery", "Wednesbury", "Sandwell"), TRUE, FALSE)
  )


# Make the maps ---------------------------------------

# 1) Read shapefile (point to the .shp; sidecar files must sit beside it)
areas <- st_read(dsn = "C:/Users/grafmilj/Dropbox/research/Be_sat-stood/data_raw/SHAPE/Areas.shp")

# 2) Leaflet expects lon/lat WGS84
areas_ll <- st_transform(areas, 4326)

# Create plot of just the UK with West Midlands area highlighted
areas_col <- areas|> 
  mutate(color = ifelse(name %in% c("B", "CV", "DY", "WR", "WS", "WV"), "b", "a"))

(map_uk <- ggplot(areas_col) +
  geom_sf(aes(fill = color)) +
  # geom_sf_text(aes(label = name), size = 2) +
  scale_fill_manual(guide = "none", values = c("grey90", "#0e68e3")) +
  theme_void()
)

ggsave(
  file = "C:/Users/grafmilj/Dropbox/research/West_Midlands/uk_map.png",
  plot = map_uk,
  dpi = 300,
  width = 300*6,
  height = 300*3,
  units = "px"
)

# Create local plot

map_local <- leaflet(df) |>
  addProviderTiles(providers$CartoDB.PositronNoLabels) |>
  addProviderTiles(providers$CartoDB.PositronOnlyLabels, group = "Labels") |>
  addMarkers( ~lng, ~lat) |> 
  addLabelOnlyMarkers(
    data = subset(df, include_label == TRUE),
    ~lng, ~lat,
    label = ~name,
    labelOptions = labelOptions(
      noHide = TRUE,
      direction = "right",
      textOnly = TRUE,
      offset = c(5, 0)
    )
  ) |> 
  addLayersControl(overlayGroups = c("Labels"),
                   options = layersControlOptions(collapsed = TRUE)) |> 
  # setView(lng = -1.8904, lat = 52.4862, zoom = 9)
  setMaxBounds(-2.1, 52.8, -1.6, 52.2)

map_local

mapshot(
  map_local,
  file = "C:/Users/grafmilj/Dropbox/research/West_Midlands/birmingham_map.png",
  vwidth = 600,
  vheight = 450
)


# Static version --------------------------------------

# your points
pts <- st_as_sf(df, coords = c("lng", "lat"), crs = 4326)

# put everything in Web Mercator (nice for web tiles)
areas_3857 <- st_transform(areas, 3857)
pts_3857   <- st_transform(pts,   3857)


