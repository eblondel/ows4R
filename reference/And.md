# And

And

And

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling an And operator

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\>
[`ows4R::OGCExpression`](https://eblondel.github.io/ows4R/reference/OGCExpression.md)
-\>
[`ows4R::BinaryLogicOpType`](https://eblondel.github.io/ows4R/reference/BinaryLogicOpType.md)
-\> `And`

## Methods

### Public methods

- [`And$new()`](#method-And-new)

- [`And$clone()`](#method-And-clone)

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
- [`ows4R::BinaryLogicOpType$setExprVersion()`](https://eblondel.github.io/ows4R/reference/BinaryLogicOpType.html#method-setExprVersion)

------------------------------------------------------------------------

### Method `new()`

Initializes an And expression

#### Usage

    And$new(...)

#### Arguments

- `...`:

  list of objects of class
  [OGCExpression](https://eblondel.github.io/ows4R/reference/OGCExpression.md)

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    And$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
  expr1 <- PropertyIsEqualTo$new(PropertyName = "property1", Literal = "value1")
  expr2 <- PropertyIsEqualTo$new(PropertyName = "property2", Literal = "value2")
  and <- And$new(expr1,expr2)
  and_xml <- and$encode() #see how it looks like in XML
```
