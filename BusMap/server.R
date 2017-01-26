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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$vanMap <- renderLeaflet({
    map <- leaflet(width = 400, height = 400) %>% addTiles %>% 
      setView(lng = -122.8,
                   lat = 49.2,
                   zoom = 11)
  })
})
