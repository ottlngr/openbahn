#' Get a departure board for a specific station
#' 
#' \code{openbahn_departures} returns a departure board for a specific station, date and time.
#' 
#' @param id character, the internal ID of the station, received from \code{locationNameApi}.
#' @param date character, the date of the departure board in format \code{YYYY-MM-DD}. Must not be a past date.
#' @param time character, the time of the departure board in format \code{HH:MM:SS}.
#' @return A \code{list} containing the \code{path}, \code{response} and \code{content} of the \code{GET} request.
#' @details \code{openbahn_departures()} uses the API key stored by \code{openbahn_auth}.
#' @author Philipp Ottolinger
#' @references \url{http://data.deutschebahn.com/dataset/api-fahrplan} 
#' @importFrom httr modify_url user_agent GET http_type content
#' @importFrom jsonlite fromJSON
#' @examples 
#' \dontrun{
#' # Set your API key
#' openbahn_auth("YOUR_KEY_HERE")
#' # Get a departure board for a specific station, date and time
#' openbahn_departures("008000240", date = Sys.Date() + 1, time = "12:00")
#' }
#' @export openbahn_departures
openbahn_departures <- function(id, date, time) {
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
  class = "openbahn_departures")

}
