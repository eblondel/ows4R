# test_WCSClient_v2_0.R
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

test_that("WCS 2.0.1 - Rasdaman",{
  wcs <- WCSClient$new("https://ows.rasdaman.org/rasdaman/ows", "2.0.1", logger = "DEBUG")
  expect_is(wcs, "WCSClient")
  caps <- wcs$getCapabilities()
  expect_is(caps, "WCSCapabilities")
  expect_equal(length(caps$getCoverageSummaries()), 35L)
  
  cov1 <- caps$findCoverageSummaryById("AverageChloroColor")
  expect_is(cov1, "WCSCoverageSummary")
  cov1_desc <- cov1$getDescription()
  expect_is(cov1_desc, "WCSCoverageDescription")
  expect_is(cov1_desc$domainSet, "GMLReferenceableGridByVectors")
  
  temp4d <- caps$findCoverageSummaryById("Temperature4D")
  expect_is(temp4d, "WCSCoverageSummary")
  temp4d_desc <- temp4d$getDescription()
  expect_is(temp4d_desc, "WCSCoverageDescription")
  expect_is(temp4d_desc$domainSet, "GMLReferenceableGridByVectors")
})

