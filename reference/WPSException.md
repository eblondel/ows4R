# WPSException

WPSException

WPSException

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a WPS Exception

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `WPSException`

## Public fields

- `value`:

  value

- `percentCompleted`:

  percent of completion

## Methods

### Public methods

- [`WPSException$new()`](#method-WPSException-new)

- [`WPSException$decode()`](#method-WPSException-decode)

- [`WPSException$clone()`](#method-WPSException-clone)

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

Initializes a WPSException

#### Usage

    WPSException$new(xml = NULL, serviceVersion = "1.0.0")

#### Arguments

- `xml`:

  object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

- `serviceVersion`:

  service version. Default "1.0.0"

------------------------------------------------------------------------

### Method `decode()`

Decodes an object of class WPSException from XML

#### Usage

    WPSException$decode(xml)

#### Arguments

- `xml`:

  object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WPSException$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
