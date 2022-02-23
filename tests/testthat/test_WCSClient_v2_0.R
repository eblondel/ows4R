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
  
  cov_summary <- caps$findCoverageSummaryById("sf__sfdem")
  expect_is(cov_summary, "WCSCoverageSummary")
  expect_equal(cov_summary$getId(), "sf__sfdem")
  expect_equal(cov_summary$getSubtype(), "RectifiedGridCoverage")
  expect_equal(length(cov_summary$getWGS84BoundingBox()), 1L)
  expect_is(cov_summary$getWGS84BoundingBox()[[1]], "OWSWGS84BoundingBox")
  expect_equal(length(cov_summary$getBoundingBox()), 1L)
  expect_is(cov_summary$getBoundingBox()[[1]], "OWSBoundingBox")
  
  cov_summary_des <- cov_summary$getDescription()
  expect_is(cov_summary_des, "WCSCoverageDescription")
  expect_is(cov_summary_des, "GMLCOVAbstractCoverage")
  
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

#DATASOURCES OF INTEREST

test_that("WCS 2.0.1 - Emodnet Bathymetry",{
  testthat::skip_on_cran()
  emodnet <- WCSClient$new(url = "https://ows.emodnet-bathymetry.eu/wcs", serviceVersion = "2.0.1", logger = "DEBUG")
  bathy <- emodnet$getCapabilities()$findCoverageSummaryById("emodnet__mean", exact = TRUE)
  bathy_des <- bathy$getDescription()
  bbox <- OWSUtils$toBBOX(-9.74885843385535,-6.40719176724215,46.57884310043864,48.46009310040854)
  bathy_data <- bathy$getCoverage(bbox = bbox)
  bathy_data_stack <- bathy$getCoverageStack(bbox = bbox)
  expect_true(raster::compareRaster(bathy_data,bathy_data_stack))
  
  if(FALSE){
    require(rasterVis)
    r <- bathy_data
    r <- raster::crop(r, area)
    r <- raster::mask(r, area)
    r[r>=0] <- NA
    rasterVis::levelplot(r)
  }
  
})

test_that("WCS 2.0.1 - VLIZ",{
  testthat::skip_on_cran()
  vliz <- WCSClient$new(url = "https://geo.vliz.be/geoserver/wcs", serviceVersion = "2.0.1", logger = "DEBUG")
  
  cov <- vliz$getCapabilities()$findCoverageSummaryById("Emodnetbio__aca_spp_19582016_L1", exact = TRUE)
  cov_des <- cov$getDescription()
  cov_data <- cov$getCoverage(
    bbox = OWSUtils$toBBOX(8.37,8.41,58.18,58.24),
    time = cov$getDimensions()[[3]]$coefficients[1]
  )
  cov_data_stack <- cov$getCoverageStack(
    bbox = OWSUtils$toBBOX(8.37,8.41,58.18,58.24),
    time = cov$getDimensions()[[3]]$coefficients[1]
  )
  expect_true(raster::compareRaster(cov_data,cov_data_stack))
  
  #compare with data returned by WMS GetFeatureInfo
  vliz_wms <- WMSClient$new(url = "https://geo.vliz.be/geoserver/wms", service = "1.1.1", logger = "DEBUG")
  gfi <- vliz_wms$getFeatureInfo(layer = "Emodnetbio:aca_spp_19582016_L1", feature_count = 1, 
                                 x = 50, y = 50, srs = "EPSG:4326", 
                                 width = 101, height = 101, 
                                 bbox = OWSUtils$toBBOX(8.12713623046875,8.68194580078125,57.92266845703125,58.47747802734375))
  expect_equal(getValues(cov_data), gfi$relative_abundance)
  
  if(FALSE){
    require(rasterVis)
    rasterVis::levelplot(cov_data)
  }
  
})