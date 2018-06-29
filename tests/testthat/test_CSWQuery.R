# test_CSWQuery.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Unit tests for CSW Query
#=======================
require(ows4R, quietly = TRUE)
require(geometa)
require(testthat)
context("CSWQuery")

test_that("CSWQuery - elementSetName",{
  query_full <- CSWQuery$new()
  expect_is(query_full, "CSWQuery")
  expect_equal(query_full$ElementSetName, "full")
  query_brief <- CSWQuery$new(elementSetName = "brief")
  expect_is(query_brief, "CSWQuery")
  expect_equal(query_brief$ElementSetName, "brief")
  query_summary <- CSWQuery$new(elementSetName = "summary")
  expect_is(query_summary, "CSWQuery")
  expect_equal(query_summary$ElementSetName, "summary")
})

test_that("CSWQuery - cqlText with title"{
  cons <- CSWConstraint$new(cqlText = "dc:title like '%ips%'")
  query <- CSWQuery$new(constraint = cons)
})
