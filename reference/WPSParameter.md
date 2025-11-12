# WPSParameter

WPSParameter

WPSParameter

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html)
modelling a WPS parameter

## Note

Abstract class used internally by ows4R

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `WPSParameter`

## Methods

### Public methods

- [`WPSParameter$new()`](#method-WPSParameter-new)

- [`WPSParameter$getIdentifier()`](#method-WPSParameter-getIdentifier)

- [`WPSParameter$getTitle()`](#method-WPSParameter-getTitle)

- [`WPSParameter$getAbstract()`](#method-WPSParameter-getAbstract)

- [`WPSParameter$clone()`](#method-WPSParameter-clone)

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

Initializes an object of class WPSParameter

#### Usage

    WPSParameter$new(xml = NULL, version, logger = NULL, ...)

#### Arguments

- `xml`:

  an object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  to initialize from XML

- `version`:

  WPS service version

- `logger`:

  logger

- `...`:

  any additional parameter

------------------------------------------------------------------------

### Method `getIdentifier()`

Get identifier

#### Usage

    WPSParameter$getIdentifier()

#### Returns

object of class `character`

------------------------------------------------------------------------

### Method `getTitle()`

Get title

#### Usage

    WPSParameter$getTitle()

#### Returns

object of class `character`

------------------------------------------------------------------------

### Method `getAbstract()`

Get abstract

#### Usage

    WPSParameter$getAbstract()

#### Returns

object of class `character`

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WPSParameter$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
