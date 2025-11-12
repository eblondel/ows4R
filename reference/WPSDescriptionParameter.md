# WPSDescriptionParameter

WPSDescriptionParameter

WPSDescriptionParameter

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html)
modelling a WPS process input description parameter

## Note

Class used internally by ows4R

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\>
[`ows4R::WPSParameter`](https://eblondel.github.io/ows4R/reference/WPSParameter.md)
-\> `WPSDescriptionParameter`

## Methods

### Public methods

- [`WPSDescriptionParameter$new()`](#method-WPSDescriptionParameter-new)

- [`WPSDescriptionParameter$getDataType()`](#method-WPSDescriptionParameter-getDataType)

- [`WPSDescriptionParameter$getFormats()`](#method-WPSDescriptionParameter-getFormats)

- [`WPSDescriptionParameter$clone()`](#method-WPSDescriptionParameter-clone)

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
- [`ows4R::WPSParameter$getAbstract()`](https://eblondel.github.io/ows4R/reference/WPSParameter.html#method-getAbstract)
- [`ows4R::WPSParameter$getIdentifier()`](https://eblondel.github.io/ows4R/reference/WPSParameter.html#method-getIdentifier)
- [`ows4R::WPSParameter$getTitle()`](https://eblondel.github.io/ows4R/reference/WPSParameter.html#method-getTitle)

------------------------------------------------------------------------

### Method `new()`

Initializes a WPSDescriptionParameter

#### Usage

    WPSDescriptionParameter$new(xml = NULL, version, logger = NULL, ...)

#### Arguments

- `xml`:

  object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

- `version`:

  WPS service version

- `logger`:

  logger

- `...`:

  any other parameter

------------------------------------------------------------------------

### Method `getDataType()`

Get data type

#### Usage

    WPSDescriptionParameter$getDataType()

#### Returns

object of class `character`

------------------------------------------------------------------------

### Method `getFormats()`

get formats

#### Usage

    WPSDescriptionParameter$getFormats()

#### Returns

the formats

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WPSDescriptionParameter$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
