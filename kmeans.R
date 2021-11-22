kmeans_clusting = function() {
  
  
  library("shiny")
  library("shinyWidgets")
  
    fluidPage(
      tagList(
        div(class = "container",
            tags$h2("pickerInput in dropdown"),
            br(),
            dropdown(
              
              tags$h3("List of Input"),
              
              pickerInput(inputId = 'xcol2',
                          label = 'X Variable',
                          choices = names(iris),
                          options = list(`style` = "btn-info")),
              
              pickerInput(inputId = 'ycol2',
                          label = 'Y Variable',
                          choices = names(iris),
                          selected = names(iris)[[2]],
                          options = list(`style` = "btn-warning")),
              
              sliderInput(inputId = 'clusters2',
                          label = 'Cluster count',
                          value = 3,
                          min = 1, max = 9),
              
              style = "unite", icon = icon("gear"),
              status = "danger", width = "300px",
              animate = animateOptions(
                enter = animations$fading_entrances$fadeInLeftBig,
                exit = animations$fading_exits$fadeOutRightBig
              )
            ),
            
            plotOutput(outputId = 'plot2')
        )
      )
  )
}
kmeans_clust()
