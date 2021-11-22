server <- function(input, output){
  output$dist <- renderPlot({
    x <- rnorm(input$num)
    y <- rnorm(input$num)
    plot(x,y)
  })
  
  
    
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
    
}
  
