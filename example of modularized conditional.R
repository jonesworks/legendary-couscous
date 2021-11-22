thingUI <- function(id) {
  ns=NS(id)
  fluidRow(
  sidebarPanel(
    selectInput(NS(id, "plotType"), "Plot Type",
                c(Scatter = "scatter", Histogram = "hist")
    ),
    # Only show this panel if the plot type is a histogram
    conditionalPanel(
      condition = "input.plotType == 'hist'", ns=ns,
      selectInput(
        NS(id, "breaks"), "Breaks",
        c("Sturges", "Scott", "Freedman-Diaconis", "[Custom]" = "custom")
      ),
      # Only show this panel if Custom is selected
      conditionalPanel(
        condition = "input.breaks == 'custom'", ns=ns,
        sliderInput(NS(id, "breakCount"), "Break Count", min = 1, max = 50, value = 10)
      )
    )
  ),
  div(class = "container",
      br(),
      hr(),
    plotOutput(NS(id, "plots")) %>% withSpinner())
  )
}

thing_server <- function (id) {
  moduleServer(id, function(input, output,session) {
  x <- rnorm(100)
  y <- rnorm(100)
  
  output$plots <- renderPlot({
    if (input$plotType == "scatter") {
      s = as.data.frame(cbind(x,y))
      ggplot(s, aes(x,y)) +
        geom_point()
    } else {
      breaks <- 30
      ggplot() 
      geom_histogram(aes(ax), bins = breaks)
      
      if (breaks == "custom") {
        breaks <- input$breakCount
      }
      ggplot() +
        geom_histogram(aes(x), bins = input$breakCount)
    }
  })
}
)}

ui <- fluidPage(
  thingUI("hist1")
)
server <- function(input, output, session) {
  thing_server("hist1")
}
shinyApp(ui, server)  
