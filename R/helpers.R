#' @export
print.openbahn_locations <- function(x, ...) {

  cat("< https://open-api.bahn.de/ >\n< ", x$path, " >\n\n", sep = "")
  print(x$content$LocationList$StopLocation)
  invisible(x)

}

#' @export
print.openbahn_departures <- function(x, ...) {

  cat("< https://open-api.bahn.de/ >\n< ", x$path, " >\n\n", sep = "")
  obj <- x$content$DepartureBoard$Departure
  print(obj[, c("date",
                "time",
                "name",
                "type",
                "stopid",
                "stop",
                "direction",
                "track")])
  invisible(x)

}

#' @export
print.openbahn_arrivals <- function(x, ...) {

  cat("< https://open-api.bahn.de/ >\n< ", x$path, " >\n\n", sep = "")
  obj <- x$content$ArrivalBoard$Arrival
  print(obj[, c("date",
                "time",
                "name",
                "type",
                "stopid",
                "stop",
                "origin",
                "track")])
  invisible(x)

}

#' @export
print.openbahn_journeys <- function(x, ...) {

  cat("< https://open-api.bahn.de/ >\n< ", x$path, " >\n\n", sep = "")
  obj <- x$content$JourneyDetail$Stops$Stop
  print(obj[, c("routeIdx",
                "name",
                "id",
                "depDate",
                "depTime",
                "arrDate",
                "arrTime",
                "track")])
  invisible(x)

}

# #' @export
openbahn_check_auth <- function() {
  x <- Sys.getenv("OPENBAHN_KEY")
  if (x == "") {
    stop("No API key found in the current environment. 
         Please use openbahn_auth() to provide an API key.",
         .call = FALSE)
  } else {
    message("Using provided API key.\n\n")
  }
}
