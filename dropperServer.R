dropperServer <- function(id){
  moduleServer(
    id, 
    function(input, output, session) {
      
      selectedData2 <- reactive({
        iris[, c(input$xcol2, input$ycol2)]
      })
      
      clusters2 <- reactive({
        kmeans(selectedData2(), input$clusters2)
      })
      
      output$plot2 <- renderPlot({
        palette(c("#E41A1C", "#377EB8", "#4DAF4A",
                  "#984EA3", "#FF7F00", "#FFFF33",
                  "#A65628", "#F781BF", "#999999"))
        
        par(mar = c(5.1, 4.1, 0, 1))
        plot(selectedData2(),
             col = clusters2()$cluster,
             pch = 20, cex = 3)
        points(clusters2()$centers, pch = 4, cex = 4, lwd = 4)
      })
    }
  )
}