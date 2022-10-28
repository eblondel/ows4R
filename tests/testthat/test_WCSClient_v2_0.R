# test_WCSClient_v2_0.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Integration tests for WCS Client version 2.0
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
  expect_true(length(caps$getCoverageSummaries())>0)
  
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
  expect_true(length(caps$getCoverageSummaries())>0)
  
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

test_that("WCS 2.0.1 - Rasdaman - Spatio-Temporal Coverages",{
  testthat::skip_on_cran()
  wcs <- WCSClient$new("https://ows.rasdaman.org/rasdaman/ows", "2.0.1", logger = "DEBUG")
  
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

#DATASOURCES OF INTEREST

test_that("WCS 2.0.1 - Emodnet Bathymetry",{
  testthat::skip_on_cran()
  emodnet <- WCSClient$new(url = "https://ows.emodnet-bathymetry.eu/wcs", serviceVersion = "2.0.1", logger = "DEBUG")
  bathy <- emodnet$getCapabilities()$findCoverageSummaryById("emodnet__mean", exact = TRUE)
  bathy_des <- bathy$getDescription()
  bbox <- OWSUtils$toBBOX(-9.74885843385535,-6.40719176724215,46.57884310043864,48.46009310040854)
  bathy_data <- bathy$getCoverage(bbox = bbox)
  bathy_data_stack <- bathy$getCoverageStack(bbox = bbox)
  expect_true(terra::compareGeom(bathy_data,bathy_data_stack))
  
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
  expect_true(terra::compareGeom(cov_data,cov_data_stack))
  
  #compare with data returned by WMS GetFeatureInfo
  vliz_wms <- WMSClient$new(url = "https://geo.vliz.be/geoserver/wms", service = "1.1.1", logger = "DEBUG")
  gfi <- vliz_wms$getFeatureInfo(layer = "Emodnetbio:aca_spp_19582016_L1", feature_count = 1, 
                                 x = 50, y = 50, srs = "EPSG:4326", 
                                 width = 101, height = 101, 
                                 bbox = OWSUtils$toBBOX(8.12713623046875,8.68194580078125,57.92266845703125,58.47747802734375))
  expect_equal(terra::values(cov_data)[[1]], gfi$relative_abundance)
  
})

test_that("WCS 2.0.1 - UN-FAO - ASIS",{
  testthat::skip_on_cran()
  #wcs <- WCSClient$new(url = "https://io.apps.fao.org/geoserver/wcs/ASIS/HDF/v2", serviceVersion = "2.0.1", logger = "DEBUG")
  #covnames <- sapply(wcs$capabilities$getCoverageSummaries(), function(x){x$getId()})
  #cov <- wcs$capabilities$findCoverageSummaryById("ASIS__hdf", exact = TRUE)
  #cov_data <- cov$getCoverage(bbox = OWSUtils$toBBOX(-90.3159,12.8091,-87.4539,14.6022), filename = "test_asis.tif")
  #expect_is(cov_data, "SpatRaster")
})