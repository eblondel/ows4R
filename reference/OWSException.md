# OWSException

OWSException

OWSException

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html)
modelling a OWS Service exception

## Note

Abstract class used by ows4R

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `OWSException`

## Public fields

- `ExceptionText`:

  exception text

## Methods

### Public methods

- [`OWSException$new()`](#method-OWSException-new)

- [`OWSException$getLocator()`](#method-OWSException-getLocator)

- [`OWSException$getCode()`](#method-OWSException-getCode)

- [`OWSException$getText()`](#method-OWSException-getText)

- [`OWSException$clone()`](#method-OWSException-clone)

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

Initializes an object of class OWSException

#### Usage

    OWSException$new(xmlObj, logger = NULL)

#### Arguments

- `xmlObj`:

  object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

- `logger`:

  logger

------------------------------------------------------------------------

### Method `getLocator()`

Get exception locator

#### Usage

    OWSException$getLocator()

#### Returns

the exception locator, object of class `character`

------------------------------------------------------------------------

### Method `getCode()`

Get exception code

#### Usage

    OWSException$getCode()

#### Returns

the exception code, object of class `character`

------------------------------------------------------------------------

### Method `getText()`

Get exception text explanation

#### Usage

    OWSException$getText()

#### Returns

the exception text, object of class `character`

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    OWSException$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
