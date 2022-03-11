# test_WFSClient_v2_0_0.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Integration tests for WFS Client version 2.0.0
#=======================
require(ows4R, quietly = TRUE)
require(testthat)
context("WFS")

test_that("WFS 2.0.0",{
  wfs <- WFSClient$new("http://localhost:8080/geoserver/wfs", "2.0.0", logger = "INFO")
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

#DATASOURCES OF INTEREST

test_that("WFS 2.0.0 - VLIZ", {
  wfs = WFSClient$new(url = "http://geo.vliz.be/geoserver/wfs", serviceVersion = "2.0.0", logger = "DEBUG")
  expect_is(wfs, "WFSClient")
  caps <- wfs$getCapabilities()
  expect_is(caps, "WFSCapabilities")
})

test_that("WFS 2.0.0 - Emodnet Geology", {
  wfs = WFSClient$new(url = "https://drive.emodnet-geology.eu/geoserver/wfs", serviceVersion = "2.0.0", 
                      config = httr::config(ssl_cipher_list='DEFAULT@SECLEVEL=1'), logger = "DEBUG")
  expect_is(wfs, "WFSClient")
  caps <- wfs$getCapabilities()
  expect_is(caps, "WFSCapabilities")
})