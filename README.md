
<!-- README.md is generated from README.Rmd. Please edit that file -->
openbahn
========

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/openbahn)](https://cran.r-project.org/package=openbahn) [![Travis-CI](https://api.travis-ci.org/ottlngr/openbahn.svg)](https://travis-ci.org/ottlngr/openbahn) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ottlngr/openbahn?branch=master&svg=true)](https://ci.appveyor.com/project/ottlngr/openbahn) [![codecov](https://codecov.io/gh/ottlngr/openbahn/branch/master/graph/badge.svg)](https://codecov.io/gh/ottlngr/openbahn) [![](http://cranlogs.r-pkg.org/badges/openbahn)](http://cran.rstudio.com/web/packages/openbahn/index.html)

`openbahn` provides functions to easily interact with the Timetable API, provided by the German railroad company *Deutsche Bahn* (DB). At the moment, the API does only provide timetable data for the German long-distance traffic. The following API endpoints exist and are covered by `openbahn`:

-   `openbahn_locations` to look up train stations
-   `openbahn_arrivals` to retrieve arrival boards
-   `openbahn_departures` to retrieve departure boards
-   `openbahn_jounreys` to retrieve detailed information for specific trains

To interact with the API, an API key is required.

API Key
-------

To get an API key, one has to email to the [DB Open-Data-Team](mailto:DBOpenData@deutschebahn.com) and request a key for the timetable or *Fahrplan* API, respectively.

Installation
------------

You can install openbahn from github with:

``` r
# install.packages("devtools")
devtools::install_github("ottlngr/openbahn")
```

Usage
-----

First, `openbahn_auth()` can be used to store the API key in an environment variable all further `openbahn` functions will access:

``` r
library(openbahn)
```

``` r
openbahn_auth("YOUR_API_KEY_HERE")
```

`openbahn_locations()` can be used to find a train station along with an internal ID and its coordinates:

``` r
stations <- openbahn_locations(query = "Mainz Hbf")
#> Using provided API key.
stations
#> < https://open-api.bahn.de/ >
#> < bin/rest.exe/location.name >
#> 
#>                                        name       lon       lat        id
#> 1                                 Mainz Hbf  8.258723 50.001113 008000240
#> 2                        Frankfurt(Main)Hbf  8.663785 50.107149 008000105
#> 3                               Mailand Hbf  9.204828 45.487143 008300046
#> 4                           FRANKFURT(MAIN)  8.663785 50.107149 008096021
#> 5   Frankfurt am Main Flughafen Fernbahnhof  8.570181 50.053169 008070003
#> 6                      Frankfurt(Main)Flugh  8.570972 50.051210 008000281
#> 7                      Linz/Donau main stat 14.292129 48.290178 008100013
#> 8                        Frankfurt(Main)Süd  8.686456 50.099365 008002041
#> 9                       Frankfurt(Main)West  8.639335 50.118862 008002042
#> 10 Frankfurt am Main Flughafen Regiobahnhof  8.571250 50.051219 008070004
#> 11                      St.Pölten main stat 15.624672 48.208304 008100008
#> 12                      Vienna main station 16.375865 48.184923 008103000
#> 13                      Zurich Main Station  8.539204 47.378186 008503000
#> 14                      Verona Main Station 10.982742 45.428660 008300120
#> 15                          Bayerisch Gmain 12.895071 47.720379 008000831
#> 16                      Geneva Main Station  6.142122 46.210416 008501008
#> 17                                  MAILAND  9.207597 45.462477 008396005
```

To retrieve arrival or departure boards, an `id` found in `stations` can be used. Furthermore, date and time the arrival or departure boards shall build on have to be provided:

``` r
mainz_hbf <- stations$content$LocationList$StopLocation$id[1]

departures <- openbahn_departures(id = mainz_hbf, date = Sys.Date() + 1, time = "12:00")
#> Using provided API key.
departures
#> < https://open-api.bahn.de/ >
#> < bin/rest.exe/departureBoard >
#> 
#>          date  time     name type  stopid      stop          direction track
#> 1  2018-06-04 12:20  IC 2024   IC 8000240 Mainz Hbf     Hamburg-Altona  3a/b
#> 2  2018-06-04 12:42     EC 9   EC 8000240 Mainz Hbf          Zürich HB  5a/b
#> 3  2018-06-04 12:43 ICE 1651  ICE 8000240 Mainz Hbf        Dresden Hbf  4a/b
#> 4  2018-06-04 13:12  IC 2013   IC 8000240 Mainz Hbf         Oberstdorf  5a/b
#> 5  2018-06-04 13:20  IC 2312   IC 8000240 Mainz Hbf     Hamburg-Altona  3a/b
#> 6  2018-06-04 13:22 ICE 1652  ICE 8000240 Mainz Hbf      Wiesbaden Hbf  2a/b
#> 7  2018-06-04 13:41  IC 2023   IC 8000240 Mainz Hbf Frankfurt(Main)Hbf  4a/b
#> 8  2018-06-04 14:20  IC 2026   IC 8000240 Mainz Hbf     Hamburg-Altona  3a/b
#> 9  2018-06-04 14:42  IC 2313   IC 8000240 Mainz Hbf          Offenburg  5a/b
#> 10 2018-06-04 14:43 ICE 1653  ICE 8000240 Mainz Hbf        Dresden Hbf  4a/b
#> 11 2018-06-04 14:49  IC 2012   IC 8000240 Mainz Hbf      Magdeburg Hbf  2a/b
#> 12 2018-06-04 15:20     EC 8   EC 8000240 Mainz Hbf     Hamburg-Altona  3a/b
#> 13 2018-06-04 15:22 ICE 1650  ICE 8000240 Mainz Hbf      Wiesbaden Hbf  2a/b
#> 14 2018-06-04 15:41  IC 2025   IC 8000240 Mainz Hbf Frankfurt(Main)Hbf  4a/b
#> 15 2018-06-04 16:20  IC 2022   IC 8000240 Mainz Hbf     Hamburg-Altona  3a/b
#> 16 2018-06-04 16:22  ICE 710  ICE 8000240 Mainz Hbf           Köln Hbf  2a/b
#> 17 2018-06-04 16:42  IC 2217   IC 8000240 Mainz Hbf      Stuttgart Hbf  5a/b
#> 18 2018-06-04 16:43 ICE 1655  ICE 8000240 Mainz Hbf        Dresden Hbf  4a/b
#> 19 2018-06-04 16:48   IC 118   IC 8000240 Mainz Hbf  Münster(Westf)Hbf  1a/b
#> 20 2018-06-04 17:12  IC 2011   IC 8000240 Mainz Hbf       Tübingen Hbf  5a/b

arrivals <- openbahn_arrivals(id = mainz_hbf, date = Sys.Date() + 1, time = "12:00")
#> Using provided API key.
arrivals
#> < https://open-api.bahn.de/ >
#> < bin/rest.exe/arrivalBoard >
#> 
#>          date  time     name type  stopid      stop             origin track
#> 1  2018-06-04 12:18  IC 2024   IC 8000240 Mainz Hbf         Passau Hbf  3a/b
#> 2  2018-06-04 12:36 ICE 1651  ICE 8000240 Mainz Hbf      Wiesbaden Hbf  4a/b
#> 3  2018-06-04 12:39     EC 9   EC 8000240 Mainz Hbf     Hamburg-Altona  5a/b
#> 4  2018-06-04 13:10  IC 2013   IC 8000240 Mainz Hbf        Leipzig Hbf  5a/b
#> 5  2018-06-04 13:15 ICE 1652  ICE 8000240 Mainz Hbf        Dresden Hbf  2a/b
#> 6  2018-06-04 13:18  IC 2312   IC 8000240 Mainz Hbf      Stuttgart Hbf  3a/b
#> 7  2018-06-04 13:39  IC 2023   IC 8000240 Mainz Hbf     Hamburg-Altona  4a/b
#> 8  2018-06-04 14:18  IC 2026   IC 8000240 Mainz Hbf Frankfurt(Main)Hbf  3a/b
#> 9  2018-06-04 14:36 ICE 1653  ICE 8000240 Mainz Hbf      Wiesbaden Hbf  4a/b
#> 10 2018-06-04 14:39  IC 2313   IC 8000240 Mainz Hbf     Hamburg-Altona  5a/b
#> 11 2018-06-04 14:47  IC 2012   IC 8000240 Mainz Hbf         Oberstdorf  2a/b
#> 12 2018-06-04 15:15 ICE 1650  ICE 8000240 Mainz Hbf        Dresden Hbf  2a/b
#> 13 2018-06-04 15:18     EC 8   EC 8000240 Mainz Hbf          Zürich HB  3a/b
#> 14 2018-06-04 15:39  IC 2025   IC 8000240 Mainz Hbf     Hamburg-Altona  4a/b
#> 15 2018-06-04 16:16  ICE 710  ICE 8000240 Mainz Hbf      Stuttgart Hbf  2a/b
#> 16 2018-06-04 16:18  IC 2022   IC 8000240 Mainz Hbf Frankfurt(Main)Hbf  3a/b
#> 17 2018-06-04 16:36 ICE 1655  ICE 8000240 Mainz Hbf      Wiesbaden Hbf  4a/b
#> 18 2018-06-04 16:39  IC 2217   IC 8000240 Mainz Hbf     Hamburg-Altona  5a/b
#> 19 2018-06-04 16:46   IC 118   IC 8000240 Mainz Hbf      Innsbruck Hbf  1a/b
#> 20 2018-06-04 17:10  IC 2011   IC 8000240 Mainz Hbf     Düsseldorf Hbf  5a/b
```

For the particular trains in the arrival or departures board one can retrieve detailed information using `openbahn_journey()`. Therefor, the reference url of the desired train has to be looked up in the `JourneyDetailRef` data.frame:

``` r
reference <- departures$content$DepartureBoard$Departure$JourneyDetailRef$ref[1]
details <- openbahn_journeys(reference_url = reference)
details
#> < https://open-api.bahn.de/ >
#> < bin/rest.exe/journeyDetail >
#> 
#>    routeIdx                          name      id    depDate depTime    arrDate arrTime  track
#> 1         0                    Passau Hbf 8000298 2018-06-04   07:17       <NA>    <NA>      2
#> 2         1                     Plattling 8000301 2018-06-04   07:50 2018-06-04   07:49      4
#> 3         2                     Straubing 8000095 2018-06-04   08:05 2018-06-04   08:04      5
#> 4         3                Regensburg Hbf 8000309 2018-06-04   08:27 2018-06-04   08:25      5
#> 5         4                  Nürnberg Hbf 8000284 2018-06-04   09:30 2018-06-04   09:26      6
#> 6         5                  Würzburg Hbf 8000260 2018-06-04   10:24 2018-06-04   10:22      6
#> 7         6                     Hanau Hbf 8000150 2018-06-04   11:17 2018-06-04   11:15    102
#> 8         7            Frankfurt(Main)Hbf 8000105 2018-06-04   11:42 2018-06-04   11:36      6
#> 9         8 Frankfurt(M) Flughafen Fernbf 8070003 2018-06-04   11:58 2018-06-04   11:55 Fern 7
#> 10        9                     Mainz Hbf 8000240 2018-06-04   12:20 2018-06-04   12:18   3a/b
#> 11       10                   Koblenz Hbf 8000206 2018-06-04   13:13 2018-06-04   13:11      3
#> 12       11                      Bonn Hbf 8000044 2018-06-04   13:46 2018-06-04   13:44      2
#> 13       12                      Köln Hbf 8000207 2018-06-04   14:10 2018-06-04   14:05      4
#> 14       13                  Solingen Hbf 8000087 2018-06-04   14:31 2018-06-04   14:29      3
#> 15       14                 Wuppertal Hbf 8000266 2018-06-04   14:44 2018-06-04   14:42      2
#> 16       15                     Hagen Hbf 8000142 2018-06-04   15:02 2018-06-04   15:00    6/5
#> 17       16                  Dortmund Hbf 8000080 2018-06-04   15:25 2018-06-04   15:22     10
#> 18       17             Münster(Westf)Hbf 8000263 2018-06-04   15:57 2018-06-04   15:55     12
#> 19       18                 Osnabrück Hbf 8000294 2018-06-04   16:23 2018-06-04   16:21      3
#> 20       19                    Bremen Hbf 8000050 2018-06-04   17:19 2018-06-04   17:16     10
#> 21       20               Hamburg-Harburg 8000147 2018-06-04   18:04 2018-06-04   18:02      2
#> 22       21                   Hamburg Hbf 8002549 2018-06-04   18:17 2018-06-04   18:14     14
#> 23       22               Hamburg Dammtor 8002548 2018-06-04   18:21 2018-06-04   18:20      3
#> 24       23                Hamburg-Altona 8002553       <NA>    <NA> 2018-06-04   18:29      6
```

References
----------

For general information on the DB Timetable API visit <http://data.deutschebahn.com/dataset/api-fahrplan> (German). The data behind this API is licenced unter CC BY 4.0.

Community Guidelines
====================

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
