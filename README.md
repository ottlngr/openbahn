
<!-- README.md is generated from README.Rmd. Please edit that file -->
openbahn
========

`openbahn` provides functions to easily interact with the Timetable API, provided by the German railroad company *Deutsche Bahn* (DB). At the moment, the API does only provide timetable data for the German long-distance traffic. The following API endpoints exist and are covered by `openbahn`:

-   `location.name` to look up train stations
-   `arrivalBoard` to retrieve arrival boards
-   `departureBoard` to retrieve departure boards
-   `journeyDetail` to retrieve detailed information for specific trains

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

`locationNameApi()` can be used to find a train station along with an internal ID and its coordinates:

``` r
stations <- locationNameApi("Mainz Hbf")
#> Using provided API key.
stations
#> < https://open-api.bahn.de/ >
#> < bin/rest.exe/location.name >
#> 
#>                                        name       lon       lat        id
#> 1                                 Mainz Hbf  8.258723 50.001113 008000240
#> 2                        Frankfurt(Main)Hbf  8.663785 50.107149 008000105
#> 3                        Offenbach(Main)Hbf  8.760743 50.099266 008000349
#> 4                               Mailand Hbf  9.204828 45.487143 008300046
#> 5                           FRANKFURT(MAIN)  8.663785 50.107149 008096021
#> 6                      Frankfurt(Main)Flugh  8.570972 50.051210 008000281
#> 7   Frankfurt am Main Flughafen Fernbahnhof  8.570181 50.053169 008070003
#> 8                        Frankfurt(Main)Süd  8.686456 50.099365 008002041
#> 9                      Linz/Donau main stat 14.292129 48.290178 008100013
#> 10                      Frankfurt(Main)West  8.639335 50.118862 008002042
#> 11 Frankfurt am Main Flughafen Regiobahnhof  8.571250 50.051219 008070004
#> 12                      St.Pölten main stat 15.624672 48.208304 008100008
#> 13                      Vienna main station 16.375865 48.184923 008103000
#> 14                      Zurich Main Station  8.539204 47.378186 008503000
#> 15                      Verona Main Station 10.982742 45.428660 008300120
#> 16                          Bayerisch Gmain 12.895071 47.720379 008000831
#> 17                      Geneva Main Station  6.142122 46.210416 008501008
#> 18                                  MAILAND  9.207597 45.462477 008396005
#> 19                         Mailand Lambrate  9.237225 45.485067 008300062
```

To retrieve arrival or departure boards, an `id` found in `stations` can be used. Furthermore, date and time the arrival or departure boards shall build on have to be provided:

``` r
mainz_hbf <- stations$content$LocationList$StopLocation$id[1]

departures <- departureBoardApi(id = mainz_hbf, date = "2017-12-01", time = "12:00")
#> Using provided API key.
departures
#> < https://open-api.bahn.de/ >
#> < bin/rest.exe/departureBoard >
#> 
#>          date  time     name type  stopid      stop          direction track
#> 1  2017-12-01 12:17  IC 2005   IC 8000240 Mainz Hbf           Konstanz  4a/b
#> 2  2017-12-01 12:20  IC 2024   IC 8000240 Mainz Hbf     Hamburg-Altona  3a/b
#> 3  2017-12-01 12:40     EC 9   EC 8000240 Mainz Hbf          Zürich HB  5a/b
#> 4  2017-12-01 12:43 ICE 1651  ICE 8000240 Mainz Hbf        Dresden Hbf  4a/b
#> 5  2017-12-01 12:48  IC 1216   IC 8000240 Mainz Hbf  Berlin Ostbahnhof  3a/b
#> 6  2017-12-01 13:12  IC 2013   IC 8000240 Mainz Hbf         Oberstdorf  4a/b
#> 7  2017-12-01 13:20  IC 2312   IC 8000240 Mainz Hbf     Hamburg-Altona  3a/b
#> 8  2017-12-01 13:22 ICE 1652  ICE 8000240 Mainz Hbf      Wiesbaden Hbf  2a/b
#> 9  2017-12-01 13:40  IC 2023   IC 8000240 Mainz Hbf Frankfurt(Main)Hbf  4a/b
#> 10 2017-12-01 13:44  IC 2014   IC 8000240 Mainz Hbf  Münster(Westf)Hbf  3a/b
#> 11 2017-12-01 14:20  IC 2026   IC 8000240 Mainz Hbf     Hamburg-Altona  3a/b
#> 12 2017-12-01 14:40  IC 2313   IC 8000240 Mainz Hbf          Offenburg  5a/b
#> 13 2017-12-01 14:43 ICE 1653  ICE 8000240 Mainz Hbf        Dresden Hbf  4a/b
#> 14 2017-12-01 14:48  IC 2012   IC 8000240 Mainz Hbf      Magdeburg Hbf  2a/b
#> 15 2017-12-01 15:12  IC 1911   IC 8000240 Mainz Hbf      Stuttgart Hbf  4a/b
#> 16 2017-12-01 15:20     EC 8   EC 8000240 Mainz Hbf     Hamburg-Altona  3a/b
#> 17 2017-12-01 15:22 ICE 1650  ICE 8000240 Mainz Hbf      Wiesbaden Hbf  2a/b
#> 18 2017-12-01 15:40  IC 2025   IC 8000240 Mainz Hbf Frankfurt(Main)Hbf  4a/b
#> 19 2017-12-01 16:20  IC 2022   IC 8000240 Mainz Hbf     Hamburg-Altona  3a/b
#> 20 2017-12-01 16:23  ICE 710  ICE 8000240 Mainz Hbf           Köln Hbf  3a/b

arrivals <- arrivalBoardApi(id = mainz_hbf, date = "2017-12-01", time = "12:00")
#> Using provided API key.
arrivals
#> < https://open-api.bahn.de/ >
#> < bin/rest.exe/arrivalBoard >
#> 
#>          date  time     name type  stopid      stop             origin track
#> 1  2017-12-01 12:15  IC 2005   IC 8000240 Mainz Hbf  Münster(Westf)Hbf  4a/b
#> 2  2017-12-01 12:18  IC 2024   IC 8000240 Mainz Hbf         Passau Hbf  3a/b
#> 3  2017-12-01 12:35 ICE 1651  ICE 8000240 Mainz Hbf      Wiesbaden Hbf  4a/b
#> 4  2017-12-01 12:38     EC 9   EC 8000240 Mainz Hbf     Hamburg-Altona  5a/b
#> 5  2017-12-01 12:46  IC 1216   IC 8000240 Mainz Hbf       Salzburg Hbf  3a/b
#> 6  2017-12-01 13:10  IC 2013   IC 8000240 Mainz Hbf      Magdeburg Hbf  4a/b
#> 7  2017-12-01 13:15 ICE 1652  ICE 8000240 Mainz Hbf        Dresden Hbf  2a/b
#> 8  2017-12-01 13:18  IC 2312   IC 8000240 Mainz Hbf      Stuttgart Hbf  3a/b
#> 9  2017-12-01 13:38  IC 2023   IC 8000240 Mainz Hbf     Hamburg-Altona  4a/b
#> 10 2017-12-01 13:40  IC 2014   IC 8000240 Mainz Hbf      Stuttgart Hbf  3a/b
#> 11 2017-12-01 14:18  IC 2026   IC 8000240 Mainz Hbf Frankfurt(Main)Hbf  3a/b
#> 12 2017-12-01 14:35 ICE 1653  ICE 8000240 Mainz Hbf      Wiesbaden Hbf  4a/b
#> 13 2017-12-01 14:38  IC 2313   IC 8000240 Mainz Hbf     Hamburg-Altona  5a/b
#> 14 2017-12-01 14:46  IC 2012   IC 8000240 Mainz Hbf         Oberstdorf  2a/b
#> 15 2017-12-01 15:10  IC 1911   IC 8000240 Mainz Hbf       Dortmund Hbf  4a/b
#> 16 2017-12-01 15:15 ICE 1650  ICE 8000240 Mainz Hbf        Dresden Hbf  2a/b
#> 17 2017-12-01 15:18     EC 8   EC 8000240 Mainz Hbf          Zürich HB  3a/b
#> 18 2017-12-01 15:38  IC 2025   IC 8000240 Mainz Hbf     Hamburg-Altona  4a/b
#> 19 2017-12-01 16:18  IC 2022   IC 8000240 Mainz Hbf Frankfurt(Main)Hbf  3a/b
#> 20 2017-12-01 16:35 ICE 1655  ICE 8000240 Mainz Hbf      Wiesbaden Hbf  4a/b
```

For the particular trains in the arrival or departures board one can retrieve detailed information using `journeyDetailsApi()`. Therefor, the reference url of the desired train has to be looked up in the `JourneyDetailRef` data.frame:

``` r
reference <- departures$content$DepartureBoard$Departure$JourneyDetailRef$ref[1]
details <- journeyDetailApi(reference_url = reference)
details
#> < https://open-api.bahn.de/ >
#> < bin/rest.exe/journeyDetail >
#> 
#>    routeIdx                 name      id    depDate depTime    arrDate arrTime track
#> 1         6    Münster(Westf)Hbf 8000263 2017-12-01   08:32 2017-12-01   08:29     8
#> 2         7   Recklinghausen Hbf 8000307 2017-12-01   09:01 2017-12-01   08:59     1
#> 3         8     Wanne-Eickel Hbf 8000192 2017-12-01   09:09 2017-12-01   09:07     3
#> 4         9    Gelsenkirchen Hbf 8000118 2017-12-01   09:15 2017-12-01   09:13     5
#> 5        10       Oberhausen Hbf 8000286 2017-12-01   09:27 2017-12-01   09:25     7
#> 6        11         Duisburg Hbf 8000086 2017-12-01   09:34 2017-12-01   09:32     2
#> 7        12       Düsseldorf Hbf 8000085 2017-12-01   09:49 2017-12-01   09:46    16
#> 8        13             Köln Hbf 8000207 2017-12-01   10:18 2017-12-01   10:15     7
#> 9        14             Bonn Hbf 8000044 2017-12-01   10:37 2017-12-01   10:35     3
#> 10       15              Remagen 8000310 2017-12-01   10:51 2017-12-01   10:49     3
#> 11       16            Andernach 8000331 2017-12-01   11:03 2017-12-01   11:01     1
#> 12       17          Koblenz Hbf 8000206 2017-12-01   11:17 2017-12-01   11:15     4
#> 13       18    Bingen(Rhein) Hbf 8000039 2017-12-01   11:52 2017-12-01   11:50   101
#> 14       19            Mainz Hbf 8000240 2017-12-01   12:17 2017-12-01   12:15  4a/b
#> 15       20            Worms Hbf 8000257 2017-12-01   12:45 2017-12-01   12:43     2
#> 16       21         Mannheim Hbf 8000244 2017-12-01   13:09 2017-12-01   13:07     4
#> 17       22        Karlsruhe Hbf 8000191 2017-12-01   13:36 2017-12-01   13:34     2
#> 18       23          Baden-Baden 8000774 2017-12-01   13:56 2017-12-01   13:54     7
#> 19       24            Offenburg 8000290 2017-12-01   14:18 2017-12-01   14:15     5
#> 20       25              Hausach 8000333 2017-12-01   14:39 2017-12-01   14:37     3
#> 21       26   Hornberg(Schwarzw) 8003001 2017-12-01   14:48 2017-12-01   14:47     1
#> 22       27              Triberg 8005902 2017-12-01   15:03 2017-12-01   15:02     2
#> 23       28 St Georgen(Schwarzw) 8005644 2017-12-01   15:20 2017-12-01   15:19     2
#> 24       29  Villingen(Schwarzw) 8000366 2017-12-01   15:31 2017-12-01   15:29     1
#> 25       30       Donaueschingen 8000077 2017-12-01   15:42 2017-12-01   15:40     2
#> 26       31          Immendingen 8000182 2017-12-01   15:54 2017-12-01   15:53     4
#> 27       32   Singen(Hohentwiel) 8000073 2017-12-01   16:18 2017-12-01   16:16     2
#> 28       33           Radolfzell 8000880 2017-12-01   16:28 2017-12-01   16:25     6
#> 29       34             Konstanz 8003400       <NA>    <NA> 2017-12-01   16:45     3
```

References
----------

For general information on the DB Timetable API visit <http://data.deutschebahn.com/dataset/api-fahrplan> (German). The data behind this API is licenced unter CC BY 4.0.

Community Guidelines
====================

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
