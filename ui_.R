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

source("example of modularized conditional.R")
source("attempt.R")
source("appParter.R")
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
                            includeHTML("index_.html"),
                                #flightDescription(),
                                  div(class = "container",
                                  sliderInput("num", "Number of Points", 1, 1000, 50),
                                  br(),
                                  plotOutput("dist")),
                            
                              neighborhoodDescription(),
                                          actionButton("add", "Add Data to y"),
                                          echarts4rOutput("plot"),
                              selectInput("variable", "Variable:",
                                          c("Cylinders" = "cyl",
                                            "Transmission" = "am",
                                            "Gears" = "gear")),
                              tableOutput("data"),
                             # includeHTML("modal.html"),
                              selectInput("state", "Choose a state:",
                                          list(`East Coast` = list("NY", "NJ", "CT"),
                                               `West Coast` = list("WA", "OR", "CA"),
                                               `Midwest` = list("MN", "WI", "IA"))
                              ),
                              textOutput("result"),
                              #neighborhoodDescription(),
                              htmlTemplate("modal.html",
                                           
                                           slider = sliderInput("picktop", "Top N", 1, 20, 15),
                                           plot = echarts4rOutput("plottwo"),
                                           #),
                              #conditionalp(),
                            conditionals = div(class = "container",
                                tags$section(class = "container",
                                               selectInput("plotType", "Plot Type",
                                                           c(Scatter = "scatter", Histogram = "hist")
                                               ),
                                               # Only show this panel if the plot type is a histogram
                                               conditionalPanel(
                                                 condition = "input.plotType == 'hist'",
                                                 selectInput(
                                                   "breaks", "Breaks",
                                                   c("Sturges", "Scott", "Freedman-Diaconis", "[Custom]" = "custom")
                                                 ),
                                                 # Only show this panel if Custom is selected
                                                 conditionalPanel(
                                                   condition = "input.breaks == 'custom'", 
                                                   sliderInput("breakCount", "Break Count", min = 1, max = 50, value = 10)
                                                 )
                                               )
                                             )),
                                               plotting = plotOutput("plotter")
                                             ))
                                
                                           
                              #hoodDescription()
                            #note this also works with function firstDescription
                            
                   

