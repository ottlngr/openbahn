#' @export openbahn_auth
openbahn_auth <- function(key) {

  if (missing(key)) {
    stop("Please provide your API key.", call. = FALSE)
  }

  if (typeof(key) != "character") {
    stop("Please provide a character string.", call. = FALSE)
  }

  Sys.setenv(OPENBAHN_KEY = key)
  Sys.setenv(OPENBAHN_USER_AGENT = "http://github.com/ottlngr/openbahn")

}
