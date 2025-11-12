# WPSBoundingBoxData

WPSBoundingBoxData

WPSBoundingBoxData

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling an OGC WPS BoundingBox data

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\>
[`ows4R::OWSBoundingBox`](https://eblondel.github.io/ows4R/reference/OWSBoundingBox.md)
-\> `WPSBoundingBoxData`

## Methods

### Public methods

- [`WPSBoundingBoxData$new()`](#method-WPSBoundingBoxData-new)

- [`WPSBoundingBoxData$clone()`](#method-WPSBoundingBoxData-clone)

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
- [`ows4R::OWSBoundingBox$decode()`](https://eblondel.github.io/ows4R/reference/OWSBoundingBox.html#method-decode)
- [`ows4R::OWSBoundingBox$getBBOX()`](https://eblondel.github.io/ows4R/reference/OWSBoundingBox.html#method-getBBOX)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class WPSBoundingBoxData

#### Usage

    WPSBoundingBoxData$new(
      xml = NULL,
      owsVersion,
      serviceVersion = "1.0.0",
      logger = NULL,
      ...
    )

#### Arguments

- `xml`:

  an object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  to initialize from XML

- `owsVersion`:

  OWS version

- `serviceVersion`:

  WPS service version

- `logger`:

  logger

- `...`:

  any other parameter

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WPSBoundingBoxData$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
