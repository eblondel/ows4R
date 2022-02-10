# test_WCSClient_v1_0.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Integration tests for WCS Client version 1.0
#=======================
require(ows4R, quietly = TRUE)
require(testthat)
context("WCS")

test_that("WCS 2.0.1 - GeoServer",{
  wcs <- WCSClient$new("http://localhost:8080/geoserver/wcs", "2.0.1", logger = "DEBUG")
  expect_is(wcs, "WCSClient")
  caps <- wcs$getCapabilities()
  expect_is(caps, "WCSCapabilities")
  cov <- caps$findCoverageSummaryById("sf__sfdem")
  expect_is(cov, "WCSCoverageSummary")
  expect_equal(length(caps$getCoverageSummaries()), 5L)
})

