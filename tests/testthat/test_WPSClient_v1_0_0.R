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
  
  #geometry process from raw xml
  #-------------------------------------------------------------------------------------
  #to investigate
  if(FALSE){
    require(sf)
    require(geometa)
    outer = matrix(c(0,0,10,0,10,10,0,10,0,0),ncol=2, byrow=TRUE)
    hole1 = matrix(c(1,1,1,2,2,2,2,1,1,1),ncol=2, byrow=TRUE)
    hole2 = matrix(c(5,5,5,6,6,6,6,5,5,5),ncol=2, byrow=TRUE)
    pts = list(outer, hole1, hole2)
    pl1 = st_polygon(pts)
    pts3 = lapply(pts, function(x) cbind(x, 0))
    pl2 = st_polygon(pts3)
    pl3 = st_polygon(pts3, "XYM")
    pts4 = lapply(pts3, function(x) cbind(x, 0))
    pl4 = st_polygon(pts4)
    pol1 = list(outer, hole1, hole2)
    pol2 = list(outer + 12, hole1 + 12)
    pol3 = list(outer + 24)
    mp = list(pol1,pol2,pol3)
    mpl = st_multipolygon(mp)
    md <- GMLMultiSurface$new(sfg = mpl)
    xml <- md$encode()
    
    exec <- caps$execute(
      identifier = "JTS:area",
      dataInputs = list(
        geom = WPSComplexData$new(value = as(xml, "character"), mimeType = "text/xml; subtype=gml/3.1.1")
      )
    )
  }
  
  
  #vector process execution from raw xml
  #-------------------------------------------------------------------------------------
  exec <- caps$execute(
    identifier = "vec:Bounds",
    dataInputs = list(
      features = WPSComplexData$new( value = as(XML::xmlParse("http://localhost:8080/geoserver/topp/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=topp%3Astates&maxFeatures=1"),"character"),
                                     mimeType = "text/xml; subtype=wfs-collection/1.0")
    )
  )
  
  #vector process execution with sf object
  #-------------------------------------------------------------------------------------
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
  expect_equal(
    exec_wfs10_subtype$getProcessOutputs()[[1]]$getData()$getBBOX(),
    exec_wfs10_app$getProcessOutputs()[[1]]$getData()$getBBOX()  
  )
  expect_equal(
    exec_wfs11_subtype$getProcessOutputs()[[1]]$getData()$getBBOX(),
    exec_wfs11_app$getProcessOutputs()[[1]]$getData()$getBBOX()  
  )
  
  
  
  
  
})