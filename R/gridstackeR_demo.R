#' Demo
#'
#' @description a short example of gridstackeR
#' @return an example shiny shinyApp that uses the gridstackeR package to create
#' a responsive layout with resizable and draggable boxes.
#'
#' @examples
#' \dontrun{
#' gridstackeR_demo()
#' }
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
