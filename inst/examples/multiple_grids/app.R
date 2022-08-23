library(gridstackeR)
library(shiny)
library(shinydashboard)
library(shinyjs)


ui <- dashboardPage(
  title = "gridstackeR Demo",
  dashboardHeader(),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    useShinyjs(),
    # make sure the content fills the given height
    tags$style(".grid-stack-item-content {height:100%;}"),
    tags$style(".grid-stack {background: gray; width: 45%; float:left;}"),

    grid_stack(
      id = "grid_stack_1",
      dynamic_full_window_height = TRUE,
      grid_stack_item(
        h = 2, w = 2, style = "overflow:hidden",
        box(
          title = "gridstackeR", status = "success", solidHeader = TRUE, width = 12, height = "100%",
          div("Drag and scale the Boxes as desired")
        )
      ),
      grid_stack_item(
        h = 4, w = 4, id = "plot_container", style = "overflow:hidden",
        box(
          title = "Histogram", status = "primary", solidHeader = TRUE, width = 12, height = "100%",
          plotOutput("plot", height = "auto")
        )
      ),
      grid_stack_item(
        h = 3, w = 4, minH = 3, maxH = 3, id = "slider", style = "overflow:hidden",
        box(
          title = "Inputs", status = "warning", solidHeader = TRUE, width = 12, height = "100%",
          sliderInput("slider", "Slider input:", 1, 100, 50)
        )
      )
    ),
    grid_stack(
      id = "grid_stack_2",
      dynamic_full_window_height = TRUE,
      grid_stack_item(
        h = 2, w = 2, style = "overflow:hidden",
        box(
          title = "gridstackeR", status = "success", solidHeader = TRUE, width = 12, height = "100%",
          div("Drag and scale the Boxes as desired")
        )
      )
    )
  )
)

server <- function(input, output, session) {

  output$plot <- renderPlot({
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$slider + 1)

    hist(x, breaks = bins, col = "#75AADB", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")

    },
    # set the height according to the container height (minus the margins)
    height = function() {max(input$plot_container_height - 80, 150)}
  )

  output$mytable <- DT::renderDataTable({
    DT::datatable(mtcars, options = list(
      # set the height according to the container height (minus the margins)
      scrollY = max(input$c_table_height, 200) - 110, paging = FALSE
      )
    )
  })
}

shinyApp(ui, server)
