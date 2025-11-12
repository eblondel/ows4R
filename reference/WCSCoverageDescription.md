# WCSCoverageDescription

WCSCoverageDescription

WCSCoverageDescription

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html)
modelling a WCS coverage summary

## Note

Class used internally by ows4R.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Super classes

[`geometa::geometaLogger`](https://rdrr.io/pkg/geometa/man/geometaLogger.html)
-\>
[`geometa::ISOAbstractObject`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html)
-\>
[`geometa::GMLAbstractObject`](https://rdrr.io/pkg/geometa/man/GMLAbstractObject.html)
-\>
[`geometa::GMLAbstractFeature`](https://rdrr.io/pkg/geometa/man/GMLAbstractFeature.html)
-\>
[`geometa::GMLAbstractCoverage`](https://rdrr.io/pkg/geometa/man/GMLAbstractCoverage.html)
-\>
[`geometa::GMLCOVAbstractCoverage`](https://rdrr.io/pkg/geometa/man/GMLCOVAbstractCoverage.html)
-\> `WCSCoverageDescription`

## Public fields

- `CoverageId`:

  coverage ID

- `SupportedCRS`:

  supported CRS

- `SupportedFormat`:

  supported Format

- `Domain`:

  domain

- `Range`:

  range

- `ServiceParameters`:

  service parmaeters

## Methods

### Public methods

- [`WCSCoverageDescription$new()`](#method-WCSCoverageDescription-new)

- [`WCSCoverageDescription$getId()`](#method-WCSCoverageDescription-getId)

- [`WCSCoverageDescription$getSupportedCRS()`](#method-WCSCoverageDescription-getSupportedCRS)

- [`WCSCoverageDescription$getSupportedFormats()`](#method-WCSCoverageDescription-getSupportedFormats)

- [`WCSCoverageDescription$getDomain()`](#method-WCSCoverageDescription-getDomain)

- [`WCSCoverageDescription$getRange()`](#method-WCSCoverageDescription-getRange)

- [`WCSCoverageDescription$clone()`](#method-WCSCoverageDescription-clone)

Inherited methods

- [`geometa::geometaLogger$ERROR()`](https://rdrr.io/pkg/geometa/man/geometaLogger.html#method-ERROR)
- [`geometa::geometaLogger$INFO()`](https://rdrr.io/pkg/geometa/man/geometaLogger.html#method-INFO)
- [`geometa::geometaLogger$WARN()`](https://rdrr.io/pkg/geometa/man/geometaLogger.html#method-WARN)
- [`geometa::ISOAbstractObject$addFieldAttrs()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-addFieldAttrs)
- [`geometa::ISOAbstractObject$addListElement()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-addListElement)
- [`geometa::ISOAbstractObject$checkMetadataStandardCompliance()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-checkMetadataStandardCompliance)
- [`geometa::ISOAbstractObject$contains()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-contains)
- [`geometa::ISOAbstractObject$createLocalisedProperty()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-createLocalisedProperty)
- [`geometa::ISOAbstractObject$decode()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-decode)
- [`geometa::ISOAbstractObject$delListElement()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-delListElement)
- [`geometa::ISOAbstractObject$encode()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-encode)
- [`geometa::ISOAbstractObject$getClass()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-getClass)
- [`geometa::ISOAbstractObject$getClassName()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-getClassName)
- [`geometa::ISOAbstractObject$getNamespaceDefinition()`](https://rdrr.io/pkg/geometa/man/ISOAbstractObject.html#method-getNamespaceDefinition)
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
- [`geometa::GMLAbstractFeature$setBoundedBy()`](https://rdrr.io/pkg/geometa/man/GMLAbstractFeature.html#method-setBoundedBy)
- [`geometa::GMLAbstractCoverage$setDomainSet()`](https://rdrr.io/pkg/geometa/man/GMLAbstractCoverage.html#method-setDomainSet)
- [`geometa::GMLAbstractCoverage$setRangeSet()`](https://rdrr.io/pkg/geometa/man/GMLAbstractCoverage.html#method-setRangeSet)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class WCSCoverageDescription

#### Usage

    WCSCoverageDescription$new(xmlObj, serviceVersion, owsVersion, logger = NULL)

#### Arguments

- `xmlObj`:

  an object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  to initialize from XML

- `serviceVersion`:

  service version

- `owsVersion`:

  OWS version

- `logger`:

  logger

------------------------------------------------------------------------

### Method `getId()`

getId

#### Usage

    WCSCoverageDescription$getId()

#### Returns

the coverage id, object of class `character`

------------------------------------------------------------------------

### Method `getSupportedCRS()`

getSupported CRS. Applies to WCS 1 coverage descriptions

#### Usage

    WCSCoverageDescription$getSupportedCRS()

------------------------------------------------------------------------

### Method `getSupportedFormats()`

get supported formats. Applies to WCS 1 coverage descriptions

#### Usage

    WCSCoverageDescription$getSupportedFormats()

------------------------------------------------------------------------

### Method `getDomain()`

get domain. Applies to WCS 1 coverage descriptions

#### Usage

    WCSCoverageDescription$getDomain()

------------------------------------------------------------------------

### Method `getRange()`

get range. Applies to WCS 1.0 coverage descriptions

#### Usage

    WCSCoverageDescription$getRange()

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    WCSCoverageDescription$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
