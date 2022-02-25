# test_WCSClient_v2_1_O.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Integration tests for WCS Client version 1.0
#=======================
require(ows4R, quietly = TRUE)
require(testthat)
context("WCS")

test_that("WCS 2.1.0 - Rasdaman",{
  testthat::skip_on_cran()
  wcs <- WCSClient$new("https://ows.rasdaman.org/rasdaman/ows", "2.1.0", logger = "DEBUG")
  expect_is(wcs, "WCSClient")
  caps <- wcs$getCapabilities()
  expect_is(caps, "WCSCapabilities")
  expect_equal(length(caps$getCoverageSummaries()), 26L)
  
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

test_that("WCS 2.1.0 - Rasdaman - Spatio-Temporal Coverages",{
  testthat::skip_on_cran()
  wcs <- WCSClient$new("https://ows.rasdaman.org/rasdaman/ows", "2.1.0", logger = "DEBUG")
  
  #AverageChlorophyllScaled
  chla <- wcs$getCapabilities()$findCoverageSummaryById("AverageChloroColorScaled", T)
  chla_des <- chla$getDescription()
  expect_is(chla_des, "WCSCoverageDescription")
  chla_dims <- chla$getDimensions()
  expect_is(chla_dims, "list")
  expect_equal(length(chla_dims), 3L)
  chla_stack <- chla$getCoverageStack(
    bbox = OWSUtils$toBBOX(-10, -9, 40, 42), 
    time = tail(chla_dims[[1]]$coefficients,5)
  )
})

