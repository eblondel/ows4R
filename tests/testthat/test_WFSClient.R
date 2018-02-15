# test_WFS.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Integration tests for WFS Client
#=======================
require(ows4R, quietly = TRUE)
require(testthat)
context("WFS")

test_that("WFS 1.0.0",{
  wfs <- WFSClient$new("http://localhost:8080/geoserver/ows?", "1.0.0")
  expect_is(wfs, "WFSClient")
  caps <- wfs$getCapabilities()
  expect_is(caps, "WFSCapabilities")
  ft <- caps$findFeatureTypeByName("topp:tasmania_water_bodies", exact = TRUE)
  expect_is(ft, "WFSFeatureType")
  ft.sp <- ft$getFeatures()
  expect_is(ft.sp, "SpatialPolygonsDataFrame")
})

test_that("WFS 1.1.0",{
  wfs <- WFSClient$new("http://localhost:8080/geoserver/ows?", "1.1.0")
  expect_is(wfs, "WFSClient")
  caps <- wfs$getCapabilities()
  expect_is(caps, "WFSCapabilities")
  ft <- caps$findFeatureTypeByName("topp:tasmania_water_bodies", exact = TRUE)
  expect_is(ft, "WFSFeatureType")
  ft.sp <- ft$getFeatures()
  expect_is(ft.sp, "SpatialPolygonsDataFrame")
})

test_that("WFS 2.0.0",{
  wfs <- WFSClient$new("http://localhost:8080/geoserver/ows?", "2.0.0")
  expect_is(wfs, "WFSClient")
  caps <- wfs$getCapabilities()
  expect_is(caps, "WFSCapabilities")
  ft <- caps$findFeatureTypeByName("topp:tasmania_water_bodies", exact = TRUE)
  expect_is(ft, "WFSFeatureType")
  ft.sp <- ft$getFeatures()
  expect_is(ft.sp, "SpatialPolygonsDataFrame")
})