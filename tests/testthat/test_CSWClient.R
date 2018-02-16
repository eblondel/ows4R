# test_CSW.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Integration tests for CSW Client
#=======================
require(ows4R, quietly = TRUE)
require(testthat)
context("WFS")

test_that("CSW 2.0.2",{
  csw <- CSWClient$new("http://localhost:8282/geonetwork/srv/eng/csw", "2.0.2")
  expect_is(csw, "CSWClient")
  caps <- csw$getCapabilities()
  expect_is(caps, "CSWCapabilities")
})