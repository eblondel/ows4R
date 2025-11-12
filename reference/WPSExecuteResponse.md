# WPSExecuteResponse

WPSExecuteResponse

WPSExecuteResponse

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a WPS Execute response

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `WPSExecuteResponse`

## Public fields

- `process`:

  process

- `status`:

  status

- `statusLocation`:

  status location

- `statusHistory`:

  status history

- `processOutputs`:

  process outputs

- `exception`:

  exception

## Methods

### Public methods

- [`WPSExecuteResponse$new()`](#method-WPSExecuteResponse-new)

- [`WPSExecuteResponse$getProcess()`](#method-WPSExecuteResponse-getProcess)

- [`WPSExecuteResponse$getStatus()`](#method-WPSExecuteResponse-getStatus)

- [`WPSExecuteResponse$getStatusLocation()`](#method-WPSExecuteResponse-getStatusLocation)

- [`WPSExecuteResponse$getStatusHistory()`](#method-WPSExecuteResponse-getStatusHistory)

- [`WPSExecuteResponse$getProcessOutputs()`](#method-WPSExecuteResponse-getProcessOutputs)

- [`WPSExecuteResponse$getException()`](#method-WPSExecuteResponse-getException)

- [`WPSExecuteResponse$decode()`](#method-WPSExecuteResponse-decode)

- [`WPSExecuteResponse$update()`](#method-WPSExecuteResponse-update)

- [`WPSExecuteResponse$clone()`](#method-WPSExecuteResponse-clone)

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

Initializes a WPSExecuteResponse

#### Usage

    WPSExecuteResponse$new(
      xml,
      capabilities,
      processDescription = NULL,
      logger = NULL
    )

#### Arguments

- `xml`:

  object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

- `capabilities`:

  object of class
  [WPSCapabilities](https://eblondel.github.io/ows4R/reference/WPSCapabilities.md)

- `processDescription`:

  process description

- `logger`:

  logger

------------------------------------------------------------------------

### Method `getProcess()`

Get process

#### Usage

    WPSExecuteResponse$getProcess()

#### Returns

an object of class
[WPSProcess](https://eblondel.github.io/ows4R/reference/WPSProcess.md)

------------------------------------------------------------------------

### Method `getStatus()`

Get status

#### Usage

    WPSExecuteResponse$getStatus()

#### Returns

an object of class
[WPSStatus](https://eblondel.github.io/ows4R/reference/WPSStatus.md)

------------------------------------------------------------------------

### Method `getStatusLocation()`

Get status location

#### Usage

    WPSExecuteResponse$getStatusLocation()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `getStatusHistory()`

Get status history

#### Usage

    WPSExecuteResponse$getStatusHistory()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `getProcessOutputs()`

Get list of process outputs

#### Usage

    WPSExecuteResponse$getProcessOutputs()

#### Returns

a `list` of outputs

------------------------------------------------------------------------

### Method `getException()`

Get exception

#### Usage

    WPSExecuteResponse$getException()

#### Returns

an object of class
[WPSException](https://eblondel.github.io/ows4R/reference/WPSException.md)

------------------------------------------------------------------------

### Method `decode()`

Decodes an object of class WPSExecuteResponse from XML

#### Usage

    WPSExecuteResponse$decode(xml, capabilities, processDescription, logger)

#### Arguments

- `xml`:

  object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

- `capabilities`:

  object of class
  [WPSCapabilities](https://eblondel.github.io/ows4R/reference/WPSCapabilities.md)

- `processDescription`:

  process description

- `logger`:

  logger

------------------------------------------------------------------------

### Method [`update()`](https://rdrr.io/r/stats/update.html)

Updates status history

#### Usage

    WPSExecuteResponse$update(verbose = FALSE)

#### Arguments

- `verbose`:

  verbose. Default is `FALSE`

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WPSExecuteResponse$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
