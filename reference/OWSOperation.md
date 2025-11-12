# OWSOperation

OWSOperation

OWSOperation

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling an OGC Operation

## Note

Internal class used internally by ows4R when reading capabilities
documents

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Methods

### Public methods

- [`OWSOperation$new()`](#method-OWSOperation-new)

- [`OWSOperation$getName()`](#method-OWSOperation-getName)

- [`OWSOperation$getParameters()`](#method-OWSOperation-getParameters)

- [`OWSOperation$getParameter()`](#method-OWSOperation-getParameter)

- [`OWSOperation$clone()`](#method-OWSOperation-clone)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class OWSOperation.

#### Usage

    OWSOperation$new(xmlObj, owsVersion, serviceVersion)

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

### Method `getName()`

Get operation name

#### Usage

    OWSOperation$getName()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `getParameters()`

Get parameters

#### Usage

    OWSOperation$getParameters()

#### Returns

the parameters

------------------------------------------------------------------------

### Method `getParameter()`

Get parameter

#### Usage

    OWSOperation$getParameter(name)

#### Arguments

- `name`:

  name

#### Returns

the parameter

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    OWSOperation$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
