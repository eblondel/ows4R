# PropertyIsBetween

PropertyIsBetween

PropertyIsBetween

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling an PropertyIsBetween

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\>
[`ows4R::OGCExpression`](https://eblondel.github.io/ows4R/reference/OGCExpression.md)
-\> `PropertyIsBetween`

## Public fields

- `PropertyName`:

  property name field for XML encoding

- `lower`:

  lower value

- `upper`:

  upper value

## Methods

### Public methods

- [`PropertyIsBetween$new()`](#method-PropertyIsBetween-new)

- [`PropertyIsBetween$clone()`](#method-PropertyIsBetween-clone)

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

Initializes an object extending
[PropertyIsLike](https://eblondel.github.io/ows4R/reference/PropertyIsLike.md)

#### Usage

    PropertyIsBetween$new(PropertyName, lower, upper)

#### Arguments

- `PropertyName`:

  property name

- `lower`:

  lower value

- `upper`:

  upper value

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    PropertyIsBetween$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
  expr <- PropertyIsBetween$new(PropertyName = "property", lower = 1, upper = 10)
  expr_xml <- expr$encode() #see how it looks like in XML
  
```
