# WCSCoverageSummary

WCSCoverageSummary

WCSCoverageSummary

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html)
modelling a WCS coverage summary

## Note

Class used internally by ows4R.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `WCSCoverageSummary`

## Public fields

- `CoverageId`:

  coverage id

- `CoverageSubtype`:

  coverage subtype

- `CoverageSubtypeParent`:

  coverage subtype parent

- `WGS84BoundingBox`:

  WGS84 bounding box

- `BoundingBox`:

  bounding box

## Methods

### Public methods

- [`WCSCoverageSummary$new()`](#method-WCSCoverageSummary-new)

- [`WCSCoverageSummary$getId()`](#method-WCSCoverageSummary-getId)

- [`WCSCoverageSummary$getSubtype()`](#method-WCSCoverageSummary-getSubtype)

- [`WCSCoverageSummary$getSubtypeParent()`](#method-WCSCoverageSummary-getSubtypeParent)

- [`WCSCoverageSummary$getWGS84BoundingBox()`](#method-WCSCoverageSummary-getWGS84BoundingBox)

- [`WCSCoverageSummary$getBoundingBox()`](#method-WCSCoverageSummary-getBoundingBox)

- [`WCSCoverageSummary$getDescription()`](#method-WCSCoverageSummary-getDescription)

- [`WCSCoverageSummary$getDimensions()`](#method-WCSCoverageSummary-getDimensions)

- [`WCSCoverageSummary$getCoverage()`](#method-WCSCoverageSummary-getCoverage)

- [`WCSCoverageSummary$getCoverageStack()`](#method-WCSCoverageSummary-getCoverageStack)

- [`WCSCoverageSummary$clone()`](#method-WCSCoverageSummary-clone)

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

Initializes a WCSCoverageSummary object

#### Usage

    WCSCoverageSummary$new(
      xmlObj,
      capabilities,
      serviceVersion,
      owsVersion,
      logger = NULL
    )

#### Arguments

- `xmlObj`:

  object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

- `capabilities`:

  object of class
  [WCSCapabilities](https://eblondel.github.io/ows4R/reference/WCSCapabilities.md)

- `serviceVersion`:

  WCS service version

- `owsVersion`:

  version

- `logger`:

  logger type `NULL`, "INFO" or "DEBUG"

------------------------------------------------------------------------

### Method `getId()`

Get coverage ID

#### Usage

    WCSCoverageSummary$getId()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `getSubtype()`

Get sub type

#### Usage

    WCSCoverageSummary$getSubtype()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `getSubtypeParent()`

Get sub type parent

#### Usage

    WCSCoverageSummary$getSubtypeParent()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `getWGS84BoundingBox()`

Get bounding box

#### Usage

    WCSCoverageSummary$getWGS84BoundingBox()

#### Returns

an object of class
[OWSWGS84BoundingBox](https://eblondel.github.io/ows4R/reference/OWSWGS84BoundingBox.md)

------------------------------------------------------------------------

### Method `getBoundingBox()`

Get WGS84 bounding box

#### Usage

    WCSCoverageSummary$getBoundingBox()

#### Returns

an object of class
[OWSBoundingBox](https://eblondel.github.io/ows4R/reference/OWSBoundingBox.md)

------------------------------------------------------------------------

### Method `getDescription()`

Get description

#### Usage

    WCSCoverageSummary$getDescription()

#### Returns

an object of class
[WCSCoverageDescription](https://eblondel.github.io/ows4R/reference/WCSCoverageDescription.md)

------------------------------------------------------------------------

### Method `getDimensions()`

Get dimensions

#### Usage

    WCSCoverageSummary$getDimensions()

#### Returns

the list of dimensions

------------------------------------------------------------------------

### Method `getCoverage()`

Get coverage data

#### Usage

    WCSCoverageSummary$getCoverage(
      bbox = NULL,
      crs = NULL,
      time = NULL,
      elevation = NULL,
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

- `bbox`:

  bbox. Object of class `matrix`. Default is `NULL`. eg.
  `OWSUtils$toBBOX(-180,180,-90,90)`

- `crs`:

  crs. Object of class `character` giving the CRS identifier (EPSG
  prefixed code, or URI/URN). Default is `NULL`.

- `time`:

  time. Object of class `character` representing time instant/period.
  Default is `NULL`

- `elevation`:

  elevation. Object of class `character` or `numeric`. Default is `NULL`

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

#### Returns

an object of class `SpatRaster` from terra

------------------------------------------------------------------------

### Method `getCoverageStack()`

Get a spatio-temporal coverage data cubes as coverage
[stack](https://rdrr.io/r/utils/stack.html)

#### Usage

    WCSCoverageSummary$getCoverageStack(
      time = NULL,
      elevation = NULL,
      bbox = NULL,
      filename_handler = NULL,
      ...
    )

#### Arguments

- `time`:

  time

- `elevation`:

  elevation

- `bbox`:

  bbox

- `filename_handler`:

  Optional filename handling function with arguments 'identifier',
  'time', 'elevation', 'bbox', 'format' See
  [WCSCoverageFilenameHandler](https://eblondel.github.io/ows4R/reference/WCSCoverageFilenameHandler.md)
  as genric filename handler that can be used.

- `...`:

  any other parameter to pass to `getCoverage`

#### Returns

an object of class [stack](https://rdrr.io/r/utils/stack.html) from
raster

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WCSCoverageSummary$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
