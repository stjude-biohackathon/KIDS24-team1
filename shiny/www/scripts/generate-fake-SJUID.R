#' Generate fake SJUID
#'
#' @param 
#' 
#'
#' @return
#' @export
#'
#' @examples
# Make this reproducible
set.seed(2024) 

# create vector of data$Sample.SJUID with some duplicates
generate_string <- function(length) {
  chars <- c(LETTERS, LETTERS, 0:9)
  paste0(sample(chars, length, replace = TRUE), collapse = "")
}

