# test_WPSClient_v1_0_0.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Integration tests for WPS Client version 1.0.0
#=======================
require(ows4R, quietly = TRUE)
require(testthat)
context("WPS")

test_that("WPS 1.0.0",{
  wps <- WPSClient$new("http://localhost:8080/geoserver/wps", serviceVersion = "1.0.0", logger = "INFO")
  expect_is(wps, "WPSClient")
  caps <- wps$getCapabilities()
  expect_is(caps, "WPSCapabilities")
  
  processes <- caps$getProcesses(pretty = FALSE)
  expect_is(processes, "list")
  processes.df <- caps$getProcesses(pretty = TRUE)
  expect_is(processes.df, "data.frame")
  
  #process description
  desc <- caps$describeProcess(identifier = "JTS:area")
  expect_is(desc, "WPSProcessDescription")
  expect_equal(length(desc$getDataInputs()), 1L)
  
  #process execution
  exec <- caps$execute(
    identifier = "JTS:area", 
    dataInputs = list(
      geom = WPSComplexData$new( value = "MULTIPOLYGON(((1 1,5 1,5 5,1 5,1 1),(2 2,2 3,3 3,3 2,2 2)),((6 3,9 2,9 4,6 3)))", mimeType = "application/wkt")
    )
  )
  expect_is(exec, "WPSExecuteResponse")
  expect_equal(exec$getProcessOutputs()[[1]]$getDataValue(), 18)
  
})