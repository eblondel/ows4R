# test_WPSClient_v1_0_0.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Integration tests for WPS Client version 1.0.0
#=======================
require(ows4R, quietly = TRUE)
require(testthat)
context("WPS")

test_that("WPS 1.0.0",{
  wps <- WPSClient$new("http://localhost:8080/geoserver/wps", serviceVersion = "1.0.0", logger = "DEBUG")
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
  
  #jts process execution
  exec <- caps$execute(
    identifier = "JTS:area", 
    dataInputs = list(
      geom = WPSComplexData$new( value = "MULTIPOLYGON(((1 1,5 1,5 5,1 5,1 1),(2 2,2 3,3 3,3 2,2 2)),((6 3,9 2,9 4,6 3)))", mimeType = "application/wkt")
    )
  )
  expect_is(exec, "WPSExecuteResponse")
  expect_equal(exec$getProcessOutputs()[[1]]$getDataValue(), 18)
  
  #vector process execution from raw xml
  exec <- caps$execute(
    identifier = "vec:Bounds",
    dataInputs = list(
      features = WPSComplexData$new( value = as(XML::xmlParse("http://localhost:8080/geoserver/topp/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=topp%3Astates&maxFeatures=1"),"character"),
                                     mimeType = "text/xml; subtype=wfs-collection/1.0")
    )
  )
  
  #vector process execution with sf object
  wfs <- WFSClient$new("http://localhost:8080/geoserver/wfs", "1.1.0", logger = "DEBUG")
  wfs.caps <- wfs$getCapabilities()
  ft <- wfs.caps$findFeatureTypeByName("topp:tasmania_water_bodies")
  ft.sp <- ft$getFeatures()
  
  #text/xml; subtype=wfs-collection/1.0
  exec_wfs10_subtype <- caps$execute(
    identifier = "vec:Bounds",
    dataInputs = list(
        features = WPSComplexData$new( value = ft.sp, mimeType = "text/xml; subtype=wfs-collection/1.0")
    )
  )
  #text/xml; subtype=wfs-collection/1.1
  exec_wfs11_subtype <- caps$execute(
    identifier = "vec:Bounds",
    dataInputs = list(
      features = WPSComplexData$new( value = ft.sp, mimeType = "text/xml; subtype=wfs-collection/1.1")
    )
  )
  expect_equal(
    exec_wfs10_subtype$getProcessOutputs()[[1]]$getData()$getBBOX(),
    exec_wfs11_subtype$getProcessOutputs()[[1]]$getData()$getBBOX()  
  )
  
  #application/wfs-collection-1.0
  exec_wfs10_app <- caps$execute(
    identifier = "vec:Bounds",
    dataInputs = list(
      features = WPSComplexData$new( value = ft.sp, mimeType = "application/wfs-collection-1.0")
    )
  )
  #application/wfs-collection-1.1
  exec_wfs11_app <- caps$execute(
    identifier = "vec:Bounds",
    dataInputs = list(
      features = WPSComplexData$new( value = ft.sp, mimeType = "application/wfs-collection-1.1")
    )
  )
  expect_equal(
    exec_wfs10_app$getProcessOutputs()[[1]]$getData()$getBBOX(),
    exec_wfs11_app$getProcessOutputs()[[1]]$getData()$getBBOX()  
  )
  
})