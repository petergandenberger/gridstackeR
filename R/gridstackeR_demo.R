#' Demo
#'
#' @description
#' an short example of gridstackeR
#'
#' @export
gridstackeR_demo <- function() {
  if (!requireNamespace(package = "shiny"))
    message("Package 'shiny' is required to run this function")
  if (!requireNamespace(package = "shinydashboard"))
    message("Package 'shinydashboard' is required to run this function")
  if (!requireNamespace(package = "shinyjs"))
    message("Package 'shinyjs' is required to run this function")

  shiny::shinyAppDir(
    system.file(
      "examples/shinydashboard",
      package = 'gridstackeR',
      mustWork = TRUE
    )
  )
}
