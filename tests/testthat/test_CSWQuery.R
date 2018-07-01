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

test_that("CSWQuery - cqlText with title",{
  cons <- CSWConstraint$new(cqlText = "dc:title like '%ips%'")
  query <- CSWQuery$new(constraint = cons)
  expect_is(query, "CSWQuery")
})

test_that("CSW 2.0.2 - Query - Filter / AnyText",{
  filter <- OGCFilter$new( PropertyIsLike$new("csw:AnyText", "%Physio%"))
  cons <- CSWConstraint$new(filter = filter)
  query <- CSWQuery$new(constraint = cons)
  expect_is(query, "CSWQuery")
})

test_that("CSW 2.0.2 - Query - Filter / AnyText Equal",{
  filter <- OGCFilter$new( PropertyIsEqualTo$new("csw:AnyText", "species"))
  cons <- CSWConstraint$new(filter = filter)
  query <- CSWQuery$new(constraint = cons)
  expect_is(query, "CSWQuery")
})

test_that("CSW 2.0.2 - Query - Filter / AnyText And Not",{
  filter <- OGCFilter$new(And$new(
    PropertyIsLike$new("csw:AnyText", "%lorem%"),
    PropertyIsLike$new("csw:AnyText", "%ipsum%"),
    Not$new(
      PropertyIsLike$new("csw:AnyText", "%dolor%")
    )
  ))
  cons <- CSWConstraint$new(filter = filter)
  query <- CSWQuery$new(constraint = cons)
  expect_is(query, "CSWQuery")
})

test_that("CSW 2.0.2 - Query - Filter / AnyText And nested Or",{
  filter <- OGCFilter$new(And$new(
    PropertyIsEqualTo$new("dc:title", "Aliquam fermentum purus quis arcu"),
    PropertyIsEqualTo$new("dc:format", "application/pdf"),
    Or$new(
      PropertyIsEqualTo$new("dc:type", "http://purl.org/dc/dcmitype/Dataset"),
      PropertyIsEqualTo$new("dc:type", "http://purl.org/dc/dcmitype/Service"),
      PropertyIsEqualTo$new("dc:type", "http://purl.org/dc/dcmitype/Image"),
      PropertyIsEqualTo$new("dc:type", "http://purl.org/dc/dcmitype/Text")
    )
  ))
  cons <- CSWConstraint$new(filter = filter)
  query <- CSWQuery$new(elementSetName = "brief", constraint = cons)
  expect_is(query, "CSWQuery")
})

test_that("CSW 2.0.2 - Query - Filter / BBOX",{
  bbox <- matrix(c(-180,180,-90,90), nrow = 2, ncol = 2, byrow = TRUE,
                 dimnames = list(c("x", "y"), c("min","max")))
  filter <- OGCFilter$new( BBOX$new(bbox = bbox) )
  cons <- CSWConstraint$new(filter = filter)
  query <- CSWQuery$new(elementSetName = "brief", constraint = cons)
  expect_is(query, "CSWQuery")
})

