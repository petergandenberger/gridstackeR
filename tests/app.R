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
    column(width = 2,
           actionButton("save_grid_layout", "Save Layout"),
           actionButton("save_grid_layout_ns", "Save Layout (ns)"),
           actionButton("add_grid_element", "Add Element"),
           actionButton("load_grid_layout", "Load Layout"),
           actionButton("add_grid", "Add Grid"),
           actionButton("add_grid_element_nested", "Add Element to nested grid"),
           actionButton("remove_grid", "Remove Grid"),

           textOutput("result"),
           textOutput("result_ns")
    ),
    column(width = 10,
           grid_stack(
             id = "grid_stack_1",
             dynamic_full_window_height = TRUE,
             grid_stack_item(
               h = 2, w = 2, style = "overflow:hidden", id = "box1",
               box(
                 title = "gridstackeR", status = "success", solidHeader = TRUE, width = 12, height = "100%",
                 div("Box1")
               )
             ),
             grid_stack_item(
               x = 2, y = 0, h = 2, w = 2, style = "overflow:hidden", id = "box2",
               box(
                 title = "gridstackeR", status = "success", solidHeader = TRUE, width = 12, height = "100%",
                 div("Box2")
               )
             )
           )
    )
  )
)

server <- function(input, output, session) {
  # save_grid_layout ###########################################################
  observeEvent(input$save_grid_layout, {
    shinyjs::js$save_grid_layout(grid_id = "grid_stack_1")
  })

  output$result <- renderText({
    req(input$grid_stack_1_saved_layout)
    input$grid_stack_1_saved_layout
  })

  # save_grid_layout_ns ########################################################
  observeEvent(input$save_grid_layout_ns, {
    shinyjs::js$save_grid_layout(grid_id = "grid_stack_1", ns = 'ns_')
  })

  output$result_ns <- renderText({
    req(input$ns_grid_stack_1_saved_layout)
    input$ns_grid_stack_1_saved_layout
  })

  # add_grid_element ###########################################################
  observeEvent(input$add_grid_element, {
    element <- '{"w": 3, "h": 3, "id": "el_id"}'

    shinyjs::js$add_grid_element(grid_id = "grid_stack_1", element = element)

    insertUI(
      selector = "div[gs-id = 'el_id'] .grid-stack-item-content",
      where = "afterBegin",
      box(
        title = "newBox", status = "success", solidHeader = TRUE, width = 12, height = "100%",
        div("New Box Content")
      )
    )
  })

  # load_grid_layout ###########################################################
  observeEvent(input$load_grid_layout, {
    shinyjs::js$load_grid_layout(grid_id = "grid_stack_1", layout = '[
    {"id": "box1", "options":{"x": 2,"y": 0,"w": 5, "h": 5}},
    {"id": "box2", "options":{"x": 0,"y": 0,"w": 2, "h": 10}}
  ]')
  })

  # add_grid ###########################################################
  observeEvent(input$add_grid, {
    element <- '{"w": 3, "h": 3, "id": "el_id_grid_inner"}'

    shinyjs::js$add_grid_element(grid_id = "grid_stack_1", element = element)

    insertUI(
      selector = "div[gs-id = 'el_id_grid_inner'] .grid-stack-item-content",
      where = "afterBegin",
      box(
        title = "Nested Grid", status = "success", solidHeader = TRUE, width = 12, height = "100%",
        grid_stack(
          id = "grid_stack_new",
          dynamic_full_window_height = TRUE
        )
      )
    )
  })
  observeEvent(input$add_grid_element_nested, {
    id <- input$add_grid_element_nested
    element <- paste0('{"w": 3, "h": 3, "id": "el_id_element_nested', id, '"}')

    shinyjs::js$add_grid_element(grid_id = "grid_stack_new", element = element)

    insertUI(
      selector = paste0("div[gs-id = 'el_id_element_nested", id, "'] .grid-stack-item-content"),
      where = "afterBegin",
      box(
        title = paste0("nestedBox", id), status = "success", solidHeader = TRUE, width = 12, height = "100%",
        div("New Box Content nested")
      )
    )
  })

  # remove_grid ###########################################################
  observeEvent(input$remove_grid, {
    shinyjs::js$remove_grid(grid_id = "grid_stack_new")
  })
}

shinyApp(ui, server)
