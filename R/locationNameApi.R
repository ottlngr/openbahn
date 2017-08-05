#' @import httr
#' @import jsonlite
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
