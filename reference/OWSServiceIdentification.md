# OWSServiceIdentification

OWSServiceIdentification

OWSServiceIdentification

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling an OGC Service Identification

## Note

Abstract class used internally by ows4R

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Methods

### Public methods

- [`OWSServiceIdentification$new()`](#method-OWSServiceIdentification-new)

- [`OWSServiceIdentification$getName()`](#method-OWSServiceIdentification-getName)

- [`OWSServiceIdentification$getTitle()`](#method-OWSServiceIdentification-getTitle)

- [`OWSServiceIdentification$getAbstract()`](#method-OWSServiceIdentification-getAbstract)

- [`OWSServiceIdentification$getKeywords()`](#method-OWSServiceIdentification-getKeywords)

- [`OWSServiceIdentification$getOnlineResource()`](#method-OWSServiceIdentification-getOnlineResource)

- [`OWSServiceIdentification$getServiceType()`](#method-OWSServiceIdentification-getServiceType)

- [`OWSServiceIdentification$getServiceTypeVersion()`](#method-OWSServiceIdentification-getServiceTypeVersion)

- [`OWSServiceIdentification$getFees()`](#method-OWSServiceIdentification-getFees)

- [`OWSServiceIdentification$getAccessConstraints()`](#method-OWSServiceIdentification-getAccessConstraints)

- [`OWSServiceIdentification$clone()`](#method-OWSServiceIdentification-clone)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class OWSServiceIdentification

#### Usage

    OWSServiceIdentification$new(xmlObj, owsVersion, serviceVersion)

#### Arguments

- `xmlObj`:

  object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

- `owsVersion`:

  OWS version

- `serviceVersion`:

  service version

------------------------------------------------------------------------

### Method `getName()`

Get service identification - name

#### Usage

    OWSServiceIdentification$getName()

#### Returns

the name, object of class `character`

------------------------------------------------------------------------

### Method `getTitle()`

Get service identification - title

#### Usage

    OWSServiceIdentification$getTitle()

#### Returns

the title, object of class `character`

------------------------------------------------------------------------

### Method `getAbstract()`

Get service identification - abstract

#### Usage

    OWSServiceIdentification$getAbstract()

#### Returns

the abstract, object of class `character`

------------------------------------------------------------------------

### Method `getKeywords()`

Get service identification - keywords

#### Usage

    OWSServiceIdentification$getKeywords()

#### Returns

the keywords, object of class `character`

------------------------------------------------------------------------

### Method `getOnlineResource()`

Get service identification - online resource

#### Usage

    OWSServiceIdentification$getOnlineResource()

#### Returns

the online resource, object of class `character`

------------------------------------------------------------------------

### Method `getServiceType()`

Get service identification - service type

#### Usage

    OWSServiceIdentification$getServiceType()

#### Returns

the service type, object of class `character`

------------------------------------------------------------------------

### Method `getServiceTypeVersion()`

Get service identification - service type version

#### Usage

    OWSServiceIdentification$getServiceTypeVersion()

#### Returns

the service type version, object of class `character`

------------------------------------------------------------------------

### Method `getFees()`

Get service identification - fees

#### Usage

    OWSServiceIdentification$getFees()

#### Returns

the fees, object of class `character`

------------------------------------------------------------------------

### Method `getAccessConstraints()`

Get service identification - access constraints

#### Usage

    OWSServiceIdentification$getAccessConstraints()

#### Returns

the access constraints, object of class `character`

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    OWSServiceIdentification$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
