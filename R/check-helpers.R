#' Checks whether the given parameter is an empty string
#' or adherece to the given check function
#'
#' @param x Object to check.
#' @param check_function the function to run if x is not an empty string
#'
#' @return TRUE if `x` is either an empty string, the result of the check_function else
#'
check_empty_string_or_ = function (x, check_function) {
  checkmate::assert_function(check_function)
  if(x == '') {
    return(TRUE)
  } else {
    return(check_function(x))
  }
}
