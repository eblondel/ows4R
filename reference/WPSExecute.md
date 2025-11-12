# WPSExecute

WPSExecute

WPSExecute

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a WPS Execute request

## Note

Class used internally by ows4R to trigger a WPS Execute request

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\>
[`ows4R::OWSHttpRequest`](https://eblondel.github.io/ows4R/reference/OWSHttpRequest.md)
-\> `WPSExecute`

## Public fields

- `Identifier`:

  process identifier

- `DataInputs`:

  list of
  [WPSInput](https://eblondel.github.io/ows4R/reference/WPSInput.md)

- `ResponseForm`:

  response form

## Methods

### Public methods

- [`WPSExecute$new()`](#method-WPSExecute-new)

- [`WPSExecute$getProcessDescription()`](#method-WPSExecute-getProcessDescription)

- [`WPSExecute$clone()`](#method-WPSExecute-clone)

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
- [`ows4R::OWSHttpRequest$execute()`](https://eblondel.github.io/ows4R/reference/OWSHttpRequest.html#method-execute)
- [`ows4R::OWSHttpRequest$getCapabilities()`](https://eblondel.github.io/ows4R/reference/OWSHttpRequest.html#method-getCapabilities)
- [`ows4R::OWSHttpRequest$getException()`](https://eblondel.github.io/ows4R/reference/OWSHttpRequest.html#method-getException)
- [`ows4R::OWSHttpRequest$getRequest()`](https://eblondel.github.io/ows4R/reference/OWSHttpRequest.html#method-getRequest)
- [`ows4R::OWSHttpRequest$getRequestHeaders()`](https://eblondel.github.io/ows4R/reference/OWSHttpRequest.html#method-getRequestHeaders)
- [`ows4R::OWSHttpRequest$getResponse()`](https://eblondel.github.io/ows4R/reference/OWSHttpRequest.html#method-getResponse)
- [`ows4R::OWSHttpRequest$getResult()`](https://eblondel.github.io/ows4R/reference/OWSHttpRequest.html#method-getResult)
- [`ows4R::OWSHttpRequest$getStatus()`](https://eblondel.github.io/ows4R/reference/OWSHttpRequest.html#method-getStatus)
- [`ows4R::OWSHttpRequest$hasException()`](https://eblondel.github.io/ows4R/reference/OWSHttpRequest.html#method-hasException)
- [`ows4R::OWSHttpRequest$setResult()`](https://eblondel.github.io/ows4R/reference/OWSHttpRequest.html#method-setResult)

------------------------------------------------------------------------

### Method `new()`

Initializes a WPSExecute service request

#### Usage

    WPSExecute$new(
      capabilities,
      op,
      url,
      serviceVersion,
      identifier,
      dataInputs = list(),
      responseForm = NULL,
      storeExecuteResponse = FALSE,
      lineage = NULL,
      status = NULL,
      user = NULL,
      pwd = NULL,
      token = NULL,
      headers = c(),
      config = httr::config(),
      logger = NULL,
      ...
    )

#### Arguments

- `capabilities`:

  object of class
  [WPSCapabilities](https://eblondel.github.io/ows4R/reference/WPSCapabilities.md)

- `op`:

  object of class
  [OWSOperation](https://eblondel.github.io/ows4R/reference/OWSOperation.md)

- `url`:

  url

- `serviceVersion`:

  WPS service version

- `identifier`:

  process identifier

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

- `user`:

  user

- `pwd`:

  password

- `token`:

  token

- `headers`:

  headers

- `config`:

  config

- `logger`:

  logger

- `...`:

  any other parameter to pass to the request

------------------------------------------------------------------------

### Method `getProcessDescription()`

Get process description

#### Usage

    WPSExecute$getProcessDescription()

#### Returns

an object of class
[WPSProcessDescription](https://eblondel.github.io/ows4R/reference/WPSProcessDescription.md)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WPSExecute$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
