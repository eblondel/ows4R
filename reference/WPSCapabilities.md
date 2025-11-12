# WPSCapabilities

WPSCapabilities

WPSCapabilities

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for interfacing an OGC Web Processing Service (WPS) Get
Capabilities document.

## Note

Class used to read a `WPSCapabilities` document. The use of `WPSClient`
is recommended instead to benefit from the full set of capabilities
associated to a WPS server.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\>
[`ows4R::OWSCapabilities`](https://eblondel.github.io/ows4R/reference/OWSCapabilities.md)
-\> `WPSCapabilities`

## Methods

### Public methods

- [`WPSCapabilities$new()`](#method-WPSCapabilities-new)

- [`WPSCapabilities$getProcesses()`](#method-WPSCapabilities-getProcesses)

- [`WPSCapabilities$describeProcess()`](#method-WPSCapabilities-describeProcess)

- [`WPSCapabilities$execute()`](#method-WPSCapabilities-execute)

- [`WPSCapabilities$clone()`](#method-WPSCapabilities-clone)

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
- [`ows4R::OWSCapabilities$getClient()`](https://eblondel.github.io/ows4R/reference/OWSCapabilities.html#method-getClient)
- [`ows4R::OWSCapabilities$getOWSVersion()`](https://eblondel.github.io/ows4R/reference/OWSCapabilities.html#method-getOWSVersion)
- [`ows4R::OWSCapabilities$getOperationsMetadata()`](https://eblondel.github.io/ows4R/reference/OWSCapabilities.html#method-getOperationsMetadata)
- [`ows4R::OWSCapabilities$getRequest()`](https://eblondel.github.io/ows4R/reference/OWSCapabilities.html#method-getRequest)
- [`ows4R::OWSCapabilities$getService()`](https://eblondel.github.io/ows4R/reference/OWSCapabilities.html#method-getService)
- [`ows4R::OWSCapabilities$getServiceIdentification()`](https://eblondel.github.io/ows4R/reference/OWSCapabilities.html#method-getServiceIdentification)
- [`ows4R::OWSCapabilities$getServiceProvider()`](https://eblondel.github.io/ows4R/reference/OWSCapabilities.html#method-getServiceProvider)
- [`ows4R::OWSCapabilities$getServiceVersion()`](https://eblondel.github.io/ows4R/reference/OWSCapabilities.html#method-getServiceVersion)
- [`ows4R::OWSCapabilities$getUrl()`](https://eblondel.github.io/ows4R/reference/OWSCapabilities.html#method-getUrl)
- [`ows4R::OWSCapabilities$setClient()`](https://eblondel.github.io/ows4R/reference/OWSCapabilities.html#method-setClient)

------------------------------------------------------------------------

### Method `new()`

Initializes a WPSCapabilities object

#### Usage

    WPSCapabilities$new(url, version, client = NULL, logger = NULL, ...)

#### Arguments

- `url`:

  url

- `version`:

  version

- `client`:

  an object of class
  [WPSClient](https://eblondel.github.io/ows4R/reference/WPSClient.md)

- `logger`:

  logger type `NULL`, "INFO" or "DEBUG"

- `...`:

  any other parameter to pass to
  [OWSGetCapabilities](https://eblondel.github.io/ows4R/reference/OWSGetCapabilities.md)
  service request

------------------------------------------------------------------------

### Method `getProcesses()`

Get the list of processes offered by the service capabilities. `pretty`
allows to control the type output. If `TRUE`, a `data.frame` will be
returned. When prettified output, it is also possible to get a 'full'
description of the process by setting `full = TRUE` in which case a the
WPS client will request a process description (with more information
about the process) for each process listed in the capabilities.

#### Usage

    WPSCapabilities$getProcesses(pretty = FALSE, full = FALSE)

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

    WPSCapabilities$describeProcess(identifier)

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

    WPSCapabilities$execute(
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

    WPSCapabilities$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
