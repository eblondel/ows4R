# OWSServiceProvider

OWSServiceProvider

OWSServiceProvider

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling an OGC Service Provider

## Note

Abstract class used internally by ows4R

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Methods

### Public methods

- [`OWSServiceProvider$new()`](#method-OWSServiceProvider-new)

- [`OWSServiceProvider$getProviderName()`](#method-OWSServiceProvider-getProviderName)

- [`OWSServiceProvider$getProviderSite()`](#method-OWSServiceProvider-getProviderSite)

- [`OWSServiceProvider$getServiceContact()`](#method-OWSServiceProvider-getServiceContact)

- [`OWSServiceProvider$clone()`](#method-OWSServiceProvider-clone)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class OWSServiceProvider

#### Usage

    OWSServiceProvider$new(xmlObj, owsVersion, serviceVersion)

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

### Method `getProviderName()`

Get provider name

#### Usage

    OWSServiceProvider$getProviderName()

#### Arguments

- `the`:

  provider name, object of class `character`

------------------------------------------------------------------------

### Method `getProviderSite()`

Get provider site

#### Usage

    OWSServiceProvider$getProviderSite()

#### Arguments

- `the`:

  provider site, object of class `character`

------------------------------------------------------------------------

### Method `getServiceContact()`

Get provider contact

#### Usage

    OWSServiceProvider$getServiceContact()

#### Arguments

- `the`:

  provider contact, object of class
  [ISOResponsibleParty](https://rdrr.io/pkg/geometa/man/ISOResponsibleParty.html)
  from geometa

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    OWSServiceProvider$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
