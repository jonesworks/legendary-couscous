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
