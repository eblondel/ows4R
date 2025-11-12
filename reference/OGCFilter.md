# OGCFilter

OGCFilter

OGCFilter

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling an OGC Filter

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `OGCFilter`

## Public fields

- `expr`:

  OGC expression

## Methods

### Public methods

- [`OGCFilter$new()`](#method-OGCFilter-new)

- [`OGCFilter$setFilterVersion()`](#method-OGCFilter-setFilterVersion)

- [`OGCFilter$clone()`](#method-OGCFilter-clone)

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

Initializes an object of class OGCFilter.

#### Usage

    OGCFilter$new(expr, filterVersion = "1.1.0")

#### Arguments

- `expr`:

  object of class
  [OGCExpression](https://eblondel.github.io/ows4R/reference/OGCExpression.md)

- `filterVersion`:

  OGC filter version. Default is "1.1.0"

------------------------------------------------------------------------

### Method `setFilterVersion()`

Sets the OGC filter version

#### Usage

    OGCFilter$setFilterVersion(filterVersion)

#### Arguments

- `filterVersion`:

  OGC filter version

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    OGCFilter$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
  expr <- PropertyIsEqualTo$new(PropertyName = "property", Literal = "value")
  not <- Not$new(expr)
  not_xml <- not$encode() #see how it looks like in XML
```
