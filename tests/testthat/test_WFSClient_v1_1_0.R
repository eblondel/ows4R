# test_WFSClient_v1_1_0.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Integration tests for WFS Client version 1.1.0
#=======================
require(ows4R, quietly = TRUE)
require(testthat)
context("WFS")

test_that("WFS 1.1.0",{
  wfs <- WFSClient$new("http://localhost:8080/geoserver/wfs", "1.1.0", logger = "INFO")
  expect_is(wfs, "WFSClient")
  caps <- wfs$getCapabilities()
  expect_is(caps, "WFSCapabilities")
  ft <- caps$findFeatureTypeByName("topp:tasmania_water_bodies")
  expect_is(ft, "WFSFeatureType")
  ft.des <- ft$getDescription()
  expect_is(ft.des, "list")
  ft.sp <- ft$getFeatures()
  expect_is(ft.sp, "sf")
  expect_is(ft.sp, "data.frame")
})
