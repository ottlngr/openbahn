l <- locationNameApi("Mainz Hbf")
a <- arrivalBoardApi("008000240", Sys.Date() + 1, "12:00:00")
d <- departureBoardApi("008000240", Sys.Date() + 1, "12:00:00")
j <- journeyDetailApi(a$content$ArrivalBoard$Arrival$JourneyDetailRef$ref[1])

test_that("Results have the right class", {
  
  expect_true(class(l) == "openbahn_locationName")
  expect_true(class(a) == "openbahn_arrivalBoard")
  expect_true(class(d) == "openbahn_departureBoard")
  expect_true(class(j) == "openbahn_journeyDetail")
  
})

test_that("Results have named objects", {
  
  expect_named(l, c("content", "path", "response"), ignore.order = TRUE)
  expect_named(a, c("content", "path", "response"), ignore.order = TRUE)
  expect_named(d, c("content", "path", "response"), ignore.order = TRUE)
  expect_named(j, c("content", "path", "response"), ignore.order = TRUE)
  
})

test_that("arrivalBoardApi() throws errors", {
  
  expect_error(arrivalBoardApi(date = Sys.Date() + 1, time = "12:00:00"), "No id provided.")
  expect_error(arrivalBoardApi(id = "008000240", time = "12:00:00"), "No date provided.")
  expect_error(arrivalBoardApi(id = "008000240", date = Sys.Date() + 1), "No time provided.")
  
})

test_that("departureBoardApi() throws errors", {
  
  expect_error(departureBoardApi(date = Sys.Date() + 1, time = "12:00:00"), "No id provided.")
  expect_error(departureBoardApi(id = "008000240", time = "12:00:00"), "No date provided.")
  expect_error(departureBoardApi(id = "008000240", date = Sys.Date() + 1), "No time provided.")
  
})

test_that("journeyDetailsApi() throws error", {
  
  expect_error(journeyDetailApi(), "No reference url provided.")
  
})

test_that("openbahn_check_auth() works", {
  
  expect_message(openbahn:::openbahn_check_auth(), "Using provided API key.")
  
})
