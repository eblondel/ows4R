
# test_CSWClient_v3.0.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Integration tests for CSW Client version 3.0
#=======================
require(ows4R, quietly = TRUE)
require(geometa)
require(testthat)
context("CSWClient")

#data
mdfile <- system.file("extdata/data", "metadata.xml", package = "ows4R")
md <- geometa::ISOMetadata$new(xml = XML::xmlParse(mdfile))

#CSW 3.0
#==========================================================================
csw3 <- NULL

#CSW 3.0 – GetCapabilities
#--------------------------------------------------------------------------
#--> pycsw
test_that("CSW 3.0 - GetCapabilities | pycsw",{
  csw3 <<- CSWClient$new("http://localhost:8000/csw", "3.0", logger="DEBUG")
  expect_is(csw3, "CSWClient")
  expect_equal(csw3$getVersion(), "3.0.0")
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
  insert <- csw3$insertRecord(record = md)
  expect_true(insert$getResult())
})

#Update (Full)
test_that("CSW 3.0 - Transaction - Update (Full)",{
  md$identificationInfo[[1]]$citation$setTitle("a new title")
  update <- csw3$updateRecord(record = md)
  expect_true(update$getResult())
})

#Update (Partial) - DOES NOT WORK, REQUIRES FES 2.0 implementation
#test_that("CSW 3.0 - Transaction - Update (Partial)",{
#  recordProperty <- CSWRecordProperty$new("apiso:Title", "NEW_TITLE")
#  filter = OGCFilter$new(PropertyIsEqualTo$new("apiso:Identifier", md$fileIdentifier))
#  constraint <- CSWConstraint$new(filter = filter)
#  update <- csw3$updateRecord(recordProperty = recordProperty, constraint = constraint)
#  expect_true(update$getResult())
#})

#Delete - DOES NOT WORK, REQUIRES FES 2.0 implementation
#test_that("CSW 3.0 - Transaction - Delete",{
#  delete <- csw3$deleteRecordById(md$fileIdentifier)
#  expect_true(delete$getResult())
#})

#CSW 3.0 – GetRecordById
#--------------------------------------------------------------------------
test_that("CSW 3.0 - GetRecordById",{
  record <- csw3$getRecordById(id = "urn:uuid:19887a8a-f6b0-4a63-ae56-7fba0e17801f")
  expect_is(record, "list")
})

#CSW 3.0 – GetRecords / csw30:Record (Dublin Core)
#--------------------------------------------------------------------------
test_that("CSW 3.0 - GetRecords - full",{
  #as Dublin core records (R lists)
  records <- csw3$getRecords(query = CSWQuery$new())
  expect_equal(length(records), 12L)
  #ignoring query param (default is CSWQuery$new())
  records <- csw3$getRecords()
  expect_equal(length(records), 12L)
})

test_that("CSW 3.0 - GetRecords - full / maxRecords",{
  #as Dublin core records (R lists)
  records <- csw3$getRecords(query = CSWQuery$new(), maxRecords = 10L)
  expect_equal(length(records), 12L)
})