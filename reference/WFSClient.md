# WFSClient

WFSClient

WFSClient

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for interfacing an OGC Web Feature Service.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\>
[`ows4R::OWSClient`](https://eblondel.github.io/ows4R/reference/OWSClient.md)
-\> `WFSClient`

## Methods

### Public methods

- [`WFSClient$new()`](#method-WFSClient-new)

- [`WFSClient$getCapabilities()`](#method-WFSClient-getCapabilities)

- [`WFSClient$reloadCapabilities()`](#method-WFSClient-reloadCapabilities)

- [`WFSClient$describeFeatureType()`](#method-WFSClient-describeFeatureType)

- [`WFSClient$getFeatures()`](#method-WFSClient-getFeatures)

- [`WFSClient$getFeatureTypes()`](#method-WFSClient-getFeatureTypes)

- [`WFSClient$clone()`](#method-WFSClient-clone)

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
- [`ows4R::OWSClient$getCASUrl()`](https://eblondel.github.io/ows4R/reference/OWSClient.html#method-getCASUrl)
- [`ows4R::OWSClient$getConfig()`](https://eblondel.github.io/ows4R/reference/OWSClient.html#method-getConfig)
- [`ows4R::OWSClient$getHeaders()`](https://eblondel.github.io/ows4R/reference/OWSClient.html#method-getHeaders)
- [`ows4R::OWSClient$getPwd()`](https://eblondel.github.io/ows4R/reference/OWSClient.html#method-getPwd)
- [`ows4R::OWSClient$getToken()`](https://eblondel.github.io/ows4R/reference/OWSClient.html#method-getToken)
- [`ows4R::OWSClient$getUrl()`](https://eblondel.github.io/ows4R/reference/OWSClient.html#method-getUrl)
- [`ows4R::OWSClient$getUser()`](https://eblondel.github.io/ows4R/reference/OWSClient.html#method-getUser)
- [`ows4R::OWSClient$getVersion()`](https://eblondel.github.io/ows4R/reference/OWSClient.html#method-getVersion)

------------------------------------------------------------------------

### Method `new()`

This method is used to instantiate a WFSClient with the `url` of the OGC
service. Authentication is supported using basic auth (using
`user`/`pwd` arguments), bearer token (using `token` argument), or
custom (using `headers` argument). By default, the `logger` argument
will be set to `NULL` (no logger). This argument accepts two possible
values: `INFO`: to print only ows4R logs, `DEBUG`: to print more verbose
logs

#### Usage

    WFSClient$new(
      url,
      serviceVersion = NULL,
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

- `serviceVersion`:

  WFS service version

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

### Method `getCapabilities()`

Get WFS capabilities

#### Usage

    WFSClient$getCapabilities()

#### Returns

an object of class
[WFSCapabilities](https://eblondel.github.io/ows4R/reference/WFSCapabilities.md)

------------------------------------------------------------------------

### Method `reloadCapabilities()`

Reloads WFS capabilities

#### Usage

    WFSClient$reloadCapabilities()

------------------------------------------------------------------------

### Method `describeFeatureType()`

Describes a feature type

#### Usage

    WFSClient$describeFeatureType(typeName)

#### Arguments

- `typeName`:

  the name of the feature type

#### Returns

a `list` of
[WFSFeatureTypeElement](https://eblondel.github.io/ows4R/reference/WFSFeatureTypeElement.md)

------------------------------------------------------------------------

### Method `getFeatures()`

Get features

#### Usage

    WFSClient$getFeatures(typeName, ...)

#### Arguments

- `typeName`:

  the name of the feature type

- `...`:

  any other parameter to pass to the
  [WFSGetFeature](https://eblondel.github.io/ows4R/reference/WFSGetFeature.md)
  request

#### Returns

features as object of class `sf`

------------------------------------------------------------------------

### Method `getFeatureTypes()`

List the feature types available. If `pretty` is TRUE, the output will
be an object of class `data.frame`

#### Usage

    WFSClient$getFeatureTypes(pretty = FALSE)

#### Arguments

- `pretty`:

  whether the output should be summarized as `data.frame`

#### Returns

a `list` of
[WFSFeatureType](https://eblondel.github.io/ows4R/reference/WFSFeatureType.md)
or a `data.frame`

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WFSClient$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# \dontrun{
   #example based on a WFS endpoint responding at http://localhost:8080/geoserver/wfs
   wfs <- WFSClient$new("http://localhost:8080/geoserver/wfs", serviceVersion = "1.1.1")
#> Error in curl::curl_fetch_memory(url, handle = handle): Couldn't connect to server [localhost]:
#> Failed to connect to localhost port 8080 after 0 ms: Couldn't connect to server
   
   #get capabilities
   caps <- wfs$getCapabilities()
#> Error: object 'wfs' not found
   
   #find feature type
   ft <- caps$findFeatureTypeByName("mylayer")
#> Error: object 'caps' not found
   if(length(ft)>0){
     data <- ft$getFeatures()
     data_with_filter <- ft$getFeatures(cql_filter = "somefilter")
   }
#> Error: object 'ft' not found
   
   #Advanced examples at https://github.com/eblondel/ows4R/wiki#wfs
# }
```
