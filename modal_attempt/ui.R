#   ____________________________________________________________________________
#   UI                                                                      ####

library(shiny)
library(leaflet)
library(plotly)
library(shinyjs)
library(shinyBS)
library(echarts4r)
library(tidyverse) # general use
library(lubridate) # dates and times
library(prophet) # forecasting
library(nycflights13) # d

### . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ..
### Colors                                                                  ####

#C10250 purple
#03BCC0 green
#D2D945 yellow/green
#FCB040 orange
#FF5850 red
#436983 hipster blue

                   # ----------------------------------
                   # tab panel 1 - Home
                   tabPanel(" ",
                              htmlTemplate("modal_attempt.html",
                                           
                                           plot = plotOutput("dist"),
                                           slider = sliderInput("num", "Number of Points", 1, 100, 50)),
                                           
                              #flightDescription()
                            )
                   

