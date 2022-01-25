# test_CSWClient_v2.0.2.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Integration tests for CSW Client version 2.0.2
#=======================
require(ows4R, quietly = TRUE)
require(geometa)
require(testthat)
context("CSWClient")

#data
mdfile <- system.file("extdata/data", "metadata.xml", package = "ows4R")
md <- geometa::ISOMetadata$new(xml = XML::xmlParse(mdfile))

#CSW 2.0.2 - pycsw
#==========================================================================
csw2 <- NULL

#CSW 2.0.2 – GetCapabilities
#--------------------------------------------------------------------------
#--> pycsw
test_that("CSW 2.0.2 - GetCapabilities | pycsw",{
  csw2 <<- CSWClient$new("http://localhost:8000/csw", "2.0.2", logger="DEBUG")
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
  #csw3 tests seem to be triggered first, and deleteRecordById not yet supported for CSW3
  #we first check if the record exist (if inserted through csw3), and delete it in case
  record <- csw2$getRecordById(id = md$fileIdentifier)
  if(!is.null(record)) csw2$deleteRecordById(md$fileIdentifier)
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
  constraint <- CSWConstraint$new(filter = filter)
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
  #insert a list of 10 records for next tests
  for(i in 1:25){
    md$fileIdentifier <- paste0("my-metadata-identifier",i)
    md$identificationInfo[[1]]$citation$title <- paste0("sometitle", i)
    md$identificationInfo[[1]]$abstract <- ifelse(i==10,"lastabstract",paste0("abstract", i))
    csw2$insertRecord(record = md)
  }
  
  md <- csw2$getRecordById("my-metadata-identifier1", outputSchema = "http://www.isotc211.org/2005/gmd")
  expect_is(md, "ISOMetadata")
})

#CSW 2.0.2 – GetRecords / csw:Record (Dublin Core)
#--------------------------------------------------------------------------
test_that("CSW 2.0.2 - GetRecords - full",{
  #as Dublin core records (R lists)
  records <- csw2$getRecords(query = CSWQuery$new())
  expect_equal(length(records), 25L)
  #ignoring query param (default is CSWQuery$new())
  records <- csw2$getRecords()
  expect_equal(length(records), 25L)
})

test_that("CSW 2.0.2 - GetRecords - full / maxRecords",{
  #as Dublin core records (R lists)
  records <- csw2$getRecords(query = CSWQuery$new(), maxRecords = 10L)
  expect_equal(length(records), 10L)
})

test_that("CSW 2.0.2 - GetRecords - cqlText / dc:title",{
  cons <- CSWConstraint$new(cqlText = "dc:title like '%title1%'")
  query <- CSWQuery$new(constraint = cons)
  records <- csw2$getRecords(query = query)
  expect_equal(length(records), 11L)
})

test_that("CSW 2.0.2 - GetRecords - cqlText / dc:title and dc:abstract",{
  cons <- CSWConstraint$new(cqlText = "dc:title like '%title1%' and dct:abstract like '%last%'")
  query <- CSWQuery$new(constraint = cons)
  records <- csw2$getRecords(query = query)
  expect_equal(length(records), 1L)
})

test_that("CSW 2.0.2 - GetRecords - cqlText / dc:identifier",{
  cons <- CSWConstraint$new(cqlText = "dc:identifier = 'my-metadata-identifier1'")
  query <- CSWQuery$new(constraint = cons)
  records <- csw2$getRecords(query = query)
  expect_equal(length(records), 1L)
})

test_that("CSW 2.0.2 - GetRecords - Filter / AnyText",{
  filter <- OGCFilter$new( PropertyIsLike$new("csw:AnyText", "%lasta%"))
  cons <- CSWConstraint$new(filter = filter)
  query <- CSWQuery$new(constraint = cons)
  records <- csw2$getRecords(query = query)
  expect_equal(length(records), 1L)
})

test_that("CSW 2.0.2 - GetRecords - Filter / AnyText Equal",{
  filter <- OGCFilter$new( PropertyIsEqualTo$new("csw:AnyText", "lastabstract"))
  cons <- CSWConstraint$new(filter = filter)
  query <- CSWQuery$new(constraint = cons)
  records <- csw2$getRecords(query = query)
  expect_equal(length(records), 1L)
})

test_that("CSW 2.0.2 - GetRecords - Filter / AnyText And Not",{
  filter <- OGCFilter$new(And$new(
    PropertyIsLike$new("csw:AnyText", "%some%"),
    Not$new(
      PropertyIsLike$new("csw:AnyText", "%title1%")
    )
  ))
  cons <- CSWConstraint$new(filter = filter)
  query <- CSWQuery$new(constraint = cons)
  records <- csw2$getRecords(query = query)
  expect_equal(length(records), 14L)
})

test_that("CSW 2.0.2 - GetRecords - Filter / BBOX",{
  bbox <- matrix(c(-180,180,-90,90), nrow = 2, ncol = 2, byrow = TRUE,
                 dimnames = list(c("x", "y"), c("min","max")))
  filter <- OGCFilter$new( BBOX$new(bbox = bbox) )
  cons <- CSWConstraint$new(filter = filter)
  query <- CSWQuery$new(elementSetName = "brief", constraint = cons)
  records <- csw2$getRecords(query = query)
  expect_equal(length(records), 25L)
})

#CSW 2.0.2 – GetRecords / gmd:MD_Metadata (ISO 19115/19319 - R geometa binding)
#--------------------------------------------------------------------------
test_that("CSW 2.0.2 - GetRecords - cqlText / dc:identifier",{
  cons <- CSWConstraint$new(cqlText = "dc:identifier = 'my-metadata-identifier1'")
  query <- CSWQuery$new(constraint = cons)
  records <- csw2$getRecords(query = query, outputSchema = "http://www.isotc211.org/2005/gmd")
  expect_equal(length(records), 1L)
  expect_is(records[[1]], "ISOMetadata")
})

#CSW 2.0.2 – Delete - In Batch - based on constraint
#--------------------------------------------------------------------------
test_that("CSW 2.0.2 - Delete - in Batch",{
  #end of pycsw tests on CSW 2.0.2 we delete everything for other test suites
  cons <- CSWConstraint$new(cqlText = "dc:identifier like '%my-metadata-identifier%'")
  deleted <- csw2$deleteRecord(constraint = cons)
  expect_true(deleted$getResult())
})

#CSW 2.0.2 – Harvest
#--------------------------------------------------------------------------
#on pycsw: see issue https://github.com/geopython/pycsw/issues/561
#on geonetwork: see thread http://osgeo-org.1560.x6.nabble.com/No-bean-named-CswService-Harvest-is-defined-td5312221.html apparently not implemented (!)
test_that("CSW 2.0.2 - Harvest",{
  cons <- CSWConstraint$new(cqlText = "dc:identifier like '%firms-%'")
  query <- CSWQuery$new(constraint = cons)
  harvested <- csw2$harvestNode(
    url = "https://www.fao.org/fishery/geonetwork/srv/en/csw", query = query,
    sourceBaseUrl = "https://www.fao.org/fishery/geonetwork/srv/en/xml.metadata.get?uuid="
  )
  expect_is(harvested, "list")
  expect_equal(harvested$found, 2)
  expect_equal(harvested$harvested, 2)
  
  #remove records for next tests
  csw2$deleteRecordById("firms-mv-map-fishery")
  csw2$deleteRecordById("firms-mv-map-resource")
  csw2$deleteRecordById("my-metadata-identifier")
  for(i in 1:10){
    id <- paste0("my-metadata-identifier",i)
    csw2$deleteRecordById(id)
  }
})

#CSW 2.0.2 - FAO Geonetwork
#==========================================================================
fao_csw <- NULL

#CSW 2.0.2 – FAO - GetRecords / gmd:MD_Metadata (ISO 19115/19319 - R geometa binding)
#--------------------------------------------------------------------------
test_that("CSW 2.0.2 - GetRecords - cqlText / dc:identifier",{
  fao_csw <<- CSWClient$new("https://www.fao.org/fishery/geonetwork/srv/en/csw", "2.0.2", logger="INFO")
  expect_is(fao_csw, "CSWClient")
  expect_equal(fao_csw$getVersion(), "2.0.2")
  caps <- fao_csw$getCapabilities()
  expect_is(caps, "CSWCapabilities")
})

#CSW 2.0.2 – FAO - GetRecords / gmd:MD_Metadata (ISO 19115/19319 - R geometa binding)
#--------------------------------------------------------------------------
test_that("CSW 2.0.2 - GetRecords - cqlText / dc:identifier",{
  cons <- CSWConstraint$new(cqlText = "dc:identifier like '%firms-%'")
  query <- CSWQuery$new(constraint = cons)
  records <- fao_csw$getRecords(query = query, outputSchema = "http://www.isotc211.org/2005/gmd")
  expect_equal(length(records), 2L)
  expect_true(unique(sapply(records, is, "ISOMetadata")))
})

