# CSWConstraint

CSWConstraint

CSWConstraint

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling an CSW Constraint

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `CSWConstraint`

## Public fields

- `wrap`:

  internal property for object XML encoding

- `CqlText`:

  text to use as CQL filter

- `filter`:

## Methods

### Public methods

- [`CSWConstraint$new()`](#method-CSWConstraint-new)

- [`CSWConstraint$setServiceVersion()`](#method-CSWConstraint-setServiceVersion)

- [`CSWConstraint$clone()`](#method-CSWConstraint-clone)

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

Initializes a CSWConstraint object to be used to constrain CSW
operations.

#### Usage

    CSWConstraint$new(cqlText = NULL, filter = NULL, serviceVersion = "2.0.2")

#### Arguments

- `cqlText`:

  cqlText, object of class `character`

- `filter`:

  filter, object extending
  [OGCFilter](https://eblondel.github.io/ows4R/reference/OGCFilter.md)

- `serviceVersion`:

  CSW service version. Default is "2.0.2"

------------------------------------------------------------------------

### Method `setServiceVersion()`

Set service version. This methods ensures that underlying filter
property is properly set with the right OGC filter version.

#### Usage

    CSWConstraint$setServiceVersion(serviceVersion)

#### Arguments

- `serviceVersion`:

  service version

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    CSWConstraint$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
  filter <- OGCFilter$new( PropertyIsEqualTo$new("apiso:Identifier", "12345") )
  cons <- CSWConstraint$new(filter = filter)
  cons_xml <- cons$encode() #how it looks like in XML
```
