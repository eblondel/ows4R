# WCSCapabilities

WCSCapabilities

WCSCapabilities

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for interfacing an OGC Web Coverage Service Get Capabilities
document.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\>
[`ows4R::OWSCapabilities`](https://eblondel.github.io/ows4R/reference/OWSCapabilities.md)
-\> `WCSCapabilities`

## Methods

### Public methods

- [`WCSCapabilities$new()`](#method-WCSCapabilities-new)

- [`WCSCapabilities$getCoverageSummaries()`](#method-WCSCapabilities-getCoverageSummaries)

- [`WCSCapabilities$findCoverageSummaryById()`](#method-WCSCapabilities-findCoverageSummaryById)

- [`WCSCapabilities$clone()`](#method-WCSCapabilities-clone)

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

Initializes a WCSCapabilities object

#### Usage

    WCSCapabilities$new(url, version, client = NULL, logger = NULL, ...)

#### Arguments

- `url`:

  url

- `version`:

  version

- `client`:

  an object of class
  [WCSClient](https://eblondel.github.io/ows4R/reference/WCSClient.md)

- `logger`:

  logger type `NULL`, "INFO" or "DEBUG"

- `...`:

  any other parameter to pass to
  [OWSGetCapabilities](https://eblondel.github.io/ows4R/reference/OWSGetCapabilities.md)
  service request

------------------------------------------------------------------------

### Method `getCoverageSummaries()`

Get coverage summaries

#### Usage

    WCSCapabilities$getCoverageSummaries()

#### Returns

a `list` of
[WCSCoverageSummary](https://eblondel.github.io/ows4R/reference/WCSCoverageSummary.md)
objects

------------------------------------------------------------------------

### Method `findCoverageSummaryById()`

Finds a coverage by name

#### Usage

    WCSCapabilities$findCoverageSummaryById(expr, exact = FALSE)

#### Arguments

- `expr`:

  expr

- `exact`:

  exact matching? Default is `TRUE`

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WCSCapabilities$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# \dontrun{
   WCSCapabilities$new("http://localhost:8080/geoserver/wcs", serviceVersion = "2.0.1")
#> Error in initialize(...): argument "version" is missing, with no default
# }
```
