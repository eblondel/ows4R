# WPSProcess

WPSProcess

WPSProcess

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html)
modelling a WPS process

## Note

Class used internally by ows4R

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `WPSProcess`

## Methods

### Public methods

- [`WPSProcess$new()`](#method-WPSProcess-new)

- [`WPSProcess$getIdentifier()`](#method-WPSProcess-getIdentifier)

- [`WPSProcess$getTitle()`](#method-WPSProcess-getTitle)

- [`WPSProcess$getVersion()`](#method-WPSProcess-getVersion)

- [`WPSProcess$getDescription()`](#method-WPSProcess-getDescription)

- [`WPSProcess$execute()`](#method-WPSProcess-execute)

- [`WPSProcess$clone()`](#method-WPSProcess-clone)

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

Initializes a WPSProcess

#### Usage

    WPSProcess$new(xml, capabilities = NULL, version, logger = NULL, ...)

#### Arguments

- `xml`:

  object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

- `capabilities`:

  object of class
  [WPSCapabilities](https://eblondel.github.io/ows4R/reference/WPSCapabilities.md)

- `version`:

  service version

- `logger`:

  logger

- `...`:

  any additional parameter

------------------------------------------------------------------------

### Method `getIdentifier()`

Get identifier

#### Usage

    WPSProcess$getIdentifier()

#### Returns

object of class `character`

------------------------------------------------------------------------

### Method `getTitle()`

Get title

#### Usage

    WPSProcess$getTitle()

#### Returns

object of class `character`

------------------------------------------------------------------------

### Method `getVersion()`

Get version

#### Usage

    WPSProcess$getVersion()

#### Returns

object of class `character`

------------------------------------------------------------------------

### Method `getDescription()`

Get description

#### Usage

    WPSProcess$getDescription()

#### Returns

object of class
[WPSProcessDescription](https://eblondel.github.io/ows4R/reference/WPSProcessDescription.md)

------------------------------------------------------------------------

### Method `execute()`

Execute process

#### Usage

    WPSProcess$execute(
      dataInputs = list(),
      responseForm = NULL,
      storeExecuteResponse = FALSE,
      lineage = NULL,
      status = NULL,
      update = FALSE,
      updateInterval = 1
    )

#### Arguments

- `dataInputs`:

  a named list of data inputs, objects of class
  [WPSLiteralData](https://eblondel.github.io/ows4R/reference/WPSLiteralData.md),
  [WPSComplexData](https://eblondel.github.io/ows4R/reference/WPSComplexData.md)
  or
  [WPSBoundingBoxData](https://eblondel.github.io/ows4R/reference/WPSBoundingBoxData.md)

- `responseForm`:

  response form, object of class
  [WPSResponseDocument](https://eblondel.github.io/ows4R/reference/WPSResponseDocument.md)

- `storeExecuteResponse`:

  store execute response? object of class `logical`. `FALSE` by default

- `lineage`:

  lineage, object of class `logical`

- `status`:

  status, object of class `logical`

- `update`:

  update, object of class `logical`. For asynchronous requests

- `updateInterval`:

  update interval, object of class `integer`. For asynchronous requests

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WPSProcess$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
