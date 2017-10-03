test_that("Results have the right class", {
  l <- locationNameApi("Mainz Hbf")
  expect_true(class(l) == "openbahn_locationName")
})