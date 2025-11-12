# OWSOperationsMetadata

OWSOperationsMetadata

OWSOperationsMetadata

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling an OGC Operations Metadata

## Note

Abstract class used internally by ows4R

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Methods

### Public methods

- [`OWSOperationsMetadata$new()`](#method-OWSOperationsMetadata-new)

- [`OWSOperationsMetadata$getOperations()`](#method-OWSOperationsMetadata-getOperations)

- [`OWSOperationsMetadata$clone()`](#method-OWSOperationsMetadata-clone)

------------------------------------------------------------------------

### Method `new()`

Initializes an OWSOperationsMetadata object

#### Usage

    OWSOperationsMetadata$new(xmlObj, owsVersion, serviceVersion)

#### Arguments

- `xmlObj`:

  object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

- `owsVersion`:

  OWS version

- `serviceVersion`:

  service version

------------------------------------------------------------------------

### Method `getOperations()`

Get operations

#### Usage

    OWSOperationsMetadata$getOperations()

#### Returns

a list of
[OWSOperation](https://eblondel.github.io/ows4R/reference/OWSOperation.md)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    OWSOperationsMetadata$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
