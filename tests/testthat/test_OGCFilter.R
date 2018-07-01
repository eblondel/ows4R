# test_OGCFilter.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for OGC filters
#=======================
require(ows4R, quietly = TRUE)
require(geometa)
require(testthat)
context("OGCFilter")

test_that("Filter - PropertyIsEqualTo",{
  expr <- PropertyIsEqualTo$new(PropertyName = "property", Literal = "value")
  filter <- OGCFilter$new(expr)
  expect_is(filter, "OGCFilter")
})
