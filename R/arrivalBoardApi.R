#' Get an arrival board for a specific station
#' 
#' \code{arrivalBoardApi} returns an arrival board for a specific station, date and time.
#' 
#' @param id character, the internal ID of the station, received from \code{locationNameApi}.
#' @param date character, the date of the arrival board in format \code{YYYY-MM-DD}. Must not be a past date.
#' @param time character, the time of the arrival board in format \code{HH:MM:SS}.
#' @return A \code{list} containing the \code{path}, \code{response} and \code{content} of the \code{GET} request.
#' @details \code{arrivalBoardApi()} uses the API key stored by \code{openbahn_auth}.
#' @author Philipp Ottolinger
#' @references \url{http://data.deutschebahn.com/dataset/api-fahrplan} 
#' @importFrom httr modify_url user_agent GET http_type
#' @importFrom jsonlite fromJSON
#' @export arrivalBoardApi
arrivalBoardApi <- function(id, date, time) {

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
  api_path <- "bin/rest.exe/arrivalBoard"
  api_format <- "json"
  api_key <- Sys.getenv("OPENBAHN_KEY")

  request <- modify_url(base_url,
                        path = api_path,
                        query = list(authKey = api_key,
                                     format = api_format,
                                     id = id,
                                     date = date,
                                     time = time))

  ua <- user_agent(Sys.getenv("OPENBAHN_USER_AGENT"))

  response <- GET(request, ua)

  if (http_type(response) != "application/json") {
    stop("API did not return JSON.", .call = FALSE)
  }

  parsed <- fromJSON(content(response, "text"))

  if ("errorCode" %in% names(parsed$ArrivalBoard)) {
    stop(
      sprintf(
        "API request failed with error <%s>:\n%s",
        parsed$ArrivalBoard$errorCode,
        parsed$ArrivalBoard$errorText
      ),
      call. = FALSE
    )
  }

  ###
  if ("tyte" %in% colnames(parsed$ArrivalBoard$Arrival)) {
    parsed$ArrivalBoard$Arrival$type <- ifelse(is.na(parsed$ArrivalBoard$Arrivaltype),
                                                   parsed$ArrivalBoard$Arrival$tyte,
                                                   parsed$ArrivalBoard$Arrival$type)
    parsed$ArrivalBoard$Arrival$tyte <- NULL
  }
  ###

  structure(
    list(
      content = parsed,
      path = api_path,
      response = response
    ),
    class = "openbahn_arrivalBoard"
  )

}
