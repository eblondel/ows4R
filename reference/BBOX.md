# BBOX

BBOX

BBOX

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling an BBOX

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\>
[`ows4R::OGCExpression`](https://eblondel.github.io/ows4R/reference/OGCExpression.md)
-\> `BBOX`

## Public fields

- `PropertyName`:

  property name field for XML encoding

- `Envelope`:

  envelope as object of class
  [GMLEnvelope](https://rdrr.io/pkg/geometa/man/GMLEnvelope.html) from
  geometa

## Methods

### Public methods

- [`BBOX$new()`](#method-BBOX-new)

- [`BBOX$clone()`](#method-BBOX-clone)

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
- [`ows4R::OGCExpression$getExprVersion()`](https://eblondel.github.io/ows4R/reference/OGCExpression.html#method-getExprVersion)
- [`ows4R::OGCExpression$setExprVersion()`](https://eblondel.github.io/ows4R/reference/OGCExpression.html#method-setExprVersion)

------------------------------------------------------------------------

### Method `new()`

Initializes a BBOX expression

#### Usage

    BBOX$new(bbox, srsName = NULL)

#### Arguments

- `bbox`:

  an object of class `matrix`

- `srsName`:

  srs name

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    BBOX$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
  bbox <- OWSUtils$toBBOX(-180,-90,180,90)
  expr <- BBOX$new(bbox)
  expr_xml <- expr$encode() #see how it looks like in XML
#> [geometa][WARN] Element '{http://www.opengis.net/gml}Envelope': No matching global declaration available for the validation root at line 1. 
#> [geometa][WARN] Object 'GMLEnvelope' is INVALID according to ISO 19139 XML schemas! 
  
```
