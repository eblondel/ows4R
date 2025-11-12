# CSWClient

CSWClient

CSWClient

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for interfacing an OGC Catalogue Service for the Web.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\>
[`ows4R::OWSClient`](https://eblondel.github.io/ows4R/reference/OWSClient.md)
-\> `CSWClient`

## Methods

### Public methods

- [`CSWClient$new()`](#method-CSWClient-new)

- [`CSWClient$getCapabilities()`](#method-CSWClient-getCapabilities)

- [`CSWClient$reloadCapabilities()`](#method-CSWClient-reloadCapabilities)

- [`CSWClient$describeRecord()`](#method-CSWClient-describeRecord)

- [`CSWClient$getRecordById()`](#method-CSWClient-getRecordById)

- [`CSWClient$getRecords()`](#method-CSWClient-getRecords)

- [`CSWClient$transaction()`](#method-CSWClient-transaction)

- [`CSWClient$insertRecord()`](#method-CSWClient-insertRecord)

- [`CSWClient$updateRecord()`](#method-CSWClient-updateRecord)

- [`CSWClient$deleteRecord()`](#method-CSWClient-deleteRecord)

- [`CSWClient$deleteRecordById()`](#method-CSWClient-deleteRecordById)

- [`CSWClient$harvestRecord()`](#method-CSWClient-harvestRecord)

- [`CSWClient$harvestNode()`](#method-CSWClient-harvestNode)

- [`CSWClient$clone()`](#method-CSWClient-clone)

Inherited methods

- [`ows4R::OGCAbstractObject$ERROR()`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.html#method-ERROR)
- [`ows4R::OGCAbstractObject$INFO()`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.html#method-INFO)
- [`ows4R::OGCAbstractObject$WARN()`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.html#method-WARN)
- [`ows4R::OGCAbstractObject$encode()`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.html#method-encode)
- [`ows4R::OGCAbstractObject$getClass()`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.html#method-getClass)
- [`ows4R::OGCAbstractObject$getClassName()`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.html#method-getClassName)
- [`ows4R::OGCAbstractObject$getNamespaceDefinition()`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.html#method-getNamespaceDefinition)
- [`ows4R::OGCAbstractObject$isFieldInheritedFrom()`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.html#method-isFieldInheritedFrom)
- [`ows4R::OGCAbstractObject$logger()`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.html#method-logger)
- [`ows4R::OGCAbstractObject$print()`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.html#method-print)
- [`ows4R::OWSClient$getCASUrl()`](https://eblondel.github.io/ows4R/reference/OWSClient.html#method-getCASUrl)
- [`ows4R::OWSClient$getConfig()`](https://eblondel.github.io/ows4R/reference/OWSClient.html#method-getConfig)
- [`ows4R::OWSClient$getHeaders()`](https://eblondel.github.io/ows4R/reference/OWSClient.html#method-getHeaders)
- [`ows4R::OWSClient$getPwd()`](https://eblondel.github.io/ows4R/reference/OWSClient.html#method-getPwd)
- [`ows4R::OWSClient$getToken()`](https://eblondel.github.io/ows4R/reference/OWSClient.html#method-getToken)
- [`ows4R::OWSClient$getUrl()`](https://eblondel.github.io/ows4R/reference/OWSClient.html#method-getUrl)
- [`ows4R::OWSClient$getUser()`](https://eblondel.github.io/ows4R/reference/OWSClient.html#method-getUser)
- [`ows4R::OWSClient$getVersion()`](https://eblondel.github.io/ows4R/reference/OWSClient.html#method-getVersion)

------------------------------------------------------------------------

### Method `new()`

This method is used to instantiate a CSWClient with the `url` of the OGC
service. Authentication is supported using basic auth (using
`user`/`pwd` arguments), bearer token (using `token` argument), or
custom (using `headers` argument). By default, the `logger` argument
will be set to `NULL` (no logger). This argument accepts two possible
values: `INFO`: to print only ows4R logs, `DEBUG`: to print more verbose
logs

#### Usage

    CSWClient$new(
      url,
      serviceVersion = NULL,
      user = NULL,
      pwd = NULL,
      token = NULL,
      headers = c(),
      config = httr::config(),
      cas_url = NULL,
      logger = NULL
    )

#### Arguments

- `url`:

  url

- `serviceVersion`:

  CSW service version

- `user`:

  user

- `pwd`:

  password

- `token`:

  token

- `headers`:

  headers

- `config`:

  config

- `cas_url`:

  Central Authentication Service (CAS) URL

- `logger`:

  logger

------------------------------------------------------------------------

### Method `getCapabilities()`

Get CSW capabilities

#### Usage

    CSWClient$getCapabilities()

#### Returns

an object of class
[CSWCapabilities](https://eblondel.github.io/ows4R/reference/CSWCapabilities.md)

------------------------------------------------------------------------

### Method `reloadCapabilities()`

Reloads CSW capabilities

#### Usage

    CSWClient$reloadCapabilities()

------------------------------------------------------------------------

### Method `describeRecord()`

Describe records. Retrieves the XML schema for CSW records. By default,
returns the XML schema for the CSW records
(http://www.opengis.net/cat/csw/2.0.2). For other schemas, specify the
`outputSchema` required, e.g. http://www.isotc211.org/2005/gmd for ISO
19115/19139 schema

#### Usage

    CSWClient$describeRecord(namespace, ...)

#### Arguments

- `namespace`:

  namespace

- `...`:

  any other parameter to pass to the
  [CSWDescribeRecord](https://eblondel.github.io/ows4R/reference/CSWDescribeRecord.md)
  service request

#### Returns

the service record description

------------------------------------------------------------------------

### Method `getRecordById()`

Get a record by Id. By default, the record will be returned following
the CSW schema (http://www.opengis.net/cat/csw/2.0.2). For other
schemas, specify the `outputSchema` required, e.g.
http://www.isotc211.org/2005/gmd for ISO 19115/19139 records. The
parameter `elementSetName` should among values "full", "brief",
"summary". The default "full" corresponds to the full metadata sheet
returned. "brief" and "summary" will contain only a subset of the
metadata content.

#### Usage

    CSWClient$getRecordById(id, elementSetName = "full", ...)

#### Arguments

- `id`:

  record id

- `elementSetName`:

  element set name. Default is "full"

- `...`:

  any other parameter to pass to
  [CSWGetRecordById](https://eblondel.github.io/ows4R/reference/CSWGetRecordById.md)
  service request

#### Returns

the fetched record, `NULL` otherwise

------------------------------------------------------------------------

### Method `getRecords()`

Get records based on a query, object of class `CSWQuery`. The maximum
number of records can be set either for the full query (`maxRecords`) or
per request (`maxRecordsPerRequest`, default set to 10 records)
considering this operation is paginated. By default, the record will be
returned following the CSW schema
(http://www.opengis.net/cat/csw/2.0.2). For other schemas, specify the
`outputSchema` required, e.g. http://www.isotc211.org/2005/gmd for ISO
19115/19139 records.

#### Usage

    CSWClient$getRecords(
      query = CSWQuery$new(),
      maxRecords = NULL,
      maxRecordsPerRequest = 10L,
      ...
    )

#### Arguments

- `query`:

  an object of class
  [CSWQuery](https://eblondel.github.io/ows4R/reference/CSWQuery.md). By
  default, an empty query is set.

- `maxRecords`:

  max number of total records. Default is `NULL` meaning all records are
  returned.

- `maxRecordsPerRequest`:

  max number of records to return per request. Default set to 10.

- `...`:

  any other parameter to be passed to
  [CSWGetRecords](https://eblondel.github.io/ows4R/reference/CSWGetRecords.md)
  service request

#### Returns

the list of records. By default each record will be returned as Dublin
Core `list` object. In case ISO 19115/19139 is set as `outputSchema`,
each record will be object of class `ISOMetadata` from geometa.

------------------------------------------------------------------------

### Method `transaction()`

Generic transaction method. Used for inserting, updating or deleting
metadata using the transactional CSW service. The `type` gives the type
of transaction (Insert, Update, or Delete). The record

#### Usage

    CSWClient$transaction(
      type,
      record = NULL,
      recordProperty = NULL,
      constraint = NULL,
      ...
    )

#### Arguments

- `type`:

  of transaction either "Insert", "Update" or "Delete"

- `record`:

  the record subject of the transaction

- `recordProperty`:

  record property, object of class
  [CSWRecordProperty](https://eblondel.github.io/ows4R/reference/CSWRecordProperty.md)

- `constraint`:

  constraint, object of class
  [CSWConstraint](https://eblondel.github.io/ows4R/reference/CSWConstraint.md)

- `...`:

  any other parameter to pass to
  [CSWTransaction](https://eblondel.github.io/ows4R/reference/CSWTransaction.md)
  service request

#### Returns

`TRUE` if transaction succeeded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `insertRecord()`

Inserts a new record

#### Usage

    CSWClient$insertRecord(record, ...)

#### Arguments

- `record`:

  record subject of the Insertion

- `...`:

  any other parameter to pass to the transaction

#### Returns

`TRUE` if insertion succeeded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `updateRecord()`

Updates an existing record

#### Usage

    CSWClient$updateRecord(
      record = NULL,
      recordProperty = NULL,
      constraint = NULL,
      ...
    )

#### Arguments

- `record`:

  record subject of the Insertion

- `recordProperty`:

  record property, object of class
  [CSWRecordProperty](https://eblondel.github.io/ows4R/reference/CSWRecordProperty.md)

- `constraint`:

  constraint, object of class
  [CSWConstraint](https://eblondel.github.io/ows4R/reference/CSWConstraint.md)

- `...`:

  any other parameter to pass to the transaction

#### Returns

`TRUE` if update succeeded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `deleteRecord()`

Deletes an existing (set of) record(s). A constraint (object of class
`CSWConstraint`) can be specified to limit the deletion to some records.

#### Usage

    CSWClient$deleteRecord(record = NULL, constraint = NULL, ...)

#### Arguments

- `record`:

  record subject of the Insertion

- `constraint`:

  constraint, object of class
  [CSWConstraint](https://eblondel.github.io/ows4R/reference/CSWConstraint.md)

- `...`:

  any other parameter to pass to the transaction

#### Returns

`TRUE` if deletion succeeded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `deleteRecordById()`

Deletes an existing record by identifier (constraint used to identify
the record based on its identifier).

#### Usage

    CSWClient$deleteRecordById(id)

#### Arguments

- `id`:

  record id

#### Returns

`TRUE` if deletion succeeded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `harvestRecord()`

Harvests a single record from a `sourceUrl`, given a `resourceType` (by
default "http://www.isotc211.org/2005/gmd").

#### Usage

    CSWClient$harvestRecord(
      sourceUrl,
      resourceType = "http://www.isotc211.org/2005/gmd"
    )

#### Arguments

- `sourceUrl`:

  source URL

- `resourceType`:

  resource type. Default is "http://www.isotc211.org/2005/gmd"

#### Returns

`TRUE` if harvesting succeeded, `FALSE` otherwise

------------------------------------------------------------------------

### Method `harvestNode()`

Harvests a CSW node (having its endpoint defined by an `url`). A `query`
(object of class `CSWQuery`) can be specificed if needed to restrain the
harvesting to a subset. The `resourceType` defines the type of resources
to be harvested (by default "http://www.isotc211.org/2005/gmd")

#### Usage

    CSWClient$harvestNode(
      url,
      query = CSWQuery$new(),
      resourceType = "http://www.isotc211.org/2005/gmd",
      sourceBaseUrl
    )

#### Arguments

- `url`:

  CSW node URL

- `query`:

  a CSW query, object of class
  [CSWQuery](https://eblondel.github.io/ows4R/reference/CSWQuery.md)

- `resourceType`:

  resource type. Default is "http://www.isotc211.org/2005/gmd"

- `sourceBaseUrl`:

  source base URL

#### Returns

an object of class `list` giving the number of records `found` and those
actually `harvested`

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    CSWClient$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# \dontrun{
   #example based on CSW endpoint responding at http://localhost:8000/csw
   csw <- CSWClient$new("http://localhost:8000/csw", serviceVersion = "2.0.2")
#> Error in curl::curl_fetch_memory(url, handle = handle): Couldn't connect to server [localhost]:
#> Failed to connect to localhost port 8000 after 0 ms: Couldn't connect to server
   
   #get capabilities
   caps <- csw$getCapabilities()
#> Error: object 'csw' not found
   
   #get records
   records <- csw$getRecords()
#> Error: object 'csw' not found
   
   #get record by id
   record <- csw$getRecordById("my-metadata-id")
#> Error: object 'csw' not found
   
   #Advanced examples at https://github.com/eblondel/ows4R/wiki#csw
 # }
```
