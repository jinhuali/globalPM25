library(globalPM25)

test_that("incorrect function input", {
  expect_error(getPMbyCityNames("nowhere"), "incorrect city name")
  expect_error(getPMinRegion("nowhere"), "incorrect city name")
  expect_error(getPMbylatlon(1000, 1000), "out of range")
  expect_error(getPMinRegion("san jose", -1), "range must be a positive number")
})

test_that("missing arguments", {
  expect_error(getPMbylatlon(), "missing latitude and longitude")
})
