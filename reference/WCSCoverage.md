# WCSCoverage

WCSCoverage

WCSCoverage

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html)
modelling a WCS coverage

## Note

Class used internally by ows4R.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `WCSCoverage`

## Public fields

- `description`:

  description

## Methods

### Public methods

- [`WCSCoverage$new()`](#method-WCSCoverage-new)

- [`WCSCoverage$getIdentifier()`](#method-WCSCoverage-getIdentifier)

- [`WCSCoverage$getTitle()`](#method-WCSCoverage-getTitle)

- [`WCSCoverage$getAbstract()`](#method-WCSCoverage-getAbstract)

- [`WCSCoverage$getReference()`](#method-WCSCoverage-getReference)

- [`WCSCoverage$getData()`](#method-WCSCoverage-getData)

- [`WCSCoverage$clone()`](#method-WCSCoverage-clone)

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

Initializes an object of class WCSCoverage

#### Usage

    WCSCoverage$new(xmlObj, serviceVersion, owsVersion, logger = NULL)

#### Arguments

- `xmlObj`:

  object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)

- `serviceVersion`:

  WCS service version

- `owsVersion`:

  OWS version

- `logger`:

  logger

------------------------------------------------------------------------

### Method `getIdentifier()`

Get identifier

#### Usage

    WCSCoverage$getIdentifier()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `getTitle()`

Get title

#### Usage

    WCSCoverage$getTitle()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `getAbstract()`

Get abstract

#### Usage

    WCSCoverage$getAbstract()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `getReference()`

Get reference

#### Usage

    WCSCoverage$getReference()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `getData()`

Get data

#### Usage

    WCSCoverage$getData(filename = NULL)

#### Arguments

- `filename`:

  filename. Optional file name where to download the coverage

#### Returns

an object of class `SpatRaster` from terra

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WCSCoverage$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
