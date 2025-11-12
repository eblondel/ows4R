# WPSStatus

WPSStatus

WPSStatus

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a WPS Status

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `WPSStatus`

## Public fields

- `value`:

  status value

- `percentCompleted`:

  status percentage of completion

## Methods

### Public methods

- [`WPSStatus$new()`](#method-WPSStatus-new)

- [`WPSStatus$decode()`](#method-WPSStatus-decode)

- [`WPSStatus$getValue()`](#method-WPSStatus-getValue)

- [`WPSStatus$getPercentCompleted()`](#method-WPSStatus-getPercentCompleted)

- [`WPSStatus$getCreationTime()`](#method-WPSStatus-getCreationTime)

- [`WPSStatus$clone()`](#method-WPSStatus-clone)

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

Initalizes a WPSStatus object

#### Usage

    WPSStatus$new(xml = NULL, serviceVersion = "1.0.0")

#### Arguments

- `xml`:

  an object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

- `serviceVersion`:

  WPS service version. Default is "1.0.0"

------------------------------------------------------------------------

### Method `decode()`

Decodes WPS status from XML

#### Usage

    WPSStatus$decode(xml)

#### Arguments

- `xml`:

  an object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

------------------------------------------------------------------------

### Method `getValue()`

Get status value, among accepted WPS status values defined in the WPS
standard: `ProcessAccepted`, `ProcessStarted`, `ProcessPaused`,
`ProcessSucceeded`, `ProcessFailed`.

#### Usage

    WPSStatus$getValue()

#### Returns

value, object of class `character`

------------------------------------------------------------------------

### Method `getPercentCompleted()`

Get percentage of completion

#### Usage

    WPSStatus$getPercentCompleted()

#### Returns

the percentage of completion, object of class `integer`

------------------------------------------------------------------------

### Method `getCreationTime()`

Get creation time

#### Usage

    WPSStatus$getCreationTime()

#### Returns

the creation time, object of class `POSIXct`

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WPSStatus$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
