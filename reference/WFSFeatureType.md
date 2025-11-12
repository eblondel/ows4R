# WFSFeatureType

WFSFeatureType

WFSFeatureType

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html)
modelling a WFS feature type

## Note

Class used internally by ows4R to trigger a WFS DescribeFeatureType
request

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `WFSFeatureType`

## Public fields

- `description`:

  description

## Methods

### Public methods

- [`WFSFeatureType$new()`](#method-WFSFeatureType-new)

- [`WFSFeatureType$getName()`](#method-WFSFeatureType-getName)

- [`WFSFeatureType$getTitle()`](#method-WFSFeatureType-getTitle)

- [`WFSFeatureType$getAbstract()`](#method-WFSFeatureType-getAbstract)

- [`WFSFeatureType$getKeywords()`](#method-WFSFeatureType-getKeywords)

- [`WFSFeatureType$getDefaultCRS()`](#method-WFSFeatureType-getDefaultCRS)

- [`WFSFeatureType$getBoundingBox()`](#method-WFSFeatureType-getBoundingBox)

- [`WFSFeatureType$getDescription()`](#method-WFSFeatureType-getDescription)

- [`WFSFeatureType$hasGeometry()`](#method-WFSFeatureType-hasGeometry)

- [`WFSFeatureType$getGeometryField()`](#method-WFSFeatureType-getGeometryField)

- [`WFSFeatureType$getGeometryType()`](#method-WFSFeatureType-getGeometryType)

- [`WFSFeatureType$getFeaturesCRS()`](#method-WFSFeatureType-getFeaturesCRS)

- [`WFSFeatureType$getFeatures()`](#method-WFSFeatureType-getFeatures)

- [`WFSFeatureType$clone()`](#method-WFSFeatureType-clone)

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

Initializes an object of class WFSFeatureType

#### Usage

    WFSFeatureType$new(xmlObj, capabilities, version, logger = NULL)

#### Arguments

- `xmlObj`:

  an object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  to initialize from XML

- `capabilities`:

  object of class
  [WFSCapabilities](https://eblondel.github.io/ows4R/reference/WFSCapabilities.md)

- `version`:

  service version

- `logger`:

  logger

------------------------------------------------------------------------

### Method `getName()`

Get feature type name

#### Usage

    WFSFeatureType$getName()

#### Arguments

- `object`:

  of class `character`

------------------------------------------------------------------------

### Method `getTitle()`

Get feature type title

#### Usage

    WFSFeatureType$getTitle()

#### Arguments

- `object`:

  of class `character`

------------------------------------------------------------------------

### Method `getAbstract()`

Get feature type abstract

#### Usage

    WFSFeatureType$getAbstract()

#### Arguments

- `object`:

  of class `character`

------------------------------------------------------------------------

### Method `getKeywords()`

Get feature type keywords

#### Usage

    WFSFeatureType$getKeywords()

#### Arguments

- `object`:

  of class `character`

------------------------------------------------------------------------

### Method `getDefaultCRS()`

Get feature type default CRS

#### Usage

    WFSFeatureType$getDefaultCRS()

#### Arguments

- `object`:

  of class `character`

------------------------------------------------------------------------

### Method `getBoundingBox()`

Get feature type bounding box

#### Usage

    WFSFeatureType$getBoundingBox()

#### Arguments

- `object`:

  of class `matrix`

------------------------------------------------------------------------

### Method `getDescription()`

Describes a feature type

#### Usage

    WFSFeatureType$getDescription(pretty = FALSE)

#### Arguments

- `pretty`:

  pretty whether to return a prettified `data.frame`. Default is `FALSE`

#### Returns

a `list` of
[WFSFeatureTypeElement](https://eblondel.github.io/ows4R/reference/WFSFeatureTypeElement.md)
or `data.frame`

------------------------------------------------------------------------

### Method `hasGeometry()`

Indicates with feature type has a geometry

#### Usage

    WFSFeatureType$hasGeometry()

#### Returns

object of class [logical](https://rdrr.io/r/base/logical.html)

------------------------------------------------------------------------

### Method `getGeometryField()`

Get geometry field

#### Usage

    WFSFeatureType$getGeometryField()

#### Returns

object of class [character](https://rdrr.io/r/base/character.html)
representing the geometry field

------------------------------------------------------------------------

### Method `getGeometryType()`

Get geometry type

#### Usage

    WFSFeatureType$getGeometryType()

#### Returns

object of class [character](https://rdrr.io/r/base/character.html)
representing the geometry type

------------------------------------------------------------------------

### Method `getFeaturesCRS()`

Inherits features CRS

#### Usage

    WFSFeatureType$getFeaturesCRS(obj)

#### Arguments

- `obj`:

  features object

#### Returns

object of class [integer](https://rdrr.io/r/base/integer.html)

------------------------------------------------------------------------

### Method `getFeatures()`

Get features

#### Usage

    WFSFeatureType$getFeatures(
      ...,
      validate = TRUE,
      outputFormat = NULL,
      paging = FALSE,
      paging_length = 1000,
      parallel = FALSE,
      parallel_handler = NULL,
      cl = NULL
    )

#### Arguments

- `...`:

  any other parameter to pass to the
  [WFSGetFeature](https://eblondel.github.io/ows4R/reference/WFSGetFeature.md)
  request

- `validate`:

  Whether features have to be validated vs. the feature type
  description. Default is `TRUE`

- `outputFormat`:

  output format

- `paging`:

  paging. Default is `FALSE`

- `paging_length`:

  number of features to request per page. Default is 1000

- `parallel`:

  whether to get features using parallel multicore strategy. Default is
  `FALSE`

- `parallel_handler`:

  Handler function to parallelize the code. eg mclapply

- `cl`:

  optional cluster object for parallel cluster approaches using eg.
  [`parallel::makeCluster`](https://rdrr.io/r/parallel/makeCluster.html)

- `typeName`:

  the name of the feature type

#### Returns

features as object of class `sf`

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WFSFeatureType$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
