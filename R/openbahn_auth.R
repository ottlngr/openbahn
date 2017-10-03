#' Store the API key in an environment variable
#' 
#' \code{openbahn_auth()} stores the API key in an environment variable to make it accessible for all \code{openbahn} functions.
#' 
#' @param key character, the API key provided by \url{http://data.deutschebahn.com/}
#' @details The API key is stored in the environment variable \code{OPENBAHN_KEY}. In addition, \code{openbahn_auth()} sets another environment variable (\code{OPENBAHN_USER_AGENT}) holding the user agent which is used for HTTP calls.
#' @author Philipp Ottolinger
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
