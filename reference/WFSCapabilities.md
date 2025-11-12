# WFSCapabilities

WFSCapabilities

WFSCapabilities

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for interfacing an OGC Web Feature Service Get Capabilities
document.

## Note

Class used to read a `WFSCapabilities` document. The use of `WFSClient`
is recommended instead to benefit from the full set of capabilities
associated to a WFS server.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\>
[`ows4R::OWSCapabilities`](https://eblondel.github.io/ows4R/reference/OWSCapabilities.md)
-\> `WFSCapabilities`

## Methods

### Public methods

- [`WFSCapabilities$new()`](#method-WFSCapabilities-new)

- [`WFSCapabilities$getFeatureTypes()`](#method-WFSCapabilities-getFeatureTypes)

- [`WFSCapabilities$findFeatureTypeByName()`](#method-WFSCapabilities-findFeatureTypeByName)

- [`WFSCapabilities$clone()`](#method-WFSCapabilities-clone)

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

Initializes a WFSCapabilities object

#### Usage

    WFSCapabilities$new(url, version, logger = NULL, ...)

#### Arguments

- `url`:

  url

- `version`:

  version

- `logger`:

  logger type `NULL`, "INFO" or "DEBUG"

- `...`:

  any other parameter to pass to
  [OWSGetCapabilities](https://eblondel.github.io/ows4R/reference/OWSGetCapabilities.md)
  service request

------------------------------------------------------------------------

### Method `getFeatureTypes()`

List the feature types available. If `pretty` is TRUE, the output will
be an object of class `data.frame`

#### Usage

    WFSCapabilities$getFeatureTypes(pretty = FALSE)

#### Arguments

- `pretty`:

  whether the output should be summarized as `data.frame`

#### Returns

a `list` of
[WFSFeatureType](https://eblondel.github.io/ows4R/reference/WFSFeatureType.md)
or a `data.frame`

------------------------------------------------------------------------

### Method `findFeatureTypeByName()`

Finds a feature type by name

#### Usage

    WFSCapabilities$findFeatureTypeByName(expr, exact = TRUE)

#### Arguments

- `expr`:

  expr

- `exact`:

  exact matching? Default is `TRUE`

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WFSCapabilities$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
