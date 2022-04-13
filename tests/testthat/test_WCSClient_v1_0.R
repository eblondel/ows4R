# test_WCSClient_v1_0.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Integration tests for WCS Client version 1.0
#=======================
require(ows4R, quietly = TRUE)
require(testthat)
context("WCS")

test_that("WCS 1.0 - Thredds",{
  testthat::skip_on_cran()
  #TODO replace with a local dockerized Thredds 
  wcs <- WCSClient$new("https://rsg.pml.ac.uk/thredds/wcs/CCI_ALL-v5.0-MONTHLY", "1.0", logger = "DEBUG")
  expect_is(wcs, "WCSClient")
  caps <- wcs$getCapabilities()
  expect_is(caps, "WCSCapabilities")
  expect_true(length(caps$getCoverageSummaries())>0)
  
  chloroa <- caps$findCoverageSummaryById("chlor_a")
  expect_is(chloroa, "WCSCoverageSummary")
  chloroa_desc <- chloroa$getDescription()
  expect_is(chloroa_desc, "WCSCoverageDescription")
  domain <- chloroa_desc$getDomain()
  expect_is(domain, "WCSCoverageDomain")
  expect_is(domain$getSpatialDomain(), "WCSCoverageSpatialDomain")
  expect_is(domain$getSpatialDomain()$getEnvelopes()[[1]], "GMLEnvelopeWithTimePeriod")
  expect_is(domain$getSpatialDomain()$getGrids()[[1]], "GMLRectifiedGrid")
  expect_is(domain$getTemporalDomain(), "WCSCoverageTemporalDomain")
  expect_true(length(domain$getTemporalDomain()$getInstants())>0)
  
  chloroa_data <- chloroa$getCoverage(time = chloroa_desc$Domain$temporalDomain$instants[1])
  
})

test_that("WCS 1.0.0 - GeoServer",{
  testthat::skip_on_cran()
  wcs <- WCSClient$new("http://localhost:8080/geoserver/wcs", "1.0.0", logger = "DEBUG")
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

#DATASOURCES OF INTEREST

test_that("WCS 1.0.0 - PML",{
  testthat::skip_on_cran()
  wcs <- WCSClient$new("https://rsg.pml.ac.uk/thredds/wcs/PML-HAB-Maps-Pseudo-nitzschia-eurohab-subset-olci", "1.0", logger = "DEBUG")
  expect_is(wcs, "WCSClient")
  caps <- wcs$getCapabilities()
  expect_is(caps, "WCSCapabilities")
  expect_true(length(caps$getCoverageSummaries())>0)
  
  cov <- caps$findCoverageSummaryById("harmful_un")
  expect_is(cov, "WCSCoverageSummary")
  cov_desc <- cov$getDescription()
  expect_is(cov_desc, "WCSCoverageDescription")
  
  cov_data <- cov$getCoverage(time = "2019-07-18T11:17:00Z", filename = "test.tif")
  cov_stack <- cov$getCoverageStack(time = "2019-07-18T11:17:00Z", filename_handler = function(identifier, time, elevation, bbox, format){"test.tif"})
  expect_true(terra::compareGeom(cov_data,cov_stack))
  
})
