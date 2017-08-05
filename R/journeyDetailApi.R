#' @import httr
#' @import jsonlite
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
