histogramUI <- function(id, df) {
  tagList(
    selectInput(NS(id, "var"), "Variable", names(df)),
    numericInput(NS(id, "bins"), "bins", 10, min = 1),
    plotOutput(NS(id, "hist"))
  )
}

histogramServer <- function(id, df) {
  moduleServer(id, function(input, output, session) {
    data <- reactive(df[[input$var]])
    output$hist <- renderPlot({
      hist(data(), breaks = input$bins, main = input$var)
    }, res = 96)
  })
}

ui <- fluidPage(
  tabsetPanel(
    tabPanel("mtcars", histogramUI("mtcars", mtcars)),
    tabPanel("iris", histogramUI("iris", iris))
  )
)
server <- function(input, output, session) {
  histogramServer("mtcars", mtcars)
  histogramServer("iris", iris)
}

shinyApp(ui, server) 
