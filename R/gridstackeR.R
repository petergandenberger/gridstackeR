#' Grid Stack Container
#'
#' @description
#' This acts as a container for the \link{grid_stack_item}'s.
#'
#' @param ... content to include in the container
#' @param id the id of the grid_stack container
#' @param opts grid options: check
#' \href{https://github.com/gridstack/gridstack.js/tree/master/doc#grid-options}{ gridstack documentation}
#' for more details
#' @param ncols number of columns for the grid (If you need > 12 columns you need to generate the CSS manually)
#' @param nrows number of rows for the grid
#'
#' @param dynamic_full_window_height if TRUE, the grid will change dynamically to fit the window size minus the \code{height_offset}
#' @param height_offset margin for the grid height, see \code{dynamic_full_window_height}
#' @return a grid_stack that can contain resizable and draggable \code{grid_stack_item}s
#'
#' @importFrom shiny div
#'
#' @examples
#' \dontrun{
#' library(gridstackeR)
#' library(shiny)
#' library(shinydashboard)
#' library(shinyjs)
#'
#'
#' ui <- dashboardPage(
#'   title = "gridstackeR Demo",
#'   dashboardHeader(),
#'   dashboardSidebar(disable = TRUE),
#'   dashboardBody(
#'     useShinyjs(),
#'     # make sure the content fills the given height
#'     tags$style(".grid-stack-item-content {height:100%;}"),
#'     grid_stack(
#'       dynamic_full_window_height = TRUE,
#'       grid_stack_item(
#'         h = 2, w = 2,
#'         box(
#'           title = "gridstackeR", status = "success", solidHeader = TRUE,
#'           width = 12, height = "100%",
#'           div("Drag and scale the Boxes as desired")
#'         )
#'       ),
#'       grid_stack_item(
#'         h = 4, w = 4, id = "plot_container",
#'         box(
#'           title = "Histogram", status = "primary", solidHeader = TRUE,
#'           width = 12, height = "100%",
#'           plotOutput("plot", height = "auto")
#'         )
#'       ),
#'       grid_stack_item(
#'         h = 3, w = 4, min_h = 3, max_h = 3, id = "slider",
#'         box(
#'           title = "Inputs", status = "warning", solidHeader = TRUE,
#'           width = 12, height = "100%",
#'           sliderInput("slider", "Slider input:", 1, 100, 50)
#'         )
#'       ),
#'       grid_stack_item(
#'         w = 4, h = 10, x = 0, y = 0, id = "c_table",
#'         DT::dataTableOutput("mytable")
#'       )
#'     )
#'   )
#' )
#'
#' server <- function(input, output, session) {
#'
#'   output$plot <- renderPlot({
#'     x    <- faithful$waiting
#'     bins <- seq(min(x), max(x), length.out = input$slider + 1)
#'
#'     hist(x, breaks = bins, col = "#75AADB", border = "white",
#'          xlab = "Waiting time to next eruption (in mins)",
#'          main = "Histogram of waiting times")
#'
#'   },
#'   # set the height according to the container height (minus the margins)
#'   height = function() {max(input$plot_container_height - 80, 150)}
#'   )
#'
#'   output$mytable <- DT::renderDataTable({
#'     DT::datatable(mtcars, options = list(
#'       # set the height according to the container height (minus the margins)
#'       scrollY = max(input$c_table_height, 200) - 110, paging = FALSE
#'     )
#'     )
#'   })
#' }
#'
#' shinyApp(ui, server)
#'
#' }
#'
#' @export
grid_stack <- function(..., id = "gridstackeR-grid", opts = "{cellHeight: 70}", ncols = 12,
                       nrows = 12, dynamic_full_window_height = FALSE, height_offset = 0) {
  assert_integerish(ncols, lower = 0, len = 1, any.missing = FALSE)
  assert_integerish(nrows, lower = 0, len = 1, any.missing = FALSE)
  assert_flag(dynamic_full_window_height)
  assert_numeric(height_offset, len = 1, any.missing = FALSE)
  assert_string(id)
  shiny::addResourcePath("gridstackeR_utils", system.file("assets", package = "gridstackeR"))

  htmltools::tagList(
    htmltools::htmlDependency(
      name = "gridstack",
      version = "4.2.3",
      package = "gridstackeR",
      src = "assets",
      script = c("gridstackjs/gridstack-h5.js", "gridstackeR.js"),
      stylesheet = "gridstackjs/gridstack.min.css"
    ),
    div(
      class = "grid-stack",
      id = id,
      ...
    ),
    shiny::tags$script(
      paste0("initGridstackeR(", opts, ", '", id, "', ", ncols, ", ", nrows, ", ",
             ifelse(dynamic_full_window_height, "true", "false"), ", ", height_offset, ");")
    ),

    shinyjs::useShinyjs(),
    shinyjs::extendShinyjs(script = file.path("gridstackeR_utils", "gridstackeR_utils.js"),
                           functions = c("load_grid_layout", "save_grid_layout",
                                         "add_grid_element", "remove_grid_element",
                                         "remove_all_grid_elements", "load_grid",
                                         "remove_grid"))
  )
}

#' Grid Stack Item
#'
#' @description
#' This is a wrapper for the individual items to be displayed in the \link{grid_stack}
#' Check the \href{https://github.com/gridstack/gridstack.js/tree/master/doc#item-options}{ gridstack documentation}
#' for more information.
#'
#' The default for all parameters is an empty string, this will make them disappear for gridstackjs
#'
#' @param ... content to include in the grid stack item
#' @param id the id of the item, used for save and load functions, this param is propagated through to lower levels
#' @param auto_position if set to TRUE x and y attributes are ignored and the element is placed to the first
#' available position. Having either x or y missing will also do that
#' @param x,y element position in columns/rows.
#' Note: if one is missing this will \code{auto_position} the item
#' @param w,h element size in columns/rows
#' @param max_w,min_w,max_h,min_h element constraints in column/row (default none)
#' @param locked means another widget wouldn't be able to move it during dragging or resizing.
#' The widget can still be dragged or resized by the user.
#' You need to add \code{no_resize} and \code{no_move} attributes to completely lock the widget.
#' @param no_resize if set to TRUE it disables element resizing
#' @param no_move if set to TRUE it disables element moving
#' @param resize_handles - widgets can have their own custom resize handles.
#' For example 'e,w' will make that particular widget only resize east and west.
#'
#' @return a grid_stack_item to be placed inside a \code{grid_stack}. This item is resizable and draggable by default.
#'
#' @examples
#' \dontrun{
#' grid_stack_item(
#' h = 2, w = 2,
#' box(
#'   title = "gridstackeR", status = "success", solidHeader = TRUE, width = 12, height = "100%",
#'   div("Drag and scale the Boxes as desired")
#' )
#' )
#' }
#'
#' @importFrom shiny div
#' @export
#'
grid_stack_item <- function(..., id = NULL, auto_position = NULL,
                            x = NULL, y = NULL, w = NULL, h = NULL,
                            max_w = NULL, min_w = NULL, max_h = NULL, min_h = NULL,
                            locked = NULL, no_resize = NULL, no_move = NULL,
                            resize_handles = NULL, hide_overflow = TRUE) {

  assert_string(id, null.ok = TRUE)
  assert_string(resize_handles, null.ok = TRUE)
  sapply(c(auto_position, locked, no_resize, no_move), assert_logical, null.ok = TRUE)
  sapply(c(x, y, w, h, max_h, max_w, min_h, min_w), assert_integerish, any.missing = FALSE, len = 1, null.ok = TRUE)
  if (!(is.null(max_h) & is.null(min_h))) assert_true(max_h >= min_h)
  if (!(is.null(max_w) & is.null(min_w))) assert_true(max_w >= min_w)

  arg_list <- lapply(
    list(
      "id" = id, "resize_handles" = resize_handles, "auto_position" = auto_position, "locked" = locked,
      "no_resize" = no_resize, "no_move" = no_move, "x" = x, "y" = y, "w" = w, "h" = h, "max_h" = max_h, "max_w" = max_w,
      "min_h" = min_h, "min_w" = min_w
    ),
    function(x) ifelse(is.null(x), '', as.character(x))
  )

  div(
    class = "grid-stack-item", 'gs-id' = arg_list$id,
    'gs-auto-position' = arg_list$auto_position, 'gs-w' = arg_list$w, 'gs-h' = arg_list$h, 'gs-x' = arg_list$x,
    'gs-y' = arg_list$y, 'gs-max-w' = arg_list$max_w, 'gs-min-w' = arg_list$min_w, 'gs-max-h' = arg_list$max_h,
    'gs-min-h' = arg_list$min_h, 'gs-locked' = arg_list$locked, 'gs-no-resize' = arg_list$no_resize,
    'gs-no-move' = arg_list$no_move, 'gs-resize-handles' = arg_list$resize_handles,
    div(
      class = "grid-stack-item-content",
      id = id,
      style = if(hide_overflow) "overflow:hidden;" else "",
      ...
    )
  )
}
