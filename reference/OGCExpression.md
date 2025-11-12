# OGCExpression

OGCExpression

OGCExpression

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling an OGC Expression

## Note

abstract class

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `OGCExpression`

## Methods

### Public methods

- [`OGCExpression$new()`](#method-OGCExpression-new)

- [`OGCExpression$setExprVersion()`](#method-OGCExpression-setExprVersion)

- [`OGCExpression$getExprVersion()`](#method-OGCExpression-getExprVersion)

- [`OGCExpression$clone()`](#method-OGCExpression-clone)

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

Initializes an object of class OGCExpression

#### Usage

    OGCExpression$new(
      element,
      namespacePrefix,
      attrs = NULL,
      defaults = NULL,
      exprVersion = "1.1.0"
    )

#### Arguments

- `element`:

  element name

- `namespacePrefix`:

  XML namespace prefix

- `attrs`:

  attributes

- `defaults`:

  default values

- `exprVersion`:

  OGC version for the expression

------------------------------------------------------------------------

### Method `setExprVersion()`

Sets expression version. The methods will control proper XML namespace
prefix setting

#### Usage

    OGCExpression$setExprVersion(exprVersion)

#### Arguments

- `exprVersion`:

  OGC expression version

------------------------------------------------------------------------

### Method `getExprVersion()`

Gets expression version

#### Usage

    OGCExpression$getExprVersion()

#### Returns

object of class `character`

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    OGCExpression$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
