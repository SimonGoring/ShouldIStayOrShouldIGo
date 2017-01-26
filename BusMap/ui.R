#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("TransLink Walk or Wait"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("time",
                   "Hour of day:",
                   min = 0,
                   max = 24,
                   value = 12),
      selectInput('resolution',
                  'Choose the display resolution:',
                  c('Stop' = 'stop',
                    '1 Kilometer' = '1km',
                    '2 Kilometer' = '2km'))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       leafletOutput("vanMap")
    )
  )
))
