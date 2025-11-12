# WCSCoverageSpatialDomain

WCSCoverageSpatialDomain

WCSCoverageSpatialDomain

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html)
modelling a WCS coverage spatial domain

## Note

Class used internally by ows4R.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `WCSCoverageSpatialDomain`

## Public fields

- `envelopes`:

  envelopes. For WCS 1.0

- `BoundingBox`:

  bounding box. For WCS 1.1

- `grids`:

  For WCS 1.0

- `GridCRS`:

  grid CRS. For WCS 1.1

## Methods

### Public methods

- [`WCSCoverageSpatialDomain$new()`](#method-WCSCoverageSpatialDomain-new)

- [`WCSCoverageSpatialDomain$getEnvelopes()`](#method-WCSCoverageSpatialDomain-getEnvelopes)

- [`WCSCoverageSpatialDomain$getBoundingBox()`](#method-WCSCoverageSpatialDomain-getBoundingBox)

- [`WCSCoverageSpatialDomain$getGrids()`](#method-WCSCoverageSpatialDomain-getGrids)

- [`WCSCoverageSpatialDomain$getGridCRS()`](#method-WCSCoverageSpatialDomain-getGridCRS)

- [`WCSCoverageSpatialDomain$clone()`](#method-WCSCoverageSpatialDomain-clone)

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

Initializes an object of class
[WCSCoverageDomain](https://eblondel.github.io/ows4R/reference/WCSCoverageDomain.md)

#### Usage

    WCSCoverageSpatialDomain$new(xmlObj, serviceVersion, owsVersion, logger = NULL)

#### Arguments

- `xmlObj`:

  an object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  to initialize from XML

- `serviceVersion`:

  service version

- `owsVersion`:

  OWS version

- `logger`:

  logger

------------------------------------------------------------------------

### Method `getEnvelopes()`

Get envelopes. Method that applies to WCS 1.0 only

#### Usage

    WCSCoverageSpatialDomain$getEnvelopes()

#### Returns

a list of objects of class
[GMLEnvelope](https://rdrr.io/pkg/geometa/man/GMLEnvelope.html) or
[GMLEnvelopeWithTimePeriod](https://rdrr.io/pkg/geometa/man/GMLEnvelopeWithTimePeriod.html)

------------------------------------------------------------------------

### Method `getBoundingBox()`

Get bounding boxes. Method that applies to WCS 1.1 only

#### Usage

    WCSCoverageSpatialDomain$getBoundingBox()

#### Returns

a list of objects of class
[OWSBoundingBox](https://eblondel.github.io/ows4R/reference/OWSBoundingBox.md)

------------------------------------------------------------------------

### Method `getGrids()`

Get grids. Method that applies to WCS 1.0 only

#### Usage

    WCSCoverageSpatialDomain$getGrids()

#### Returns

a list of of objects of class
[GMLGrid](https://rdrr.io/pkg/geometa/man/GMLGrid.html) or
[GMLRectifiedGrid](https://rdrr.io/pkg/geometa/man/GMLRectifiedGrid.html)

------------------------------------------------------------------------

### Method `getGridCRS()`

Get Grid CRS. Method that applies to WCS 1.1 only

#### Usage

    WCSCoverageSpatialDomain$getGridCRS()

#### Returns

a list of objects of class
[WCSGridCRS](https://eblondel.github.io/ows4R/reference/WCSGridCRS.md)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WCSCoverageSpatialDomain$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
