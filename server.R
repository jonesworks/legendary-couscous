server <- function(input, output){
  output$dist <- renderPlot({
    x <- rnorm(input$num)
    y <- rnorm(input$num)
    z = as.data.frame(cbind(x,y))
    ggplot(z, aes(x,y)) +
      geom_point()
    #plot_ly(data = z, x = x, y = y, type = "scatter", mode = "markers", marker = list(size = 10, color = "black")) 
    
  })
  
  data <- data.frame(x = rnorm(10, 5, 3), y = rnorm(10, 50, 12), z = rnorm(10, 50, 5))
  
  react <- eventReactive(input$add, {
    set.seed(sample(1:1000, 1))
    data.frame(x = rnorm(10, 5, 2), y = rnorm(10, 50, 10))
  })
  
  output$plot <- renderEcharts4r({
    data |> 
      e_charts(x) |> 
      e_scatter(y) |>
      e_scatter(z) |> 
      e_brush(throttleDelay = 1000)
  })
  
  observeEvent(input$add, {
    echarts4rProxy("plot") |> 
      e_append1_p(0, react(), x, y)
  })
  
  output$selected <- renderPrint({
    input$plot_brush
  })

  thing_server("what")
  
  output$data <- renderTable({
    mtcars[, c("mpg", input$variable), drop = FALSE]
  }, rownames = TRUE)

  output$result <- renderText({
    paste("You chose", input$state)
  })
  
  output$resulttwo <- renderText({
    paste("You chose", input$stateone)
  })
    
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
    
    thing_server("first")
    thing_server("second")
    thing_server("third")
    #flight_server("first_flight")
    
    #ass_server("thing")
    
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
        e_title("Flights by destination", "Top Destinations") %>% 
        e_flip_coords() %>% 
        e_y_axis(splitLine = list(show = FALSE)) %>% 
        e_x_axis(show = FALSE) %>% 
        e_toolbox_feature(
          feature = "saveAsImage",
          title = "Save as image"
        )
    })
    
    a <- rnorm(100)
    b <- rnorm(100)
    
    output$plotter <- renderPlot({
      if (input$plotType == "scatter") {
        r = as.data.frame(cbind(a,b))
        ggplot(r, aes(a,b)) +
          geom_point()
      } else {
        breaks <- 30
        ggplot() 
          geom_histogram(aes(a), bins = breaks)
        
        if (breaks == "custom") {
          breaks <- input$breakCount
        }
        ggplot() +
          geom_histogram(aes(a), bins = input$breakCount)
      }
    })
    
}
  
