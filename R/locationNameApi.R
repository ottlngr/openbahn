#' Find a location
#' 
#' \code{locationNameApi()} enables you to find locations and their respective IDs and coordinates known by the API.
#' 
#' @param query character, a city or train station to look for
#' @return A \code{list} containing the \code{path}, \code{response} and \code{content} of the \code{GET} request.
#' @details \code{locationNameApi()} uses the API key stored by \code{openbahn_auth}.
#' @author Philipp Ottolinger 
#' @references \url{http://data.deutschebahn.com/dataset/api-fahrplan}
#' @importFrom httr modify_url user_agent GET http_type content
#' @importFrom jsonlite fromJSON
#' @export locationNameApi
locationNameApi <- function(query) {

  if (missing(query)) {
    stop("No query string provided.", call. = FALSE)
  }

  openbahn_check_auth()

  base_url <- "https://open-api.bahn.de/bin/rest.exe/"
  api_path <- "bin/rest.exe/location.name"
  api_format <- "json"
  api_key <- Sys.getenv("OPENBAHN_KEY")

  request <- modify_url(base_url,
                        path = api_path,
                        query = list(authKey = api_key,
                                     format = api_format,
                                     input = query))

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
    class = "openbahn_locationName"
  )
}
