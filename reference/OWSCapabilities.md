# OWSGetCapabilities

OWSGetCapabilities

OWSGetCapabilities

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for interfacing an abstract OWS Get Capabilities document.

## Note

abstract class used by ows4R

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `OWSCapabilities`

## Methods

### Public methods

- [`OWSCapabilities$new()`](#method-OWSCapabilities-new)

- [`OWSCapabilities$setClient()`](#method-OWSCapabilities-setClient)

- [`OWSCapabilities$getClient()`](#method-OWSCapabilities-getClient)

- [`OWSCapabilities$getUrl()`](#method-OWSCapabilities-getUrl)

- [`OWSCapabilities$getService()`](#method-OWSCapabilities-getService)

- [`OWSCapabilities$getServiceVersion()`](#method-OWSCapabilities-getServiceVersion)

- [`OWSCapabilities$getOWSVersion()`](#method-OWSCapabilities-getOWSVersion)

- [`OWSCapabilities$getRequest()`](#method-OWSCapabilities-getRequest)

- [`OWSCapabilities$getServiceIdentification()`](#method-OWSCapabilities-getServiceIdentification)

- [`OWSCapabilities$getServiceProvider()`](#method-OWSCapabilities-getServiceProvider)

- [`OWSCapabilities$getOperationsMetadata()`](#method-OWSCapabilities-getOperationsMetadata)

- [`OWSCapabilities$clone()`](#method-OWSCapabilities-clone)

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

------------------------------------------------------------------------

### Method `new()`

Initializes a OWSCapabilities object

#### Usage

    OWSCapabilities$new(
      element = NULL,
      namespacePrefix = NULL,
      url,
      service,
      owsVersion,
      serviceVersion,
      logger = NULL,
      ...
    )

#### Arguments

- `element`:

  element

- `namespacePrefix`:

  namespace prefix

- `url`:

  url

- `service`:

  service

- `owsVersion`:

  OWS version

- `serviceVersion`:

  service version

- `logger`:

  logger type `NULL`, "INFO" or "DEBUG"

- `...`:

  any other parameter to pass to
  [OWSGetCapabilities](https://eblondel.github.io/ows4R/reference/OWSGetCapabilities.md)
  service request

------------------------------------------------------------------------

### Method `setClient()`

Sets the OGC client

#### Usage

    OWSCapabilities$setClient(client)

#### Arguments

- `client`:

  an object extending
  [OWSClient](https://eblondel.github.io/ows4R/reference/OWSClient.md)

------------------------------------------------------------------------

### Method `getClient()`

Get client

#### Usage

    OWSCapabilities$getClient()

#### Arguments

- `an`:

  object extending
  [OWSClient](https://eblondel.github.io/ows4R/reference/OWSClient.md)

------------------------------------------------------------------------

### Method `getUrl()`

Get URL

#### Usage

    OWSCapabilities$getUrl()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `getService()`

Get service

#### Usage

    OWSCapabilities$getService()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `getServiceVersion()`

Get service version

#### Usage

    OWSCapabilities$getServiceVersion()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `getOWSVersion()`

Get OWS version

#### Usage

    OWSCapabilities$getOWSVersion()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `getRequest()`

Get request

#### Usage

    OWSCapabilities$getRequest()

#### Returns

an object of class
[OWSGetCapabilities](https://eblondel.github.io/ows4R/reference/OWSGetCapabilities.md)

------------------------------------------------------------------------

### Method `getServiceIdentification()`

Get service identification

#### Usage

    OWSCapabilities$getServiceIdentification()

#### Returns

an object of class
[OWSServiceIdentification](https://eblondel.github.io/ows4R/reference/OWSServiceIdentification.md)

------------------------------------------------------------------------

### Method `getServiceProvider()`

Get service provider

#### Usage

    OWSCapabilities$getServiceProvider()

#### Returns

an object of class
[OWSServiceProvider](https://eblondel.github.io/ows4R/reference/OWSServiceProvider.md)

------------------------------------------------------------------------

### Method `getOperationsMetadata()`

Get service operations metadata

#### Usage

    OWSCapabilities$getOperationsMetadata()

#### Returns

an object of class
[OWSOperationsMetadata](https://eblondel.github.io/ows4R/reference/OWSOperationsMetadata.md)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    OWSCapabilities$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
