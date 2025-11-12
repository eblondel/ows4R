# WPSComplexData

WPSComplexData

WPSComplexData

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a WPS Complex Data

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `WPSComplexData`

## Public fields

- `value`:

  value

## Methods

### Public methods

- [`WPSComplexData$new()`](#method-WPSComplexData-new)

- [`WPSComplexData$decode()`](#method-WPSComplexData-decode)

- [`WPSComplexData$checkValidity()`](#method-WPSComplexData-checkValidity)

- [`WPSComplexData$getFeatures()`](#method-WPSComplexData-getFeatures)

- [`WPSComplexData$clone()`](#method-WPSComplexData-clone)

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

Initializes an object of class WPSComplexData

#### Usage

    WPSComplexData$new(
      xml = NULL,
      value = NULL,
      schema = NULL,
      mimeType = NULL,
      serviceVersion = "1.0.0",
      cdata = TRUE
    )

#### Arguments

- `xml`:

  an object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  to initialize from XML

- `value`:

  value

- `schema`:

  schema

- `mimeType`:

  mime type

- `serviceVersion`:

  WPS service version

- `cdata`:

  whether value has to be wrapped in a XML CDATA. Default is `TRUE`

------------------------------------------------------------------------

### Method `decode()`

Decodes an object of class WPSComplexData from XML

#### Usage

    WPSComplexData$decode(xml)

#### Arguments

- `xml`:

  an object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  to initialize from XML

------------------------------------------------------------------------

### Method `checkValidity()`

Check the object against a parameter description inherited from a WPS
process description, object of class `WPSComplexInputDescription`. If
not valid, the function will raise an error.

#### Usage

    WPSComplexData$checkValidity(parameterDescription)

#### Arguments

- `parameterDescription`:

  object of class
  [WPSComplexInputDescription](https://eblondel.github.io/ows4R/reference/WPSComplexInputDescription.md)

#### Returns

an error if not valid

------------------------------------------------------------------------

### Method `getFeatures()`

Get features

#### Usage

    WPSComplexData$getFeatures()

#### Returns

object of class `sf`

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WPSComplexData$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
