# OWSHttpRequest

OWSHttpRequest

OWSHttpRequest

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling a generic OWS http request

## Note

Abstract class used internally by ows4R

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `OWSHttpRequest`

## Methods

### Public methods

- [`OWSHttpRequest$new()`](#method-OWSHttpRequest-new)

- [`OWSHttpRequest$execute()`](#method-OWSHttpRequest-execute)

- [`OWSHttpRequest$getCapabilities()`](#method-OWSHttpRequest-getCapabilities)

- [`OWSHttpRequest$getRequest()`](#method-OWSHttpRequest-getRequest)

- [`OWSHttpRequest$getRequestHeaders()`](#method-OWSHttpRequest-getRequestHeaders)

- [`OWSHttpRequest$getStatus()`](#method-OWSHttpRequest-getStatus)

- [`OWSHttpRequest$getResponse()`](#method-OWSHttpRequest-getResponse)

- [`OWSHttpRequest$getException()`](#method-OWSHttpRequest-getException)

- [`OWSHttpRequest$hasException()`](#method-OWSHttpRequest-hasException)

- [`OWSHttpRequest$getResult()`](#method-OWSHttpRequest-getResult)

- [`OWSHttpRequest$setResult()`](#method-OWSHttpRequest-setResult)

- [`OWSHttpRequest$clone()`](#method-OWSHttpRequest-clone)

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

Initializes an OWS HTTP request

#### Usage

    OWSHttpRequest$new(
      element,
      namespacePrefix,
      capabilities,
      op,
      type,
      url,
      request,
      user = NULL,
      pwd = NULL,
      token = NULL,
      headers = c(),
      config = httr::config(),
      namedParams = NULL,
      attrs = NULL,
      contentType = "text/xml",
      mimeType = "text/xml",
      skipXmlComments = TRUE,
      logger = NULL,
      ...
    )

#### Arguments

- `element`:

  element

- `namespacePrefix`:

  namespace prefix

- `capabilities`:

  object of class or extending
  [OWSCapabilities](https://eblondel.github.io/ows4R/reference/OWSCapabilities.md)

- `op`:

  object of class
  [OWSOperation](https://eblondel.github.io/ows4R/reference/OWSOperation.md)

- `type`:

  type of request, eg. GET, POST

- `url`:

  url

- `request`:

  request name

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

- `namedParams`:

  a named `list`

- `attrs`:

  attributes

- `contentType`:

  content type. Default value is "text/xml"

- `mimeType`:

  mime type. Default value is "text/xml"

- `skipXmlComments`:

  Skip XML comments from response

- `logger`:

  logger

- `...`:

  any other parameter

------------------------------------------------------------------------

### Method `execute()`

Executes the request

#### Usage

    OWSHttpRequest$execute()

------------------------------------------------------------------------

### Method `getCapabilities()`

Get capabilities

#### Usage

    OWSHttpRequest$getCapabilities()

#### Returns

an object of class or extending
[OWSCapabilities](https://eblondel.github.io/ows4R/reference/OWSCapabilities.md)

------------------------------------------------------------------------

### Method `getRequest()`

Get request

#### Usage

    OWSHttpRequest$getRequest()

#### Returns

the request

------------------------------------------------------------------------

### Method `getRequestHeaders()`

Get request headers

#### Usage

    OWSHttpRequest$getRequestHeaders()

#### Returns

the request headers

------------------------------------------------------------------------

### Method `getStatus()`

get status code

#### Usage

    OWSHttpRequest$getStatus()

#### Returns

the request status code

------------------------------------------------------------------------

### Method `getResponse()`

get request response

#### Usage

    OWSHttpRequest$getResponse()

#### Returns

the request response

------------------------------------------------------------------------

### Method `getException()`

get request exception

#### Usage

    OWSHttpRequest$getException()

#### Returns

the request exception

------------------------------------------------------------------------

### Method `hasException()`

Indicates if it has an exception

#### Usage

    OWSHttpRequest$hasException()

#### Returns

`TRUE` if it has an exception, `FALSE` otherwise

------------------------------------------------------------------------

### Method `getResult()`

Get the result `TRUE` if the request is successful, `FALSE` otherwise

#### Usage

    OWSHttpRequest$getResult()

#### Returns

the result, object of class `logical`

------------------------------------------------------------------------

### Method `setResult()`

Set the result

#### Usage

    OWSHttpRequest$setResult(result)

#### Arguments

- `result`:

  object of class `logical`

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    OWSHttpRequest$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
