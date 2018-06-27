# test_OGCExpression.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for OGC expressions
#=======================
require(ows4R, quietly = TRUE)
require(geometa)
require(testthat)
context("OGCExpression")

test_that("PropertyIsEqualTo",{
  expr <- PropertyIsEqualTo$new(PropertyName = "property", Literal = "value")
  expect_is(expr, "OGCExpression")
  expect_is(expr, "BinaryComparisonOpType")
  expect_is(expr, "PropertyIsEqualTo")
  children <- xmlChildren(expr$encode())
  expect_equal(length(children), 2L)
  expect_equal(xmlName(children[[1]]), "PropertyName")
  expect_equal(xmlName(children[[2]]), "Literal")
  expect_equal(xmlValue(children[[1]]), "property")
  expect_equal(xmlValue(children[[2]]), "value")
})

test_that("PropertyIsNotEqualTo",{
  expr <- PropertyIsNotEqualTo$new(PropertyName = "property", Literal = "value")
  expect_is(expr, "OGCExpression")
  expect_is(expr, "BinaryComparisonOpType")
  expect_is(expr, "PropertyIsNotEqualTo")
  children <- xmlChildren(expr$encode())
  expect_equal(length(children), 2L)
  expect_equal(xmlName(children[[1]]), "PropertyName")
  expect_equal(xmlName(children[[2]]), "Literal")
  expect_equal(xmlValue(children[[1]]), "property")
  expect_equal(xmlValue(children[[2]]), "value")
})

test_that("PropertyIsLessThan",{
  expr <- PropertyIsLessThan$new(PropertyName = "property", Literal = "value")
  expect_is(expr, "OGCExpression")
  expect_is(expr, "BinaryComparisonOpType")
  expect_is(expr, "PropertyIsLessThan")
  children <- xmlChildren(expr$encode())
  expect_equal(length(children), 2L)
  expect_equal(xmlName(children[[1]]), "PropertyName")
  expect_equal(xmlName(children[[2]]), "Literal")
  expect_equal(xmlValue(children[[1]]), "property")
  expect_equal(xmlValue(children[[2]]), "value")
})

test_that("PropertyIsGreaterThan",{
  expr <- PropertyIsGreaterThan$new(PropertyName = "property", Literal = "value")
  expect_is(expr, "OGCExpression")
  expect_is(expr, "BinaryComparisonOpType")
  expect_is(expr, "PropertyIsGreaterThan")
  children <- xmlChildren(expr$encode())
  expect_equal(length(children), 2L)
  expect_equal(xmlName(children[[1]]), "PropertyName")
  expect_equal(xmlName(children[[2]]), "Literal")
  expect_equal(xmlValue(children[[1]]), "property")
  expect_equal(xmlValue(children[[2]]), "value")
})

test_that("PropertyIsLessThanOrEqualTo",{
  expr <- PropertyIsLessThanOrEqualTo$new(PropertyName = "property", Literal = "value")
  expect_is(expr, "OGCExpression")
  expect_is(expr, "BinaryComparisonOpType")
  expect_is(expr, "PropertyIsLessThanOrEqualTo")
  children <- xmlChildren(expr$encode())
  expect_equal(length(children), 2L)
  expect_equal(xmlName(children[[1]]), "PropertyName")
  expect_equal(xmlName(children[[2]]), "Literal")
  expect_equal(xmlValue(children[[1]]), "property")
  expect_equal(xmlValue(children[[2]]), "value")
})

test_that("PropertyIsGreaterThanOrEqualTo",{
  expr <- PropertyIsGreaterThanOrEqualTo$new(PropertyName = "property", Literal = "value")
  expect_is(expr, "OGCExpression")
  expect_is(expr, "BinaryComparisonOpType")
  expect_is(expr, "PropertyIsGreaterThanOrEqualTo")
  children <- xmlChildren(expr$encode())
  expect_equal(length(children), 2L)
  expect_equal(xmlName(children[[1]]), "PropertyName")
  expect_equal(xmlName(children[[2]]), "Literal")
  expect_equal(xmlValue(children[[1]]), "property")
  expect_equal(xmlValue(children[[2]]), "value")
})

