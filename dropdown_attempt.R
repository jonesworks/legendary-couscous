cooldropdown <- function() {
 tagList(
    tags$h2("pickerInput in dropdown"),
    br(),
    dropdown(
      
      tags$h3("List of Input"),
      
      pickerInput('xcol2',
                  label = 'X Variable',
                  choices = names(iris),
                  options = list(`style` = "btn-info")),
      
      pickerInput('ycol2',
                  label = 'Y Variable',
                  choices = names(iris),
                  selected = names(iris)[[2]],
                  options = list(`style` = "btn-warning")),
      
      sliderInput('clusters2',
                  label = 'Cluster count',
                  value = 3,
                  min = 1, max = 9),
    style = "unite", icon = icon("gear"),
    status = "danger", width = "300px")
 )
}
