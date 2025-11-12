# OWSClient

OWSClient

OWSClient

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for interfacing a Common OGC web-service.

## Note

Abstract class used internally by ows4R

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `OWSClient`

## Public fields

- `url`:

  Base url of the OWS service

- `version`:

  version of the OWS service

- `capabilities`:

  object giving the OWS service capabilities

## Methods

### Public methods

- [`OWSClient$new()`](#method-OWSClient-new)

- [`OWSClient$getUrl()`](#method-OWSClient-getUrl)

- [`OWSClient$getVersion()`](#method-OWSClient-getVersion)

- [`OWSClient$getCapabilities()`](#method-OWSClient-getCapabilities)

- [`OWSClient$getUser()`](#method-OWSClient-getUser)

- [`OWSClient$getPwd()`](#method-OWSClient-getPwd)

- [`OWSClient$getToken()`](#method-OWSClient-getToken)

- [`OWSClient$getHeaders()`](#method-OWSClient-getHeaders)

- [`OWSClient$getConfig()`](#method-OWSClient-getConfig)

- [`OWSClient$getCASUrl()`](#method-OWSClient-getCASUrl)

- [`OWSClient$clone()`](#method-OWSClient-clone)

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

This method is used to instantiate a OWSClient with the `url` of the OGC
service. Authentication is supported using basic auth (using
`user`/`pwd` arguments), bearer token (using `token` argument), or
custom (using `headers` argument). By default, the `logger` argument
will be set to `NULL` (no logger). This argument accepts two possible
values: `INFO`: to print only ows4R logs, `DEBUG`: to print more verbose
logs

#### Usage

    OWSClient$new(
      url,
      service,
      serviceVersion,
      user = NULL,
      pwd = NULL,
      token = NULL,
      headers = c(),
      config = httr::config(),
      cas_url = NULL,
      logger = NULL
    )

#### Arguments

- `url`:

  url

- `service`:

  service name

- `serviceVersion`:

  CSW service version

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

- `cas_url`:

  Central Authentication Service (CAS) URL

- `logger`:

  logger

------------------------------------------------------------------------

### Method `getUrl()`

Get URL

#### Usage

    OWSClient$getUrl()

#### Returns

the url of the service, object of class `character`

------------------------------------------------------------------------

### Method `getVersion()`

Get version

#### Usage

    OWSClient$getVersion()

#### Returns

the version of the service, object of class `character`

------------------------------------------------------------------------

### Method `getCapabilities()`

Get capabilities

#### Usage

    OWSClient$getCapabilities()

#### Returns

the capabilities, object of class
[OWSCapabilities](https://eblondel.github.io/ows4R/reference/OWSCapabilities.md)

------------------------------------------------------------------------

### Method `getUser()`

Get user

#### Usage

    OWSClient$getUser()

#### Returns

the user, object of class `character`

------------------------------------------------------------------------

### Method `getPwd()`

Get password

#### Usage

    OWSClient$getPwd()

#### Returns

the password, object of class `character`

------------------------------------------------------------------------

### Method `getToken()`

Get token

#### Usage

    OWSClient$getToken()

#### Returns

the token, object of class `character`

------------------------------------------------------------------------

### Method `getHeaders()`

Get headers

#### Usage

    OWSClient$getHeaders()

#### Returns

the headers, object of class `character`

------------------------------------------------------------------------

### Method `getConfig()`

Get httr config

#### Usage

    OWSClient$getConfig()

#### Returns

the httr config, if any

------------------------------------------------------------------------

### Method `getCASUrl()`

Get CAS URL

#### Usage

    OWSClient$getCASUrl()

#### Returns

a CAS URL

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    OWSClient$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
