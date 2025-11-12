# WCSClient

WCSClient

WCSClient

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for interfacing an OGC Web Coverage Service.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\>
[`ows4R::OWSClient`](https://eblondel.github.io/ows4R/reference/OWSClient.md)
-\> `WCSClient`

## Methods

### Public methods

- [`WCSClient$new()`](#method-WCSClient-new)

- [`WCSClient$getCapabilities()`](#method-WCSClient-getCapabilities)

- [`WCSClient$reloadCapabilities()`](#method-WCSClient-reloadCapabilities)

- [`WCSClient$describeCoverage()`](#method-WCSClient-describeCoverage)

- [`WCSClient$getCoverage()`](#method-WCSClient-getCoverage)

- [`WCSClient$clone()`](#method-WCSClient-clone)

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

This method is used to instantiate a WCSClient with the `url` of the OGC
service. Authentication is supported using basic auth (using
`user`/`pwd` arguments), bearer token (using `token` argument), or
custom (using `headers` argument). By default, the `logger` argument
will be set to `NULL` (no logger). This argument accepts two possible
values: `INFO`: to print only ows4R logs, `DEBUG`: to print more verbose
logs

#### Usage

    WCSClient$new(
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

Get WCS capabilities

#### Usage

    WCSClient$getCapabilities()

#### Returns

an object of class
[WCSCapabilities](https://eblondel.github.io/ows4R/reference/WCSCapabilities.md)

------------------------------------------------------------------------

### Method `reloadCapabilities()`

Reloads WCS capabilities

#### Usage

    WCSClient$reloadCapabilities()

------------------------------------------------------------------------

### Method `describeCoverage()`

Describes coverage

#### Usage

    WCSClient$describeCoverage(identifier)

#### Arguments

- `identifier`:

  identifier

#### Returns

an object of class
[WCSCoverageDescription](https://eblondel.github.io/ows4R/reference/WCSCoverageDescription.md)

------------------------------------------------------------------------

### Method `getCoverage()`

Get coverage

#### Usage

    WCSClient$getCoverage(
      identifier,
      bbox = NULL,
      crs = NULL,
      time = NULL,
      format = NULL,
      rangesubset = NULL,
      gridbaseCRS = NULL,
      gridtype = NULL,
      gridCS = NULL,
      gridorigin = NULL,
      gridoffsets = NULL,
      method = "GET",
      filename = NULL,
      ...
    )

#### Arguments

- `identifier`:

  Coverage identifier. Object of class `character`

- `bbox`:

  bbox. Object of class `matrix`. Default is `NULL`. eg.
  `OWSUtils$toBBOX(-180,180,-90,90)`

- `crs`:

  crs. Object of class `character` giving the CRS identifier (EPSG
  prefixed code, or URI/URN). Default is `NULL`.

- `time`:

  time. Object of class `character` representing time instant/period.
  Default is `NULL`

- `format`:

  format. Object of class `character` Default will be GeoTIFF, coded
  differently depending on the WCS version.

- `rangesubset`:

  rangesubset. Default is `NULL`

- `gridbaseCRS`:

  grid base CRS. Default is `NULL`

- `gridtype`:

  grid type. Default is `NULL`

- `gridCS`:

  grid CS. Default is `NULL`

- `gridorigin`:

  grid origin. Default is `NULL`

- `gridoffsets`:

  grid offsets. Default is `NULL`

- `method`:

  method to get coverage, either 'GET' or 'POST' (experimental - under
  development). Object of class `character`.

- `filename`:

  filename. Object of class `character`. Optional filename to download
  the coverage

- `...`:

  any other argument to
  [WCSGetCoverage](https://eblondel.github.io/ows4R/reference/WCSGetCoverage.md)

- `elevation`:

  elevation. Object of class `character` or `numeric`. Default is `NULL`

#### Returns

an object of class `SpatRaster` from terra

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WCSClient$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
# \dontrun{
   wcs <- WCSClient$new("http://localhost:8080/geoserver/wcs", serviceVersion = "2.0.1")
#> Error in curl::curl_fetch_memory(url, handle = handle): Couldn't connect to server [localhost]:
#> Failed to connect to localhost port 8080 after 0 ms: Couldn't connect to server
# }
```
