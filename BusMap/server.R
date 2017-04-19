#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(dplyr)

all_stops <- readRDS('../data/output/all_stops.RDS')
stations <- all_stops %>% filter(grepl(" STN ", stop))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$vanMap <- renderLeaflet({
    map <- leaflet(width = 400, height = 800) %>% addTiles %>% 
      setView(lng = -122.8,
                   lat = 49.2,
                   zoom = 11) %>% 
      addCircles(lat = stations$latitude,
                 lng = stations$longitude)
  })
})
