# WCSCoverageTemporalDomain

WCSCoverageTemporalDomain

WCSCoverageTemporalDomain

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html)
modelling a WCS coverage temporal domain

## Note

Class used internally by ows4R.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `WCSCoverageTemporalDomain`

## Public fields

- `instants`:

  instants

- `periods`:

  periods

## Methods

### Public methods

- [`WCSCoverageTemporalDomain$new()`](#method-WCSCoverageTemporalDomain-new)

- [`WCSCoverageTemporalDomain$getInstants()`](#method-WCSCoverageTemporalDomain-getInstants)

- [`WCSCoverageTemporalDomain$getPeriods()`](#method-WCSCoverageTemporalDomain-getPeriods)

- [`WCSCoverageTemporalDomain$clone()`](#method-WCSCoverageTemporalDomain-clone)

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

Initializes an object of class WCSCoverageTemporalDomain

#### Usage

    WCSCoverageTemporalDomain$new(
      xmlObj,
      serviceVersion,
      owsVersion,
      logger = NULL
    )

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

### Method `getInstants()`

Get time instants

#### Usage

    WCSCoverageTemporalDomain$getInstants()

#### Returns

a list of objects of class `POSIXct`

------------------------------------------------------------------------

### Method `getPeriods()`

Get time periods

#### Usage

    WCSCoverageTemporalDomain$getPeriods()

#### Returns

a list of objects of class
[GMLTimePeriod](https://rdrr.io/pkg/geometa/man/GMLTimePeriod.html)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WCSCoverageTemporalDomain$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
