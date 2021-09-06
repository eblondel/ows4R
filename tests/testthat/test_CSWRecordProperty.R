# test_CSWRecordProperty.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for CSW RecordProperty
#=======================
require(ows4R, quietly = TRUE)
require(geometa)
require(XML)
require(testthat)
context("CSWRecordProperty")

test_that("CSWRecordProperty",{
  rp <- CSWRecordProperty$new(name = "NAME", value = "VALUE")
  rp_xml <- rp$encode()
  children <- xmlChildren(rp_xml)
  expect_equal(length(children), 2L)
  expect_equal(xmlValue(children[[1]]), "NAME")
  expect_equal(xmlValue(children[[2]]), "VALUE")
})
