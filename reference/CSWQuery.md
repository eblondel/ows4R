# CSWQuery

CSWQuery

CSWQuery

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling an CSW Query

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `CSWQuery`

## Public fields

- `ElementSetName`:

  element set name property for request XML encoding

- `constraint`:

  property for request XML encoding

## Methods

### Public methods

- [`CSWQuery$new()`](#method-CSWQuery-new)

- [`CSWQuery$setServiceVersion()`](#method-CSWQuery-setServiceVersion)

- [`CSWQuery$clone()`](#method-CSWQuery-clone)

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

This method is used to instantiate an CSWQUery object. The
`elementSetName` can be either "full" (default), "brief" or "summary". A
constraint `CSWConstraint` can be defined for the query. The `typeNames`
indicates to query (default "csw:Record"). The `serviceVersion` gives
the CSW service version (default "2.0.2")

#### Usage

    CSWQuery$new(
      elementSetName = "full",
      constraint = NULL,
      typeNames = "csw:Record",
      serviceVersion = "2.0.2"
    )

#### Arguments

- `elementSetName`:

  element set name. Default is "full"

- `constraint`:

  object of class
  [CSWConstraint](https://eblondel.github.io/ows4R/reference/CSWConstraint.md)

- `typeNames`:

  type names

- `serviceVersion`:

  CSW service version

------------------------------------------------------------------------

### Method `setServiceVersion()`

Set service version. The methods ensures propery naming of typeNames
depending on the service version

#### Usage

    CSWQuery$setServiceVersion(serviceVersion)

#### Arguments

- `serviceVersion`:

  service version

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    CSWQuery$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.

## Examples

``` r
  #CSWQuery - elementSetName
  query_full <- CSWQuery$new()
  query_brief <- CSWQuery$new(elementSetName = "brief")
  query_summary <- CSWQuery$new(elementSetName = "summary")
  
  #CSWQuery - cqlText with title
  cons <- CSWConstraint$new(cqlText = "dc:title like '%ips%'")
  query <- CSWQuery$new(constraint = cons)
  
  #CSW 2.0.2 - Query - Filter / AnyText
  filter <- OGCFilter$new( PropertyIsLike$new("csw:AnyText", "%Physio%"))
  cons <- CSWConstraint$new(filter = filter)
  query <- CSWQuery$new(constraint = cons)
  
  #CSW 2.0.2 - Query - Filter / AnyText Equal
  filter <- OGCFilter$new( PropertyIsEqualTo$new("csw:AnyText", "species"))
  cons <- CSWConstraint$new(filter = filter)
  query <- CSWQuery$new(constraint = cons)
  
  #CSW 2.0.2 - Query - Filter / AnyText And Not
  filter <- OGCFilter$new(And$new(
    PropertyIsLike$new("csw:AnyText", "%lorem%"),
    PropertyIsLike$new("csw:AnyText", "%ipsum%"),
    Not$new(
      PropertyIsLike$new("csw:AnyText", "%dolor%")
    )
  ))
  cons <- CSWConstraint$new(filter = filter)
  query <- CSWQuery$new(constraint = cons)
 
  #CSW 2.0.2 - Query - Filter / AnyText And nested Or
  filter <- OGCFilter$new(And$new(
    PropertyIsEqualTo$new("dc:title", "Aliquam fermentum purus quis arcu"),
    PropertyIsEqualTo$new("dc:format", "application/pdf"),
    Or$new(
      PropertyIsEqualTo$new("dc:type", "http://purl.org/dc/dcmitype/Dataset"),
      PropertyIsEqualTo$new("dc:type", "http://purl.org/dc/dcmitype/Service"),
      PropertyIsEqualTo$new("dc:type", "http://purl.org/dc/dcmitype/Image"),
      PropertyIsEqualTo$new("dc:type", "http://purl.org/dc/dcmitype/Text")
    )
  ))
  cons <- CSWConstraint$new(filter = filter)
  query <- CSWQuery$new(elementSetName = "brief", constraint = cons)
  
  #CSW 2.0.2 - Query - Filter / BBOX
  bbox <- matrix(c(-180,180,-90,90), nrow = 2, ncol = 2, byrow = TRUE,
                 dimnames = list(c("x", "y"), c("min","max")))
  filter <- OGCFilter$new( BBOX$new(bbox = bbox) )
  cons <- CSWConstraint$new(filter = filter)
  query <- CSWQuery$new(elementSetName = "brief", constraint = cons)
  
```
