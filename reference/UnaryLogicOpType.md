# UnaryLogicOpType

UnaryLogicOpType

UnaryLogicOpType

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling an UnaryLogicOpType

## Note

abstract super class of all the unary logical operation classes

## Super classes

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\>
[`ows4R::OGCExpression`](https://eblondel.github.io/ows4R/reference/OGCExpression.md)
-\> `UnaryLogicOpType`

## Public fields

- `operations`:

  a list OGC expressions

## Methods

### Public methods

- [`UnaryLogicOpType$new()`](#method-UnaryLogicOpType-new)

- [`UnaryLogicOpType$setExprVersion()`](#method-UnaryLogicOpType-setExprVersion)

- [`UnaryLogicOpType$clone()`](#method-UnaryLogicOpType-clone)

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

------------------------------------------------------------------------

### Method `new()`

Initializes a UnaryLogicOpType expression

#### Usage

    UnaryLogicOpType$new(..., element, namespacePrefix, exprVersion = "1.1.0")

#### Arguments

- `...`:

  list of objects of class
  [OGCExpression](https://eblondel.github.io/ows4R/reference/OGCExpression.md)

- `element`:

  element

- `namespacePrefix`:

  namespacePrefix

- `exprVersion`:

  OGC expression version. Default is "1.1.0"

------------------------------------------------------------------------

### Method `setExprVersion()`

Sets expression version. The methods will control that expression
versions are set for each of the operations specified in the expression.

#### Usage

    UnaryLogicOpType$setExprVersion(exprVersion)

#### Arguments

- `exprVersion`:

  OGC expression version

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    UnaryLogicOpType$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
