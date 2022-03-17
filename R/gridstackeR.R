#' Grid Stack Container
#'
#' @description
#' This acts as a container for the \link{grid_stack_item}'s.
#'
#' @param ... content to include in the container
#' @param opts grid options: check
#' \href{https://github.com/gridstack/gridstack.js/tree/master/doc#grid-options}{ gridstack documentation}
#' for more details
#' @param ncols number of columns for the grid (If you need > 12 columns you need to generate the CSS manually)
#' @param nrows number of rows for the grid
#'
#' @param dynamic_full_window_height if TRUE, the grid will change dynamically to fit the window size minus the \code{height_offset}
#' @param height_offset margin for the grid height, see \code{dynamic_full_window_height}
#'
#' @importFrom shiny div
#'
#' @export
grid_stack <- function(..., opts = "{cellHeight: 70}", ncols = 12,
                       nrows = 12, dynamic_full_window_height = FALSE, height_offset = 0) {
  assert_integerish(ncols, lower = 0, len = 1, any.missing = FALSE)
  assert_integerish(nrows, lower = 0, len = 1, any.missing = FALSE)
  assert_logical(dynamic_full_window_height)
  assert_numeric(height_offset)

  tagList(
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
      id = "gridstackeR-grid",
      ...
    ),
    shiny::tags$script(
      paste0("initGridstackeR(", opts, ", ", ncols, ", ", nrows, ", ",
             ifelse(dynamic_full_window_height, "true", "false"), ", ", height_offset, ");")
    ),
    shinyjs::useShinyjs(),
    shinyjs::extendShinyjs(functions = c("load_grid_stack_layout"),
      text = "shinyjs.load_grid_stack_layout = function(layout){loadLayout(layout);}")
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
#' @param autoPosition if set to TRUE x and y attributes are ignored and the element is placed to the first
#' available position. Having either x or y missing will also do that
#' @param x,y element position in columns/rows.
#' Note: if one is missing this will \code{autoPosition} the item
#' @param w,h element size in columns/rows
#' @param maxW,minW,maxH,minH element constraints in column/row (default none)
#' @param locked means another widget wouldn't be able to move it during dragging or resizing.
#' The widget can still be dragged or resized by the user.
#' You need to add \code{noResize} and \code{noMove} attributes to completely lock the widget.
#' @param noResize if set to TRUE it disables element resizing
#' @param noMove if set to TRUE it disables element moving
#' @param resizeHandles - widgets can have their own custom resize handles.
#' For example 'e,w' will make that particular widget only resize east and west.
#'
#' @importFrom shiny div
#' @export
#'
grid_stack_item <- function(..., id = NULL, autoPosition = NULL,
                            x = NULL, y = NULL, w = NULL, h = NULL,
                            maxW = NULL, minW = NULL, maxH = NULL, minH = NULL,
                            locked = NULL, noResize = NULL, noMove = NULL, resizeHandles = NULL) {

  assert_string(id, null.ok = TRUE)
  assert_string(resizeHandles, null.ok = TRUE)
  sapply(c(autoPosition, locked, noResize, noMove), assert_logical, null.ok = TRUE)
  sapply(c(x, y, w, h, maxH, maxW, minH, minW), assert_integerish, any.missing = FALSE, len = 1, null.ok = TRUE)
  if (!(is.null(maxH) & is.null(minH))) assert_true(maxH >= minH)
  if (!(is.null(maxW) & is.null(minW))) assert_true(maxW >= minW)

  arg_list <- lapply(
    list(id, resizeHandles, autoPosition, locked, noResize, noMove, x, y, w, h, maxH, maxW, minH, minW),
    function(x) ifelse(is.null(x), '', x)
  )

  div(
    class = "grid-stack-item", 'gs-id' = arg_list$id,
    'gs-auto-position' = arg_list$autoPosition, 'gs-w' = arg_list$w, 'gs-h' = arg_list$h, 'gs-x' = arg_list$x,
    'gs-y' = arg_list$y, 'gs-max-w' = arg_list$maxW, 'gs-min-w' = arg_list$minW, 'gs-max-h' = arg_list$maxH,
    'gs-min-h' = arg_list$minH, 'gs-locked' = arg_list$locked, 'gs-no-resize' = arg_list$noResize,
    'gs-no-move' = arg_list$noMove, 'gs-resize-handles' = arg_list$resizeHandles,
    div(
      class = "grid-stack-item-content",
      id = id,
      ...
    )
  )
}








