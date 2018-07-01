# test_CSWConstraint.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for CSW Constraint
#=======================
require(ows4R, quietly = TRUE)
require(geometa)
require(testthat)
context("CSWConstraint")

test_that("CSWConstraint",{
  filter <- OGCFilter$new( PropertyIsEqualTo$new("apiso:Identifier", "12345") )
  cons <- CSWConstraint$new(filter = filter)
  cons_xml <- cons$encode()
  children1 <- xmlChildren(cons_xml)
  expect_equal(length(children1), 1L)
  ogcFilter <- children1[[1]]
  expect_equal(xmlName(ogcFilter), "Filter")
  property <- xmlChildren(ogcFilter)[[1]]
  expect_equal(xmlName(property), "PropertyIsEqualTo")
  property.children <- xmlChildren(property)
  expect_equal(length(property.children), 2L)
  expect_equal(xmlName(property.children[[1]]), "PropertyName")
  expect_equal(xmlValue(property.children[[1]]), "apiso:Identifier")
  expect_equal(xmlName(property.children[[2]]), "Literal")
  expect_equal(xmlValue(property.children[[2]]), "12345")
})
