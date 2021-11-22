library(echarts4r) # charts
library(tidyverse) # general use
library(lubridate) # dates and times
library(prophet) # forecasting
library(nycflights13) # data
library(shiny)

e_common(font_family = "helvetica", theme = "westeros")


flightsUI <- function(id) {
  fluidPage(
  sliderInput(NS(id, "picktop"), "Top N", 1, 20, 15),
  echarts4rOutput(NS(id, "plottwo")),
)}


flight_server <- function (id) {
  moduleServer(id, function(input, output,session) {
    
reactiveflight <- reactive({
  top_destinations <- flights %>% 
    count(dest) %>% 
    top_n(input$picktop, n) %>% 
    arrange(n)
})
  
  output$plottwo <- renderEcharts4r({
    reactiveflight() %>%
    e_charts(x = dest) %>%
    e_bar(n, legend = FALSE, name = "Flights") %>% 
    e_labels(position = "right") %>% 
    e_tooltip() %>% 
    e_title("Flights by destination", "Top destinations") %>% 
    e_flip_coords() %>% 
    e_y_axis(splitLine = list(show = FALSE)) %>% 
    e_x_axis(show = FALSE) %>% 
    e_toolbox_feature(
      feature = "saveAsImage",
      title = "Save as image"
    )
  })
  })
}



ui <- fluidPage(
  flightsUI("first_flight")
)
server <- function(input, output, session) {
  flight_server("first_flight")
}
shinyApp(ui, server)

