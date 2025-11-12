# WCSCoverageDomain

WCSCoverageDomain

WCSCoverageDomain

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html)
modelling a WCS coverage domain

## Note

Class used internally by ows4R.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `WCSCoverageDomain`

## Public fields

- `spatialDomain`:

  spatial domain

- `temporalDomain`:

  temporal domain

## Methods

### Public methods

- [`WCSCoverageDomain$new()`](#method-WCSCoverageDomain-new)

- [`WCSCoverageDomain$getSpatialDomain()`](#method-WCSCoverageDomain-getSpatialDomain)

- [`WCSCoverageDomain$getTemporalDomain()`](#method-WCSCoverageDomain-getTemporalDomain)

- [`WCSCoverageDomain$clone()`](#method-WCSCoverageDomain-clone)

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

Initializes an object of class WCSCoverageDomain

#### Usage

    WCSCoverageDomain$new(xmlObj, serviceVersion, owsVersion, logger = NULL)

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

### Method `getSpatialDomain()`

Get spatial domain

#### Usage

    WCSCoverageDomain$getSpatialDomain()

#### Returns

object of class
[WCSCoverageSpatialDomain](https://eblondel.github.io/ows4R/reference/WCSCoverageSpatialDomain.md)

------------------------------------------------------------------------

### Method `getTemporalDomain()`

Get spatial domain

#### Usage

    WCSCoverageDomain$getTemporalDomain()

#### Returns

object of class
[WCSCoverageTemporalDomain](https://eblondel.github.io/ows4R/reference/WCSCoverageTemporalDomain.md)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WCSCoverageDomain$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
