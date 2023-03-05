#' Checks that all given arguments are \code{grid_stack_item}s
#'
#' @param ... arguments to be checked
#'
#' @return TRUE if arguments are valid \code{grid_stack_item}s, FALSE otherwise
check_grid_stack_item_list <- function(...) {
  grid_stack_item_list <- list(...)
  for(item in grid_stack_item_list) {
    if(is.null(item$name) || item$name != 'div') {
      return(FALSE)
    }
    if(is.null(item$attribs$class) || item$attribs$class != "grid-stack-item") {
      return(FALSE)
    }
  }
  return(TRUE)
}
