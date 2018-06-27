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

#CSW 2.0.2
#--------------------------------------------------------------------------
csw <- CSWClient$new("http://localhost:8000/csw", "2.0.2", logger="DEBUG")

#CSW 2.0.2 – GetCapabilities
#--------------------------------------------------------------------------
#--> pycsw
test_that("CSW 2.0.2 - GetCapabilities | pycsw",{
  expect_is(csw, "CSWClient")
  caps <- csw$getCapabilities()
  expect_is(caps, "CSWCapabilities")
  
  #service identification
  SI <- caps$getServiceIdentification()
  expect_equal(SI$getTitle(), "pycsw Geospatial Catalogue")
  expect_equal(SI$getAbstract(), "pycsw is an OGC CSW server implementation written in Python")
  expect_equal(SI$getServiceType(), "CSW")
  expect_equal(SI$getServiceTypeVersion(), "2.0.2")
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
#  xsd <- csw$describeRecord(namespace = "http://www.isotc211.org/2005/gmd")
#})

#CSW 2.0.2 – Transaction
#--------------------------------------------------------------------------

#Insert
test_that("CSW 2.0.2 - Transaction - Insert",{
  insert <- csw$insertRecord(record = md)
  expect_true(insert$getResult())
})

#Update (Full)
test_that("CSW 2.0.2 - Transaction - Update (Full)",{
  md$identificationInfo[[1]]$citation$setTitle("a new title")
  update <- csw$updateRecord(record = md)
  expect_true(update$getResult())
})

test_that("CSW 2.0.2 - Transaction - Update (Partial)",{
  recordProperty <- CSWRecordProperty$new("apiso:Title", "NEW_TITLE")
  filter = OGCFilter$new(PropertyIsEqualTo$new("apiso:Identifier", md$fileIdentifier))
  constraint <- CSWConstraint$new(filter)
  update <- csw$updateRecord(recordProperty = recordProperty, constraint = constraint)
  expect_true(update$getResult())
})

#Delete
test_that("CSW 2.0.2 - Transaction - Delete",{
  delete <- csw$deleteRecordById(md$fileIdentifier)
  expect_true(delete$getResult())
})

#CSW 2.0.2 – GetRecordById
#--------------------------------------------------------------------------
test_that("CSW 2.0.2 - GetRecordById",{
  insert <- csw$insertRecord(record = md)
  if(insert$getResult()){
    md <- csw$getRecordById("my-metadata-identifier", outputSchema = "http://www.isotc211.org/2005/gmd")
    expect_is(md, "ISOMetadata")
  }
})

#CSW 2.0.2 – GetRecords
#--------------------------------------------------------------------------
#test_that("CSW 2.0.2 - GetRecords",{
#  csw <- CSWClient$new("http://www.fao.org/geonetwork/srv/en/csw", "2.0.2", logger = "INFO")
#  mdlist <- csw$getRecords(constraint = "AnyText+like+%cwp-grid%", outputSchema = "http://www.isotc211.org/2005/gmd")
#  expect_equal(unique(sapply(mdlist, is)), "ISOMetadata")
#})

