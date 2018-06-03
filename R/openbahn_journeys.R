#' Get details of a specific journey
#' 
#' \code{openbahn_journeys} returns detailed information on a journey found using \code{departureBoardApi()} or \code{arrivalBoardApi()}.
#' 
#' @param reference_url character, a reference url of a journey obtained using \code{departureBoardApi()} or \code{arrivalBoardApi()}.
#' @return A \code{list} containing the \code{path}, \code{response} and \code{content} of the \code{GET} request.
#' @details \code{openbahn_journeys()} uses the API key stored by \code{openbahn_auth}.
#' @author Philipp Ottolinger
#' @references \url{http://data.deutschebahn.com/dataset/api-fahrplan} 
#' @importFrom httr modify_url user_agent GET http_type content
#' @importFrom jsonlite fromJSON
#' @examples 
#' \dontrun{
#' # Set your API key
#' openbahn_auth("YOUR_KEY_HERE")
#' # Get an arrival or departure board for a specific station, date and time
#' dep <- departureBoardApi("008000240", date = Sys.Date() + 1, time = "12:00")
#' # Get a reference URL for a specific train in the arrival or departure board
#' ref <- dep$content$DepartureBoard$Departure$JourneyDetailRef$ref[1]
#' # Get train details
#' openbahn_journeys(ref)
#' }
#' @export openbahn_journeys
openbahn_journeys <- function(reference_url) {

  if (missing(reference_url)) {
    stop("No reference url provided.", call. = FALSE)
  }

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
    class = c("openbahn_journeys")
  )

}
