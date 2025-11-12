# WFSFeatureTypeElement

WFSFeatureTypeElement

WFSFeatureTypeElement

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html)
modelling a WFS feature type element

## Note

Abstract class used by ows4R

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super class

[`ows4R::OGCAbstractObject`](https://eblondel.github.io/ows4R/reference/OGCAbstractObject.md)
-\> `WFSFeatureTypeElement`

## Public fields

- `minOccurs`:

  minOccurs

- `maxOccurs`:

  maxOccurs

- `nillable`:

  nillable

- `name`:

  name

- `type`:

  type

- `geometry`:

  geometry

## Methods

### Public methods

- [`WFSFeatureTypeElement$new()`](#method-WFSFeatureTypeElement-new)

- [`WFSFeatureTypeElement$getMinOccurs()`](#method-WFSFeatureTypeElement-getMinOccurs)

- [`WFSFeatureTypeElement$getMaxOccurs()`](#method-WFSFeatureTypeElement-getMaxOccurs)

- [`WFSFeatureTypeElement$isNillable()`](#method-WFSFeatureTypeElement-isNillable)

- [`WFSFeatureTypeElement$getName()`](#method-WFSFeatureTypeElement-getName)

- [`WFSFeatureTypeElement$getType()`](#method-WFSFeatureTypeElement-getType)

- [`WFSFeatureTypeElement$isGeometry()`](#method-WFSFeatureTypeElement-isGeometry)

- [`WFSFeatureTypeElement$clone()`](#method-WFSFeatureTypeElement-clone)

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

Initializes a WFSFeatureTypeElement

#### Usage

    WFSFeatureTypeElement$new(xmlObj, namespaces)

#### Arguments

- `xmlObj`:

  object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

- `namespaces`:

  namespaces definitions inherited from parent XML, as `data.frame`

------------------------------------------------------------------------

### Method `getMinOccurs()`

get min occurs

#### Usage

    WFSFeatureTypeElement$getMinOccurs()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `getMaxOccurs()`

get max occurs

#### Usage

    WFSFeatureTypeElement$getMaxOccurs()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `isNillable()`

get if nillable

#### Usage

    WFSFeatureTypeElement$isNillable()

#### Returns

an object of class `logical`

------------------------------------------------------------------------

### Method `getName()`

get name

#### Usage

    WFSFeatureTypeElement$getName()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `getType()`

get type

#### Usage

    WFSFeatureTypeElement$getType()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `isGeometry()`

Is geometry

#### Usage

    WFSFeatureTypeElement$isGeometry()

#### Arguments

- `return`:

  object of class `logical`

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WFSFeatureTypeElement$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
