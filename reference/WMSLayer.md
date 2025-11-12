# WMSLayer

WMSLayer

WMSLayer

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html)
modelling a WMS layer

## Note

Abstract class used by ows4R

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `WMSLayer`

## Public fields

- `description`:

  description

- `features`:

  features

## Methods

### Public methods

- [`WMSLayer$new()`](#method-WMSLayer-new)

- [`WMSLayer$getName()`](#method-WMSLayer-getName)

- [`WMSLayer$getTitle()`](#method-WMSLayer-getTitle)

- [`WMSLayer$getAbstract()`](#method-WMSLayer-getAbstract)

- [`WMSLayer$getKeywords()`](#method-WMSLayer-getKeywords)

- [`WMSLayer$getDefaultCRS()`](#method-WMSLayer-getDefaultCRS)

- [`WMSLayer$getBoundingBox()`](#method-WMSLayer-getBoundingBox)

- [`WMSLayer$getBoundingBoxSRS()`](#method-WMSLayer-getBoundingBoxSRS)

- [`WMSLayer$getBoundingBoxCRS()`](#method-WMSLayer-getBoundingBoxCRS)

- [`WMSLayer$getStyles()`](#method-WMSLayer-getStyles)

- [`WMSLayer$getStylenames()`](#method-WMSLayer-getStylenames)

- [`WMSLayer$getDimensions()`](#method-WMSLayer-getDimensions)

- [`WMSLayer$getTimeDimension()`](#method-WMSLayer-getTimeDimension)

- [`WMSLayer$getElevationDimension()`](#method-WMSLayer-getElevationDimension)

- [`WMSLayer$getFeatureInfo()`](#method-WMSLayer-getFeatureInfo)

- [`WMSLayer$clone()`](#method-WMSLayer-clone)

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

Initializes an object of class WMSLayer

#### Usage

    WMSLayer$new(xmlObj, capabilities, version, logger = NULL)

#### Arguments

- `xmlObj`:

  an object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  to initialize from XML

- `capabilities`:

  object of class
  [WMSCapabilities](https://eblondel.github.io/ows4R/reference/WMSCapabilities.md)

- `version`:

  service version

- `logger`:

  logger

------------------------------------------------------------------------

### Method `getName()`

Get layer name

#### Usage

    WMSLayer$getName()

#### Returns

object of class `character`

------------------------------------------------------------------------

### Method `getTitle()`

Get layer title

#### Usage

    WMSLayer$getTitle()

#### Returns

object of class `character`

------------------------------------------------------------------------

### Method `getAbstract()`

Get layer abstract

#### Usage

    WMSLayer$getAbstract()

#### Returns

object of class `character`

------------------------------------------------------------------------

### Method `getKeywords()`

Get layer keywords

#### Usage

    WMSLayer$getKeywords()

#### Returns

object of class `character`

------------------------------------------------------------------------

### Method `getDefaultCRS()`

Get layer default CRS

#### Usage

    WMSLayer$getDefaultCRS()

#### Returns

object of class `character`

------------------------------------------------------------------------

### Method `getBoundingBox()`

Get layer bounding box

#### Usage

    WMSLayer$getBoundingBox()

#### Returns

object of class `matrix`

------------------------------------------------------------------------

### Method `getBoundingBoxSRS()`

Get layer bounding box SRS

#### Usage

    WMSLayer$getBoundingBoxSRS()

#### Returns

object of class `character`

------------------------------------------------------------------------

### Method `getBoundingBoxCRS()`

Get layer bounding box CRS

#### Usage

    WMSLayer$getBoundingBoxCRS()

#### Returns

object of class `character`

------------------------------------------------------------------------

### Method `getStyles()`

Get layer styles

#### Usage

    WMSLayer$getStyles()

#### Returns

an object of class `list`

------------------------------------------------------------------------

### Method `getStylenames()`

Get layer style names

#### Usage

    WMSLayer$getStylenames()

#### Returns

list of object of class `character`

------------------------------------------------------------------------

### Method `getDimensions()`

Get layer dimensions

#### Usage

    WMSLayer$getDimensions(time_format = "character")

#### Arguments

- `time_format`:

  time format. Default is `character`

#### Returns

a `list` including default value and listed possible values

------------------------------------------------------------------------

### Method `getTimeDimension()`

Get layer TIME dimensions

#### Usage

    WMSLayer$getTimeDimension(time_format = "character")

#### Arguments

- `time_format`:

  time format. Default is `character`

#### Returns

a `list` including default value and listed possible values

------------------------------------------------------------------------

### Method `getElevationDimension()`

Get layer ELEVATION dimensions

#### Usage

    WMSLayer$getElevationDimension()

#### Returns

a `list` including default value and listed possible values

------------------------------------------------------------------------

### Method `getFeatureInfo()`

Get feature info

#### Usage

    WMSLayer$getFeatureInfo(
      srs = NULL,
      styles = NULL,
      feature_count = 1,
      x,
      y,
      width,
      height,
      bbox,
      info_format = "text/xml",
      ...
    )

#### Arguments

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

  info format. Default is "text/xml"

- `...`:

  any other parameter to pass to a
  [WMSGetFeatureInfo](https://eblondel.github.io/ows4R/reference/WMSGetFeatureInfo.md)
  request

#### Returns

an object of class `sf` given the feature(s)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WMSLayer$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
