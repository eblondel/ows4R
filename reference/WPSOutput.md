# WPSOutput

WPSOutput

WPSOutput

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a WPS Input

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `WPSOutput`

## Public fields

- `Identifier`:

  identifier

- `Title`:

  tile

- `Data`:

  data

## Methods

### Public methods

- [`WPSOutput$new()`](#method-WPSOutput-new)

- [`WPSOutput$decode()`](#method-WPSOutput-decode)

- [`WPSOutput$getData()`](#method-WPSOutput-getData)

- [`WPSOutput$getDataValue()`](#method-WPSOutput-getDataValue)

- [`WPSOutput$clone()`](#method-WPSOutput-clone)

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

Initializes a WPSOutput

#### Usage

    WPSOutput$new(
      xml = NULL,
      identifier = NULL,
      title = NULL,
      data = NULL,
      dataType = NULL,
      serviceVersion = "1.0.0"
    )

#### Arguments

- `xml`:

  object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

- `identifier`:

  identifier

- `title`:

  title

- `data`:

  data

- `dataType`:

  data type

- `serviceVersion`:

  WPS service version

------------------------------------------------------------------------

### Method `decode()`

Decodes an object of class WPSOutput from XML

#### Usage

    WPSOutput$decode(xml)

#### Arguments

- `xml`:

  object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

------------------------------------------------------------------------

### Method `getData()`

Get data

#### Usage

    WPSOutput$getData()

#### Returns

data

------------------------------------------------------------------------

### Method `getDataValue()`

Get data value

#### Usage

    WPSOutput$getDataValue()

#### Returns

data value

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WPSOutput$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
