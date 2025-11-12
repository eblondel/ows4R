# WMSClient

WMSClient

WMSClient

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for interfacing an OGC Web Map Service.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\>
[`ows4R::OWSClient`](https://eblondel.github.io/ows4R/reference/OWSClient.md)
-\> `WMSClient`

## Methods

### Public methods

- [`WMSClient$new()`](#method-WMSClient-new)

- [`WMSClient$getCapabilities()`](#method-WMSClient-getCapabilities)

- [`WMSClient$reloadCapabilities()`](#method-WMSClient-reloadCapabilities)

- [`WMSClient$getLayers()`](#method-WMSClient-getLayers)

- [`WMSClient$getMap()`](#method-WMSClient-getMap)

- [`WMSClient$getFeatureInfo()`](#method-WMSClient-getFeatureInfo)

- [`WMSClient$getLegendGraphic()`](#method-WMSClient-getLegendGraphic)

- [`WMSClient$clone()`](#method-WMSClient-clone)

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

This method is used to instantiate a WMSClient with the `url` of the OGC
service. Authentication is supported using basic auth (using
`user`/`pwd` arguments), bearer token (using `token` argument), or
custom (using `headers` argument). By default, the `logger` argument
will be set to `NULL` (no logger). This argument accepts two possible
values: `INFO`: to print only ows4R logs, `DEBUG`: to print more verbose
logs

#### Usage

    WMSClient$new(
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

Get WMS capabilities

#### Usage

    WMSClient$getCapabilities()

#### Returns

an object of class
[WMSCapabilities](https://eblondel.github.io/ows4R/reference/WMSCapabilities.md)

------------------------------------------------------------------------

### Method `reloadCapabilities()`

Reloads WFS capabilities

#### Usage

    WMSClient$reloadCapabilities()

------------------------------------------------------------------------

### Method `getLayers()`

List the layers available. If `pretty` is TRUE, the output will be an
object of class `data.frame`

#### Usage

    WMSClient$getLayers(pretty = FALSE)

#### Arguments

- `pretty`:

  pretty

#### Returns

a `list` of
[WMSLayer](https://eblondel.github.io/ows4R/reference/WMSLayer.md)
available, or a `data.frame`

------------------------------------------------------------------------

### Method `getMap()`

Get map. NOT YET IMPLEMENTED

#### Usage

    WMSClient$getMap()

------------------------------------------------------------------------

### Method `getFeatureInfo()`

Get feature info

#### Usage

    WMSClient$getFeatureInfo(
      layer,
      srs = NULL,
      styles = NULL,
      feature_count = 1,
      x,
      y,
      width,
      height,
      bbox,
      info_format = "application/vnd.ogc.gml",
      ...
    )

#### Arguments

- `layer`:

  layer name

- `srs`:

  srs

- `styles`:

  styles

- `feature_count`:

  feature count. Default is 1

- `x`:

  x

- `y`:

  y

- `width`:

  width

- `height`:

  height

- `bbox`:

  bbox

- `info_format`:

  info format. Default is "application/vnd.ogc.gml"

- `...`:

  any other parameter to pass to a
  [WMSGetFeatureInfo](https://eblondel.github.io/ows4R/reference/WMSGetFeatureInfo.md)
  request

#### Returns

an object of class `sf` given the feature(s)

------------------------------------------------------------------------

### Method `getLegendGraphic()`

Get legend graphic. NOT YET IMPLEMENTED

#### Usage

    WMSClient$getLegendGraphic()

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WMSClient$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# \dontrun{
   #example based on a WMS endpoint responding at http://localhost:8080/geoserver/wms
   wms <- WMSClient$new("http://localhost:8080/geoserver/wms", serviceVersion = "1.1.1")
#> Error in curl::curl_fetch_memory(url, handle = handle): Couldn't connect to server [localhost]:
#> Failed to connect to localhost port 8080 after 0 ms: Couldn't connect to server
   
   #get capabilities
   caps <- wms$getCapabilities()
#> Error: object 'wms' not found
   
   #get feature info
   
   #Advanced examples at https://github.com/eblondel/ows4R/wiki#wms
# }
```
