# WPSClient

WPSClient

WPSClient

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for interfacing an OGC Web Processing Service.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\>
[`ows4R::OWSClient`](https://eblondel.github.io/ows4R/reference/OWSClient.md)
-\> `WPSClient`

## Methods

### Public methods

- [`WPSClient$new()`](#method-WPSClient-new)

- [`WPSClient$getCapabilities()`](#method-WPSClient-getCapabilities)

- [`WPSClient$reloadCapabilities()`](#method-WPSClient-reloadCapabilities)

- [`WPSClient$getProcesses()`](#method-WPSClient-getProcesses)

- [`WPSClient$describeProcess()`](#method-WPSClient-describeProcess)

- [`WPSClient$execute()`](#method-WPSClient-execute)

- [`WPSClient$clone()`](#method-WPSClient-clone)

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

This method is used to instantiate a WPSClient with the `url` of the OGC
service. Authentication is supported using basic auth (using
`user`/`pwd` arguments), bearer token (using `token` argument), or
custom (using `headers` argument). By default, the `logger` argument
will be set to `NULL` (no logger). This argument accepts two possible
values: `INFO`: to print only ows4R logs, `DEBUG`: to print more verbose
logs

#### Usage

    WPSClient$new(
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

  WFS service version

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

Get WPS capabilities

#### Usage

    WPSClient$getCapabilities()

#### Returns

an object of class
[WPSCapabilities](https://eblondel.github.io/ows4R/reference/WPSCapabilities.md)

------------------------------------------------------------------------

### Method `reloadCapabilities()`

Reloads WPS capabilities

#### Usage

    WPSClient$reloadCapabilities()

------------------------------------------------------------------------

### Method `getProcesses()`

Get the list of processes offered by the service capabilities. `pretty`
allows to control the type output. If `TRUE`, a `data.frame` will be
returned. When prettified output, it is also possible to get a 'full'
description of the process by setting `full = TRUE` in which case a the
WPS client will request a process description (with more information
about the process) for each process listed in the capabilities.

#### Usage

    WPSClient$getProcesses(pretty = FALSE, full = FALSE)

#### Arguments

- `pretty`:

  pretty

- `full`:

  full

#### Returns

a `list` of
[WPSProcessDescription](https://eblondel.github.io/ows4R/reference/WPSProcessDescription.md)
or a `data.frame`

------------------------------------------------------------------------

### Method `describeProcess()`

Get the description of a process, given its `identifier`, returning an
object of class `WPSProcessDescription`

#### Usage

    WPSClient$describeProcess(identifier)

#### Arguments

- `identifier`:

  process identifier

#### Returns

an object of class
[WPSProcessDescription](https://eblondel.github.io/ows4R/reference/WPSProcessDescription.md)

------------------------------------------------------------------------

### Method `execute()`

Execute a process, given its `identifier`

#### Usage

    WPSClient$execute(
      identifier,
      dataInputs = list(),
      responseForm = NULL,
      storeExecuteResponse = FALSE,
      lineage = NULL,
      status = NULL,
      update = FALSE,
      updateInterval = 1
    )

#### Arguments

- `identifier`:

  process identifier

- `dataInputs`:

  a named list of data inputs, objects of class
  [WPSLiteralData](https://eblondel.github.io/ows4R/reference/WPSLiteralData.md),
  [WPSComplexData](https://eblondel.github.io/ows4R/reference/WPSComplexData.md)
  or
  [WPSBoundingBoxData](https://eblondel.github.io/ows4R/reference/WPSBoundingBoxData.md)

- `responseForm`:

  response form, object of class
  [WPSResponseDocument](https://eblondel.github.io/ows4R/reference/WPSResponseDocument.md)

- `storeExecuteResponse`:

  store execute response? object of class `logical`. `FALSE` by default

- `lineage`:

  lineage, object of class `logical`

- `status`:

  status, object of class `logical`

- `update`:

  update, object of class `logical`. For asynchronous requests

- `updateInterval`:

  update interval, object of class `integer`. For asynchronous requests

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WPSClient$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# \dontrun{
   #example based on a WPS endpoint responding at http://localhost:8080/geoserver/wps
   wps <- WPSClient$new("http://localhost:8080/geoserver/wps", serviceVersion = "1.0.0")
#> Error in curl::curl_fetch_memory(url, handle = handle): Couldn't connect to server [localhost]:
#> Failed to connect to localhost port 8080 after 0 ms: Couldn't connect to server
   
   #get capabilities
   caps <- wps$getCapabilities()
#> Error: object 'wps' not found
# }
```
