# WCSGSTimeDomain

WCSGSTimeDomain

WCSGSTimeDomain

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html)
modelling a WCS geoserver time domain object

## Note

Experimental

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`geometa::geometaLogger`](https://rdrr.io/pkg/geometa/man/geometaLogger.html)
-\>
[`geometa::ISOAbstractObject`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html)
-\> `WCSGSTimeDomain`

## Public fields

- `TimeInstant`:

  time instants

## Methods

### Public methods

- [`WCSGSTimeDomain$decode()`](#method-WCSGSTimeDomain-decode)

- [`WCSGSTimeDomain$clone()`](#method-WCSGSTimeDomain-clone)

Inherited methods

- [`geometa::geometaLogger$ERROR()`](https://rdrr.io/pkg/geometa/man/geometaLogger.html#method-ERROR)
- [`geometa::geometaLogger$INFO()`](https://rdrr.io/pkg/geometa/man/geometaLogger.html#method-INFO)
- [`geometa::geometaLogger$WARN()`](https://rdrr.io/pkg/geometa/man/geometaLogger.html#method-WARN)
- [`geometa::ISOAbstractObject$addFieldAttrs()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-addFieldAttrs)
- [`geometa::ISOAbstractObject$addListElement()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-addListElement)
- [`geometa::ISOAbstractObject$checkMetadataStandardCompliance()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-checkMetadataStandardCompliance)
- [`geometa::ISOAbstractObject$contains()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-contains)
- [`geometa::ISOAbstractObject$createLocalisedProperty()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-createLocalisedProperty)
- [`geometa::ISOAbstractObject$delListElement()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-delListElement)
- [`geometa::ISOAbstractObject$encode()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-encode)
- [`geometa::ISOAbstractObject$getClass()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-getClass)
- [`geometa::ISOAbstractObject$getClassName()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-getClassName)
- [`geometa::ISOAbstractObject$getNamespaceDefinition()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-getNamespaceDefinition)
- [`geometa::ISOAbstractObject$initialize()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-initialize)
- [`geometa::ISOAbstractObject$isDocument()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-isDocument)
- [`geometa::ISOAbstractObject$isFieldInheritedFrom()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-isFieldInheritedFrom)
- [`geometa::ISOAbstractObject$print()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-print)
- [`geometa::ISOAbstractObject$save()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-save)
- [`geometa::ISOAbstractObject$setAttr()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-setAttr)
- [`geometa::ISOAbstractObject$setCodeList()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-setCodeList)
- [`geometa::ISOAbstractObject$setCodeListValue()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-setCodeListValue)
- [`geometa::ISOAbstractObject$setCodeSpace()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-setCodeSpace)
- [`geometa::ISOAbstractObject$setHref()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-setHref)
- [`geometa::ISOAbstractObject$setId()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-setId)
- [`geometa::ISOAbstractObject$setIsNull()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-setIsNull)
- [`geometa::ISOAbstractObject$setValue()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-setValue)
- [`geometa::ISOAbstractObject$stopIfMetadataStandardIsNot()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-stopIfMetadataStandardIsNot)
- [`geometa::ISOAbstractObject$validate()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-validate)
- [`geometa::ISOAbstractObject$wrapBaseElement()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-wrapBaseElement)

------------------------------------------------------------------------

### Method `decode()`

Decodes from XML

#### Usage

    WCSGSTimeDomain$decode(xml)

#### Arguments

- `xml`:

  object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WCSGSTimeDomain$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
