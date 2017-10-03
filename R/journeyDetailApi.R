#' Get details of a specific journey
#' 
#' \code{journeyDetailApi} returns detailed information on a journey found using \code{departureBoardApi()} or \code{arrivalBoardApi()}.
#' 
#' @param reference_url character, a reference url of a journey obtained using \code{departureBoardApi()} or \code{arrivalBoardApi()}.
#' @return A \code{list} containing the \code{path}, \code{response} and \code{content} of the \code{GET} request.
#' @details \code{journeyDetailApi()} uses the API key stored by \code{openbahn_auth}.
#' @author Philipp Ottolinger
#' @references \url{http://data.deutschebahn.com/dataset/api-fahrplan} 
#' 
#' @importFrom httr modify_url user_agent GET http_type content
#' @importFrom jsonlite fromJSON
#' @export journeyDetailApi
journeyDetailApi <- function(reference_url) {

  if (missing(reference_url)) {
    stop("No reference url provided.", call. = FALSE)
  }

  base_url <- "https://open-api.bahn.de/bin/rest.exe/"
  api_path <- "bin/rest.exe/journeyDetail"

  request <- reference_url

  ua <- user_agent(Sys.getenv("OPENBAHN_USER_AGENT"))

  response <- GET(request, ua)

  if (http_type(response) != "application/json") {
    stop("API did not return JSON.", .call = FALSE)
  }

  parsed <- fromJSON(content(response, "text"))

  structure(
    list(
      content = parsed,
      path = api_path,
      response = response
    ),
    class = "openbahn_journeyDetail"
  )

}
