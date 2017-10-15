#' All stations in German rail network
#'
#' A dataset containing all stations in the rail network of German railway company Deutsche Bahn.
#'
#' @format A data frame with 6605 rows and 8 variables:
#' \describe{
#'   \item{station_id}{Internal station id as also used by the Timetable API}
#'   \item{authority}{Superior authority of the station}
#'   \item{unique_station_key}{Unique station key}
#'   \item{station_name}{Name of the station}
#'   \item{station_traffic}{Type of traffic the station serves}
#'   \item{station_lon}{Longitude of the station}
#'   \item{station_lat}{Latitude of the station}
#'   \item{station_status}{Status of the station}
#' }
#' 
#' @details The \code{station_id} is the same id as used by the Timetable API in \code{locationNameApi()}.
#' 
#' \code{station_traffic} indicates what type of traffic a stations serves, like long-distance traffic (\code{FV}), regional traffic only (\code{RV}) or regional traffic by not-state-owned companies only (\code{nur DPN}).
#' 
#' @source \url{http://data.deutschebahn.com/dataset/data-haltestellen}
"db_stations"