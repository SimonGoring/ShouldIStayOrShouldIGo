library(curl)
library(httr)
library(xml2)
library(leaflet)
library(dplyr)
library(purrr)
library(colorspace)

#  loading in the API key:
key <- scan('data/config.txt', what = 'character')

# Build the API query:
uri <- paste0('https://api.translink.ca/rttiapi/v1/stops?apikey=',
              key,
              '&lat=49.187706&long=-122.850060&radius=2000')

aa <- httr::GET(uri,
    content_type('application/JSON'))

stops <- xml2::as_list(xml2::read_xml(httr::content(aa, "text")))

stop_locs <- stops %>% 
  map(function(x)data.frame(stop = x$Name[[1]], 
                            longitude = as.numeric(x$Longitude[[1]]),
                            latitude = as.numeric(x$Latitude[[1]]),
                            stringsAsFactors = FALSE)) %>% 
  bind_rows()


# This is a very simple way of setting up a simple color scheme:
#  It's not how we'd do it in practice.
stop_locs$dist <- sqrt((49.187706 - stop_locs$latitude)^2 + (-122.850060 - stop_locs$longitude)^2)
cuts <- cut(stop_locs$dist, breaks = 12)
stop_locs$color <- diverge_hcl(12, h = c(255, 330), l = c(40, 90))[cuts]

# Now plot the map:
leaflet(stop_locs, 
        width = 800, 
        height = 400) %>% 
  addTiles %>% 
  setView(lng  = -122.850060,
          lat  = 49.187706,
          zoom = 13) %>% 
  addCircles(lat         = ~latitude,
             lng         = ~longitude,
             fillColor   = ~color,
             color       = '#000000',
             weight      = 1,
             fillOpacity = 1,
             opacity     = .6,
             radius      = 80)
