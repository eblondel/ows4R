# test_CSW.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Integration tests for CSW Client
#=======================
require(ows4R, quietly = TRUE)
require(geometa)
require(testthat)
context("CSW")

#CSW 2.0.2 – GetCapabilities

test_that("CSW 2.0.2 - GetCapabilities | GeoNetwork",{
  csw <- CSWClient$new("http://localhost:8282/geonetwork/srv/eng/csw", "2.0.2", logger = "INFO")
  expect_is(csw, "CSWClient")
  caps <- csw$getCapabilities()
  expect_is(caps, "CSWCapabilities")
})

test_that("CSW 2.0.2 - GetCapabilities | pycsw",{
  csw <- CSWClient$new("http://demo.pycsw.org/cite/csw", "2.0.2", logger="INFO")
  expect_is(csw, "CSWClient")
  caps <- csw$getCapabilities()
  expect_is(caps, "CSWCapabilities")
})

#CSW 2.0.2 – DescribeRecord

#test_that("CSW 2.0.2 - DescribeRecord",{
#  csw <- CSWClient$new("http://localhost:8282/geonetwork/srv/en/csw", "2.0.2", logger = "INFO")
#  xsd <- csw$describeRecord(outputSchema = "http://www.isotc211.org/2005/gmd")
#})

#CSW 2.0.2 – GetRecordById

test_that("CSW 2.0.2 - GetRecordById",{
  csw <- CSWClient$new("http://www.fao.org/geonetwork/srv/en/csw", "2.0.2", logger = "INFO")
  md <- csw$getRecordById("fao-species-map-tth", outputSchema = "http://www.isotc211.org/2005/gmd")
  expect_is(md, "ISOMetadata")
})

#CSW 2.0.2 – GetRecords

test_that("CSW 2.0.2 - GetRecords",{
  csw <- CSWClient$new("http://www.fao.org/geonetwork/srv/en/csw", "2.0.2", logger = "INFO")
  mdlist <- csw$getRecords(constraint = "AnyText+like+%cwp-grid%", outputSchema = "http://www.isotc211.org/2005/gmd")
  expect_equal(unique(sapply(mdlist, is)), "ISOMetadata")
})

