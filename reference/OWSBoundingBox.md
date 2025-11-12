# OWSBoundingBox

OWSBoundingBox

OWSBoundingBox

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling an OGC Bounding Box

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `OWSBoundingBox`

## Public fields

- `attrs`:

  attributes to be associated to XML

- `LowerCorner`:

  lower corner coordinates

- `UpperCorner`:

  upper corner coordinates

## Methods

### Public methods

- [`OWSBoundingBox$new()`](#method-OWSBoundingBox-new)

- [`OWSBoundingBox$decode()`](#method-OWSBoundingBox-decode)

- [`OWSBoundingBox$getBBOX()`](#method-OWSBoundingBox-getBBOX)

- [`OWSBoundingBox$clone()`](#method-OWSBoundingBox-clone)

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

Initializes an object of class OWSBoundingBox

#### Usage

    OWSBoundingBox$new(
      xml = NULL,
      element = NULL,
      namespacePrefix = NULL,
      owsVersion,
      serviceVersion,
      logger = NULL
    )

#### Arguments

- `xml`:

  an object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  to initialize from XML

- `element`:

  element name

- `namespacePrefix`:

  namespace prefix

- `owsVersion`:

  OWS version

- `serviceVersion`:

  service version

- `logger`:

  logger

------------------------------------------------------------------------

### Method `decode()`

Decodes an object of class OWSBoundingBox from XML

#### Usage

    OWSBoundingBox$decode(xml)

#### Arguments

- `xml`:

  object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

------------------------------------------------------------------------

### Method `getBBOX()`

Get BBOX as object of class `bbox` from sf package

#### Usage

    OWSBoundingBox$getBBOX()

#### Returns

a numeric vector of length four, with xmin, ymin, xmax and ymax values

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    OWSBoundingBox$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
