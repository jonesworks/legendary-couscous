library(shiny)
source("/Users/a12517/Desktop/startbootstrap-agency-master/dropdown_mod.R")
ui <- fluidPage(
  dropperButton("dropper1")
)
server <- function(input, output, session) {
  dropperServer("dropper1")
}
shinyApp(ui, server)
