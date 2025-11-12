# OWSNamespace

OWSNamespace

OWSNamespace

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling an OWS Namespace

## Note

class used internally by ows4R for specifying XML namespaces

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Public fields

- `id`:

  namespace id

- `uri`:

  namespace uri

## Methods

### Public methods

- [`OWSNamespace$new()`](#method-OWSNamespace-new)

- [`OWSNamespace$getDefinition()`](#method-OWSNamespace-getDefinition)

- [`OWSNamespace$clone()`](#method-OWSNamespace-clone)

------------------------------------------------------------------------

### Method `new()`

Initializes an OWSNamespace

#### Usage

    OWSNamespace$new(id, uri)

#### Arguments

- `id`:

  id

- `uri`:

  uri

------------------------------------------------------------------------

### Method `getDefinition()`

Get namespace definition

#### Usage

    OWSNamespace$getDefinition()

#### Returns

a named `list` with id and uri

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    OWSNamespace$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
