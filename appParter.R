hoodDescription <- function() {
  tagList(
    div(class = "container",
        h1("Neighborhood Browser", class = "title fit-h1"),
        p("You are new to New York City or real estate investment? Use Intelligentsia's neighborhood browser to identify pockets of opportunity in the city."),
        p("Use the map to browse New York City's gentrifying census tracts. Click on any one of them to get more detailed information. Use the slider to show only the top k tracts."),
        fluidRow(
          column(7,
                 br(),
                 thingUI("first")
                 )
          )
        )
    )
}
