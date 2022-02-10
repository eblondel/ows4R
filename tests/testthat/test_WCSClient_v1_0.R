# test_WCSClient_v1_0.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Integration tests for WCS Client version 1.0
#=======================
require(ows4R, quietly = TRUE)
require(testthat)
context("WCS")

test_that("WCS 1.0 - Thredds",{
  wcs <- WCSClient$new("https://rsg.pml.ac.uk/thredds/wcs/CCI_ALL-v5.0-DAILY", "1.0", logger = "DEBUG")
  expect_is(wcs, "WCSClient")
  caps <- wcs$getCapabilities()
  expect_is(caps, "WCSCapabilities")
  cov <- caps$findCoverageSummaryById("chlor_a")
  expect_is(cov, "WCSCoverageSummary")
  expect_equal(length(caps$getCoverageSummaries()), 92L)
})

test_that("WCS 1.0.0 - GeoServer",{
  wcs <- WCSClient$new("http://localhost:8080/geoserver/wcs", "1.0.0", logger = "DEBUG")
  expect_is(wcs, "WCSClient")
  caps <- wcs$getCapabilities()
  expect_is(caps, "WCSCapabilities")
  cov <- caps$findCoverageSummaryById("sf:sfdem")
  expect_is(cov, "WCSCoverageSummary")
  expect_equal(length(caps$getCoverageSummaries()), 5L)
})
