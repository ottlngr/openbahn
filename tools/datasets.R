library(readr)
library(dplyr)

db_stations_url <- "http://download-data.deutschebahn.com/static/datasets/haltestellen/D_Bahnhof_2017_09.csv"
db_stations <- read_csv2(db_stations_url) %>%
  select("station_id" = EVA_NR, 
         "authority" = DS100,
         "unique_station_key" = IFOPT,
         "station_name" = NAME,
         "station_traffic" = VERKEHR,
         "station_lon" = LAENGE,
         "station_lat" = BREITE,
         "station_status" = STATUS)
devtools::use_data(db_stations, overwrite = TRUE)


