# test_WCSClient_v1_1.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Integration tests for WCS Client version 1.0
#=======================
require(ows4R, quietly = TRUE)
require(testthat)
context("WCS")

test_that("WCS 1.1 - GeoServer",{
  wcs <- WCSClient$new("http://localhost:8080/geoserver/wcs", "1.1", logger = "DEBUG")
  expect_is(wcs, "WCSClient")
  caps <- wcs$getCapabilities()
  expect_is(caps, "WCSCapabilities")
  expect_equal(length(caps$getCoverageSummaries()), 5L)
  sfdem <- caps$findCoverageSummaryById("sf:sfdem")
  expect_is(sfdem, "WCSCoverageSummary")
})

test_that("WCS 1.1.0 - GeoServer",{
  wcs <- WCSClient$new("http://localhost:8080/geoserver/wcs", "1.1.0", logger = "DEBUG")
  expect_is(wcs, "WCSClient")
  caps <- wcs$getCapabilities()
  expect_is(caps, "WCSCapabilities")
  expect_true(length(caps$getCoverageSummaries())>0)
  
  sfdem <- caps$findCoverageSummaryById("sf:sfdem")
  expect_is(sfdem, "WCSCoverageSummary")
  sfdem_desc <- sfdem$getDescription()
  expect_is(sfdem_desc, "WCSCoverageDescription")
  domain <- sfdem_desc$getDomain()
  expect_is(domain, "WCSCoverageDomain")
  expect_is(domain$getSpatialDomain(), "WCSCoverageSpatialDomain")
})

test_that("WCS 1.1.1 - GeoServer",{
  wcs <- WCSClient$new("http://localhost:8080/geoserver/wcs", "1.1.1", logger = "DEBUG")
  expect_is(wcs, "WCSClient")
  caps <- wcs$getCapabilities()
  expect_is(caps, "WCSCapabilities")
  expect_true(length(caps$getCoverageSummaries())>0)
  
  sfdem <- caps$findCoverageSummaryById("sf:sfdem")
  expect_is(sfdem, "WCSCoverageSummary")
  sfdem_desc <- sfdem$getDescription()
  expect_is(sfdem_desc, "WCSCoverageDescription")
  domain <- sfdem_desc$getDomain()
  expect_is(domain, "WCSCoverageDomain")
  expect_is(domain$getSpatialDomain(), "WCSCoverageSpatialDomain")
})

