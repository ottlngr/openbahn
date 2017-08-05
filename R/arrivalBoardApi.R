#' @import httr
#' @import jsonlite
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
