library(gridstackeR)
library(shiny)
library(shinydashboard)
library(shinyjs)


ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    useShinyjs(),
    # make sure the content fills the given height
    tags$style(".grid-stack-item-content .col-sm-12{height:100%;}"),
    actionButton("save", "Save"),
    actionButton("load", "Load"),
    grid_stack(
      grid_stack_item(
        h = 4, w = 4, id = "1", style = "overflow:hidden",
        div("hi")
      ),
      grid_stack_item(
        h = 3, w = 4, minH = 3, maxH = 3, id = "2", style = "overflow:hidden",
        div("hi2")
      )
    )
  )
)

server <- function(input, output, session) {

  output$plot3 <- renderPlot({
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$slider + 1)

    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")

  }, height = function() {max(input$plot_container_height - 80, 150)}
  )

  observeEvent(input$save, {
    print(js$save_grid_stack())
  })

  observeEvent(input$load, {
    js$load_grid_stack('[
  {
    "w": 4,
    "h": 4,
    "id": "1",
    "x": 5,
    "y": 0,
    "content": "\n              <div>hi</div>\n            "
  },
  {
    "w": 4,
    "h": 3,
    "maxH": 3,
    "minH": 3,
    "id": "2",
    "x": 4,
    "y": 4,
    "content": "\n              <div>hi2</div>\n            "
  }
]')
  })



}

shinyApp(ui, server)
