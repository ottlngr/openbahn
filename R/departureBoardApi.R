#' @import httr
#' @import jsonlite
#' @export departureBoardApi
departureBoardApi <- function(id, date, time) {
  if (missing(id)) {
    stop("No id provided.", call. = FALSE)
  }
  if (missing(date)) {
    stop("No date provided.", call. = FALSE)
  }
  if (missing(time)) {
    stop("No time provided.", call. = FALSE)
  }

  openbahn_check_auth()

  base_url <- "https://open-api.bahn.de/bin/rest.exe/"
  api_path <- "bin/rest.exe/departureBoard"
  api_format <- "json"
  api_key <- Sys.getenv("OPENBAHN_KEY")

  request <- modify_url(
    base_url,
    path = api_path,
    query = list(
      authKey = api_key,
      format = api_format,
      id = id,
      date = date,
      time = time
    )
  )

  ua <- user_agent(Sys.getenv("OPENBAHN_USER_AGENT"))

  response <- GET(request, ua)

  if (http_type(response) != "application/json") {
    stop("API did not return JSON.", .call = FALSE)
  }

  parsed <- fromJSON(content(response, "text"))

  if ("errorCode" %in% names(parsed$DepartureBoard)) {
    stop(
      sprintf(
        "API request failed with error <%s>:\n%s",
        parsed$DepartureBoard$errorCode,
        parsed$DepartureBoard$errorText
      ),
      call. = FALSE
    )
  }

  ###
  if ("tyte" %in% colnames(parsed$DepartureBoard$Departure)) {
    parsed$DepartureBoard$Departure$type <-
      ifelse(
        is.na(parsed$DepartureBoard$Departure$type),
        parsed$DepartureBoard$Departure$tyte,
        parsed$DepartureBoard$Departure$type
      )
    parsed$DepartureBoard$Departure$tyte <- NULL
  }
  ###

  structure(list(
    content = parsed,
    path = api_path,
    response = response
  ),
  class = "openbahn_departureBoard")

}
