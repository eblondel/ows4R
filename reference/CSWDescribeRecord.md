# CSWDescribeRecord

CSWDescribeRecord

CSWDescribeRecord

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a CSW DescribeRecord request

## Note

Class used internally by ows4R to trigger a CSW DescribeRecord request

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\>
[`ows4R::OWSHttpRequest`](https://eblondel.github.io/ows4R/reference/OWSHttpRequest.md)
-\> `CSWDescribeRecord`

## Methods

### Public methods

- [`CSWDescribeRecord$new()`](#method-CSWDescribeRecord-new)

- [`CSWDescribeRecord$clone()`](#method-CSWDescribeRecord-clone)

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

Initializes a CSWDescribeRecord service request

#### Usage

    CSWDescribeRecord$new(
      capabilities,
      op,
      url,
      version,
      namespace = NULL,
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

  an object of class
  [CSWCapabilities](https://eblondel.github.io/ows4R/reference/CSWCapabilities.md)

- `op`:

  object of class
  [OWSOperation](https://eblondel.github.io/ows4R/reference/OWSOperation.md)
  as retrieved from capabilities

- `url`:

  url

- `version`:

  version

- `namespace`:

  namespace

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

  any parameter to pass to the service request

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    CSWDescribeRecord$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
