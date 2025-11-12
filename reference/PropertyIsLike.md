# PropertyIsLike

PropertyIsLike

PropertyIsLike

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling an PropertyIsLike

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\>
[`ows4R::OGCExpression`](https://eblondel.github.io/ows4R/reference/OGCExpression.md)
-\> `PropertyIsLike`

## Public fields

- `PropertyName`:

  property name field for XML encoding

- `Literal`:

  literal field for XML encoding

- `attrs`:

  attributes for XML encoding

## Methods

### Public methods

- [`PropertyIsLike$new()`](#method-PropertyIsLike-new)

- [`PropertyIsLike$clone()`](#method-PropertyIsLike-clone)

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

Initializes an object extending PropertyIsLike

#### Usage

    PropertyIsLike$new(
      PropertyName,
      Literal,
      escapeChar = "\\",
      singleChar = "_",
      wildCard = "%",
      matchCase = NA
    )

#### Arguments

- `PropertyName`:

  property name

- `Literal`:

  literal

- `escapeChar`:

  escape character. Default is "\\

- `singleChar`:

  single character. Default is "\_"

- `wildCard`:

  wildcard

- `matchCase`:

  match case

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    PropertyIsLike$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
  expr <- PropertyIsLike$new(PropertyName = "property", Literal = "value")
  expr_xml <- expr$encode() #see how it looks like in XML
  
```
