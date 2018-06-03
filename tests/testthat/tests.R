l <- openbahn_locations("Mainz Hbf")
a <- openbahn_arrivals("008000240", Sys.Date() + 1, "12:00:00")
d <- openbahn_departures("008000240", Sys.Date() + 1, "12:00:00")
j <- openbahn_journeys(a$content$ArrivalBoard$Arrival$JourneyDetailRef$ref[1])

test_that("Results have the right class", {

  expect_true(class(l) == "openbahn_locations")
  expect_true(class(a) == "openbahn_arrivals")
  expect_true(class(d) == "openbahn_departures")
  expect_true(class(j) == "openbahn_journeys")

})

test_that("Results have named objects", {

  expect_named(l, c("content", "path", "response"), ignore.order = TRUE)
  expect_named(a, c("content", "path", "response"), ignore.order = TRUE)
  expect_named(d, c("content", "path", "response"), ignore.order = TRUE)
  expect_named(j, c("content", "path", "response"), ignore.order = TRUE)

})

test_that("openbahn_arrivals() throws errors", {

  expect_error(
    openbahn_arrivals(date = Sys.Date() + 1, time = "12:00:00"),
    "No id provided."
  )
  expect_error(
    openbahn_arrivals(id = "008000240", time = "12:00:00"),
    "No date provided."
  )
  expect_error(
    openbahn_arrivals(id = "008000240", date = Sys.Date() + 1),
    "No time provided."
  )

})

test_that("openbahn_departures() throws errors", {

  expect_error(
    openbahn_departures(date = Sys.Date() + 1, time = "12:00:00"),
    "No id provided."
  )
  expect_error(
    openbahn_departures(id = "008000240", time = "12:00:00"),
    "No date provided."
  )
  expect_error(
    openbahn_departures(id = "008000240", date = Sys.Date() + 1),
    "No time provided."
  )

})

test_that("journeyDetailsApi() throws error", {

  expect_error(openbahn_journeys(), "No reference url provided.")

})

test_that("openbahn_check_auth() works", {

  expect_message(openbahn:::openbahn_check_auth(), "Using provided API key.")

})

test_that("print methods", {

  expect_true(capture.output(a)[1] == "< https://open-api.bahn.de/ >")
  expect_true(capture.output(a)[2] == "< bin/rest.exe/arrivalBoard >")

  expect_true(capture.output(d)[1] == "< https://open-api.bahn.de/ >")
  expect_true(capture.output(d)[2] == "< bin/rest.exe/departureBoard >")

  expect_true(capture.output(l)[1] == "< https://open-api.bahn.de/ >")
  expect_true(capture.output(l)[2] == "< bin/rest.exe/location.name >")

  expect_true(capture.output(j)[1] == "< https://open-api.bahn.de/ >")
  expect_true(capture.output(j)[2] == "< bin/rest.exe/journeyDetail >")

})

test_that("openbahn_locations() throws error", {

  expect_error(openbahn_locations(), "No query string provided.")

})

test_that("openbahn_auth() throws error", {

  expect_error(openbahn_auth(), "Please provide your API key.")
  expect_error(openbahn_auth(123), "Please provide a character")
})
