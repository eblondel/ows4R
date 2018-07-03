# test_CSW.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Integration tests for CSW Client
#=======================
require(ows4R, quietly = TRUE)
require(geometa)
require(testthat)
context("CSWClient")

#data
mdfile <- system.file("extdata/data", "metadata.xml", package = "ows4R")
md <- geometa::ISOMetadata$new(xml = xmlParse(mdfile))

#CSW 2.0.2 - pycsw
#==========================================================================
req <- GET("http://localhost:8000/csw?service=CSW&request=GetCapabilities&version=2.0.2", verbose())
content(req)
req <- GET("http://google.com/", verbose())
content(req)
csw2 <- CSWClient$new("http://localhost:8000/csw", "2.0.2", logger="INFO")

#CSW 2.0.2 – GetCapabilities
#--------------------------------------------------------------------------
#--> pycsw
test_that("CSW 2.0.2 - GetCapabilities | pycsw",{
  expect_is(csw2, "CSWClient")
  expect_equal(csw2$getVersion(), "2.0.2")
  caps <- csw2$getCapabilities()
  expect_is(caps, "CSWCapabilities")
  
  #service identification
  SI <- caps$getServiceIdentification()
  expect_equal(SI$getTitle(), "pycsw Geospatial Catalogue")
  expect_equal(SI$getAbstract(), "pycsw is an OGC CSW server implementation written in Python")
  expect_equal(SI$getServiceType(), "CSW")
  expect_equal(SI$getServiceTypeVersion(), c("2.0.2","3.0.0"))
  expect_equal(SI$getKeywords(), c("catalogue","discovery","metadata"))
  expect_equal(SI$getFees(), "None")
  expect_equal(SI$getAccessConstraints(), "None")
  
  #service provider
  SP <- caps$getServiceProvider()
  expect_equal(SP$getProviderName(), "Organization Name")
  expect_is(SP$getProviderSite(), "ISOOnlineResource")
  expect_equal(SP$getProviderSite()$linkage$value, "http://pycsw.org/")
  rp <- SP$getServiceContact()
  expect_is(rp, "ISOResponsibleParty")
  expect_equal(rp$individualName, "Lastname, Firstname")
  expect_equal(rp$positionName, "Position Title")
  contact <- rp$contactInfo
  expect_is(contact, "ISOContact")
  expect_is(contact$phone, "ISOTelephone")
  expect_equal(contact$phone$voice, "+xx-xxx-xxx-xxxx")
  expect_equal(contact$phone$facsimile, "+xx-xxx-xxx-xxxx")
  expect_is(contact$address, "ISOAddress")
  expect_equal(contact$address$deliveryPoint, "Mailing Address")
  expect_equal(contact$address$city, "City")
  expect_equal(contact$address$postalCode, "Zip or Postal Code")
  expect_equal(contact$address$country, "Country")
  expect_equal(contact$address$electronicMailAddress, "you@example.org")
  expect_is(contact$onlineResource, "ISOOnlineResource")
  expect_equal(contact$onlineResource$linkage$value, "Contact URL")
  
  #service operation metadata
  OPM <- caps$getOperationsMetadata()
  OP <- OPM$getOperations()
  expect_is(OP, "list")
  expect_equal(length(OP), 8L)
  expect_equal(unique(sapply(OP, function(i){class(i)[1]})), "OWSOperation")
  operations <- sapply(OP,function(op){op$getName()})
  expect_equal(operations, c("GetCapabilities", "DescribeRecord", "GetDomain", "GetRecords", 
                             "GetRecordById", "GetRepositoryItem", "Transaction", "Harvest"))
  
})

#CSW 2.0.2 – DescribeRecord
#--------------------------------------------------------------------------
#test_that("CSW 2.0.2 - DescribeRecord",{
#  xsd <- csw2$describeRecord(namespace = "http://www.isotc211.org/2005/gmd")
#})

#CSW 2.0.2 – Transaction
#--------------------------------------------------------------------------

#Insert
test_that("CSW 2.0.2 - Transaction - Insert",{
  insert <- csw2$insertRecord(record = md)
  expect_true(insert$getResult())
})

#Update (Full)
test_that("CSW 2.0.2 - Transaction - Update (Full)",{
  md$identificationInfo[[1]]$citation$setTitle("a new title")
  update <- csw2$updateRecord(record = md)
  expect_true(update$getResult())
})

test_that("CSW 2.0.2 - Transaction - Update (Partial)",{
  recordProperty <- CSWRecordProperty$new("apiso:Title", "NEW_TITLE")
  filter = OGCFilter$new(PropertyIsEqualTo$new("apiso:Identifier", md$fileIdentifier))
  constraint <- CSWConstraint$new(filter)
  update <- csw2$updateRecord(recordProperty = recordProperty, constraint = constraint)
  expect_true(update$getResult())
})

#Delete
test_that("CSW 2.0.2 - Transaction - Delete",{
  delete <- csw2$deleteRecordById(md$fileIdentifier)
  expect_true(delete$getResult())
})

#CSW 2.0.2 – GetRecordById
#--------------------------------------------------------------------------
test_that("CSW 2.0.2 - GetRecordById",{
  insert <- csw2$insertRecord(record = md)
  if(insert$getResult()){
    md <- csw2$getRecordById("my-metadata-identifier", outputSchema = "http://www.isotc211.org/2005/gmd")
    expect_is(md, "ISOMetadata")
  }
})

#CSW 2.0.2 – GetRecords / csw:Record (Dublin Core)
#--------------------------------------------------------------------------
test_that("CSW 2.0.2 - GetRecords - full",{
  #as Dublin core records (R lists)
  records <- csw2$getRecords(query = CSWQuery$new())
  expect_equal(length(records), 5L)
})

test_that("CSW 2.0.2 - GetRecords - full / maxRecords",{
  #as Dublin core records (R lists)
  records <- csw2$getRecords(query = CSWQuery$new(), maxRecords = 10L)
  expect_equal(length(records), 10L)
})

test_that("CSW 2.0.2 - GetRecords - cqlText / dc:title",{
  cons <- CSWConstraint$new(cqlText = "dc:title like '%ips%'")
  query <- CSWQuery$new(constraint = cons)
  records <- csw2$getRecords(query = query)
  expect_equal(length(records), 2L)
})

test_that("CSW 2.0.2 - GetRecords - cqlText / dc:title and dc:abstract",{
  cons <- CSWConstraint$new(cqlText = "dc:title like '%ips%' and dct:abstract like '%pharetra%'")
  query <- CSWQuery$new(constraint = cons)
  records <- csw2$getRecords(query = query)
  expect_equal(length(records), 1L)
})

test_that("CSW 2.0.2 - GetRecords - cqlText / dc:identifier",{
  cons <- CSWConstraint$new(cqlText = "dc:identifier = 'my-metadata-identifier'")
  query <- CSWQuery$new(constraint = cons)
  records <- csw2$getRecords(query = query)
  expect_equal(length(records), 1L)
})

test_that("CSW 2.0.2 - GetRecords - Filter / AnyText",{
  filter <- OGCFilter$new( PropertyIsLike$new("csw:AnyText", "%Physio%"))
  cons <- CSWConstraint$new(filter = filter)
  query <- CSWQuery$new(constraint = cons)
  records <- csw2$getRecords(query = query)
  expect_equal(length(records), 2L)
})

test_that("CSW 2.0.2 - GetRecords - Filter / AnyText Equal",{
  filter <- OGCFilter$new( PropertyIsEqualTo$new("csw:AnyText", "species"))
  cons <- CSWConstraint$new(filter = filter)
  query <- CSWQuery$new(constraint = cons)
  records <- csw2$getRecords(query = query)
  expect_equal(length(records), 0L)
})

test_that("CSW 2.0.2 - GetRecords - Filter / AnyText And Not",{
  filter <- OGCFilter$new(And$new(
    PropertyIsLike$new("csw:AnyText", "%lorem%"),
    PropertyIsLike$new("csw:AnyText", "%ipsum%"),
    Not$new(
      PropertyIsLike$new("csw:AnyText", "%dolor%")
    )
  ))
  cons <- CSWConstraint$new(filter = filter)
  query <- CSWQuery$new(constraint = cons)
  records <- csw2$getRecords(query = query)
  expect_equal(length(records), 1L)
})

test_that("CSW 2.0.2 - GetRecords - Filter / AnyText And nested Or",{
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
  records <- csw2$getRecords(query = query)
  expect_equal(length(records), 1L)
})

test_that("CSW 2.0.2 - GetRecords - Filter / BBOX",{
  bbox <- matrix(c(-180,180,-90,90), nrow = 2, ncol = 2, byrow = TRUE,
          dimnames = list(c("x", "y"), c("min","max")))
  filter <- OGCFilter$new( BBOX$new(bbox = bbox) )
  cons <- CSWConstraint$new(filter = filter)
  query <- CSWQuery$new(elementSetName = "brief", constraint = cons)
  records <- csw2$getRecords(query = query)
  expect_equal(length(records), 3L)
})

#CSW 2.0.2 – GetRecords / gmd:MD_Metadata (ISO 19115/19319 - R geometa binding)
#--------------------------------------------------------------------------

test_that("CSW 2.0.2 - GetRecords - cqlText / dc:identifier",{
  cons <- CSWConstraint$new(cqlText = "dc:identifier = 'my-metadata-identifier'")
  query <- CSWQuery$new(constraint = cons)
  records <- csw2$getRecords(query = query, outputSchema = "http://www.isotc211.org/2005/gmd")
  expect_equal(length(records), 1L)
  expect_is(records[[1]], "ISOMetadata")
})

#CSW 2.0.2 - FAO Geonetwork
#==========================================================================
fao_csw <- CSWClient$new("http://www.fao.org/geonetwork/srv/en/csw", "2.0.2", logger="INFO")

#CSW 2.0.2 – GetRecords / gmd:MD_Metadata (ISO 19115/19319 - R geometa binding)
#--------------------------------------------------------------------------
test_that("CSW 2.0.2 - GetRecords - cqlText / dc:identifier",{
  cons <- CSWConstraint$new(cqlText = "dc:identifier like '%firms%'")
  query <- CSWQuery$new(constraint = cons)
  records <- csw2$getRecords(query = query, outputSchema = "http://www.isotc211.org/2005/gmd")
  expect_equal(length(records), 2L)
  expect_true(unique(sapply(records, is, "ISOMetadata")))
})


#CSW 3.0
#==========================================================================
csw3 <- CSWClient$new("http://localhost:8000/csw", "3.0", logger="INFO")

#CSW 3.0 – GetCapabilities
#--------------------------------------------------------------------------
#--> pycsw
test_that("CSW 3.0 - GetCapabilities | pycsw",{
  expect_is(csw3, "CSWClient")
  expect_equal(csw3$getVersion(), "3.0")
  caps <- csw3$getCapabilities()
  expect_is(caps, "CSWCapabilities")
  
  #service identification
  SI <- caps$getServiceIdentification()
  expect_equal(SI$getTitle(), "pycsw Geospatial Catalogue")
  expect_equal(SI$getAbstract(), "pycsw is an OGC CSW server implementation written in Python")
  expect_equal(SI$getServiceType(), "CSW")
  expect_equal(SI$getServiceTypeVersion(), c("2.0.2","3.0.0"))
  expect_equal(SI$getKeywords(), c("catalogue","discovery","metadata"))
  expect_equal(SI$getFees(), "None")
  expect_equal(SI$getAccessConstraints(), "None")
  
  #service provider
  SP <- caps$getServiceProvider()
  expect_equal(SP$getProviderName(), "Organization Name")
  expect_is(SP$getProviderSite(), "ISOOnlineResource")
  expect_equal(SP$getProviderSite()$linkage$value, "http://pycsw.org/")
  rp <- SP$getServiceContact()
  expect_is(rp, "ISOResponsibleParty")
  expect_equal(rp$individualName, "Lastname, Firstname")
  expect_equal(rp$positionName, "Position Title")
  contact <- rp$contactInfo
  expect_is(contact, "ISOContact")
  expect_is(contact$phone, "ISOTelephone")
  expect_equal(contact$phone$voice, "+xx-xxx-xxx-xxxx")
  expect_equal(contact$phone$facsimile, "+xx-xxx-xxx-xxxx")
  expect_is(contact$address, "ISOAddress")
  expect_equal(contact$address$deliveryPoint, "Mailing Address")
  expect_equal(contact$address$city, "City")
  expect_equal(contact$address$postalCode, "Zip or Postal Code")
  expect_equal(contact$address$country, "Country")
  expect_equal(contact$address$electronicMailAddress, "you@example.org")
  expect_is(contact$onlineResource, "ISOOnlineResource")
  expect_equal(contact$onlineResource$linkage$value, "Contact URL")
  
  #service operation metadata
  OPM <- caps$getOperationsMetadata()
  OP <- OPM$getOperations()
  expect_is(OP, "list")
  expect_equal(length(OP), 7L)
  expect_equal(unique(sapply(OP, function(i){class(i)[1]})), "OWSOperation")
  operations <- sapply(OP,function(op){op$getName()})
  expect_equal(operations, c("GetCapabilities", "GetDomain", "GetRecords", "GetRecordById",
                             "GetRepositoryItem", "Transaction", "Harvest"))
  
})

#CSW 3.0 – Transaction
#--------------------------------------------------------------------------

#Insert
test_that("CSW 3.0 - Transaction - Insert",{
  #TBD
})

#Update (Full)
test_that("CSW 3.0 - Transaction - Update (Full)",{
  #TBD
})

test_that("CSW 3.0 - Transaction - Update (Partial)",{
  #TBD
})

#Delete
test_that("CSW 3.0 - Transaction - Delete",{
  #TBD
})

#CSW 3.0 – GetRecordById
#--------------------------------------------------------------------------
test_that("CSW 3.0 - GetRecordById",{
  #TBD
})

#CSW 3.0 – GetRecords
#--------------------------------------------------------------------------
test_that("CSW 3.0 - GetRecords",{
  #TBD
})