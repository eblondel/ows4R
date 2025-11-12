# WPSProcessDescription

WPSProcessDescription

WPSProcessDescription

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html)
modelling a WPS process description

## Note

Class used internally by ows4R

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `WPSProcessDescription`

## Methods

### Public methods

- [`WPSProcessDescription$new()`](#method-WPSProcessDescription-new)

- [`WPSProcessDescription$getIdentifier()`](#method-WPSProcessDescription-getIdentifier)

- [`WPSProcessDescription$getTitle()`](#method-WPSProcessDescription-getTitle)

- [`WPSProcessDescription$getAbstract()`](#method-WPSProcessDescription-getAbstract)

- [`WPSProcessDescription$getVersion()`](#method-WPSProcessDescription-getVersion)

- [`WPSProcessDescription$isStatusSupported()`](#method-WPSProcessDescription-isStatusSupported)

- [`WPSProcessDescription$isStoreSupported()`](#method-WPSProcessDescription-isStoreSupported)

- [`WPSProcessDescription$getDataInputs()`](#method-WPSProcessDescription-getDataInputs)

- [`WPSProcessDescription$getProcessOutputs()`](#method-WPSProcessDescription-getProcessOutputs)

- [`WPSProcessDescription$asDataFrame()`](#method-WPSProcessDescription-asDataFrame)

- [`WPSProcessDescription$clone()`](#method-WPSProcessDescription-clone)

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

Initializes an object of class WPSProcessDescription

#### Usage

    WPSProcessDescription$new(xml, version, logger = NULL, ...)

#### Arguments

- `xml`:

  object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

- `version`:

  version

- `logger`:

  logger

- `...`:

  any other parameter

------------------------------------------------------------------------

### Method `getIdentifier()`

Get process identifier

#### Usage

    WPSProcessDescription$getIdentifier()

#### Returns

the identifier, object of class `character`

------------------------------------------------------------------------

### Method `getTitle()`

Get process title

#### Usage

    WPSProcessDescription$getTitle()

#### Returns

the title, object of class `character`

------------------------------------------------------------------------

### Method `getAbstract()`

Get process abstract

#### Usage

    WPSProcessDescription$getAbstract()

#### Returns

the abstract, object of class `character`

------------------------------------------------------------------------

### Method `getVersion()`

Get process version

#### Usage

    WPSProcessDescription$getVersion()

#### Arguments

- `the`:

  version, object of class `character`

------------------------------------------------------------------------

### Method `isStatusSupported()`

Indicates if the status is supported

#### Usage

    WPSProcessDescription$isStatusSupported()

#### Returns

`TRUE` if supported, `FALSE` otherwise

------------------------------------------------------------------------

### Method `isStoreSupported()`

Indicates if the store is supported

#### Usage

    WPSProcessDescription$isStoreSupported()

#### Returns

`TRUE` if supported, `FALSE` otherwise

------------------------------------------------------------------------

### Method `getDataInputs()`

Get data inputs

#### Usage

    WPSProcessDescription$getDataInputs()

#### Returns

a `list` of objects extending
[WPSInputDescription](https://eblondel.github.io/ows4R/reference/WPSInputDescription.md)

------------------------------------------------------------------------

### Method `getProcessOutputs()`

Get process outputs

#### Usage

    WPSProcessDescription$getProcessOutputs()

#### Returns

a `list` of objects extending
[WPSOutputDescription](https://eblondel.github.io/ows4R/reference/WPSOutputDescription.md)

------------------------------------------------------------------------

### Method `asDataFrame()`

Convenience method to export a process description as `data.frame`

#### Usage

    WPSProcessDescription$asDataFrame()

#### Returns

a `data.frame` giving the process description

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WPSProcessDescription$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
