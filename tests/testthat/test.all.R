library(globalPM25)

test_that("incorrect function input", {
  expect_error(getPMbyCityNames("nowhere"))
  expect_error(getPMinRegion("nowhere"))
  expect_error(getPMbylatlon(1000, 1000))
  expect_error(getPMinRegion("san jose", -1))
})

test_that("missing arguments", {
  expect_error(getPMbylatlon())
})
