# OGCAbstractObject

OGCAbstractObject

OGCAbstractObject

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) for
modelling an OGCAbstractObject

## Note

abstract class used by ows4R

From 2025-05-02, the INSPIRE metadata validation does not require
anymore an API Key. Therefore, it is not required to specify an
`geometa_inspireValidator`. To send your metadata to INSPIRE, just set
`geometa_inspire` to `TRUE`.

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Public fields

- `verbose.info`:

  `logical` property to indicate whether INFO logs have to be displayed

- `verbose.debug`:

  `logical` property to indicate whether DEBUG logs have to be displayed

- `loggerType`:

  logger type, either `NULL`, "INFO", or "DEBUG"

- `wrap`:

  internal property for XML encoding

- `element`:

  element used for XML encoding

- `namespace`:

  namespace used for XML encoding

- `defaults`:

  default values to be used for XML encoding

- `attrs`:

  attributes to be used for XML encoding

## Methods

### Public methods

- [`OGCAbstractObject$logger()`](#method-OGCAbstractObject-logger)

- [`OGCAbstractObject$INFO()`](#method-OGCAbstractObject-INFO)

- [`OGCAbstractObject$WARN()`](#method-OGCAbstractObject-WARN)

- [`OGCAbstractObject$ERROR()`](#method-OGCAbstractObject-ERROR)

- [`OGCAbstractObject$new()`](#method-OGCAbstractObject-new)

- [`OGCAbstractObject$getClassName()`](#method-OGCAbstractObject-getClassName)

- [`OGCAbstractObject$getClass()`](#method-OGCAbstractObject-getClass)

- [`OGCAbstractObject$isFieldInheritedFrom()`](#method-OGCAbstractObject-isFieldInheritedFrom)

- [`OGCAbstractObject$getNamespaceDefinition()`](#method-OGCAbstractObject-getNamespaceDefinition)

- [`OGCAbstractObject$encode()`](#method-OGCAbstractObject-encode)

- [`OGCAbstractObject$print()`](#method-OGCAbstractObject-print)

- [`OGCAbstractObject$clone()`](#method-OGCAbstractObject-clone)

------------------------------------------------------------------------

### Method `logger()`

A basic logger function

#### Usage

    OGCAbstractObject$logger(type, text)

#### Arguments

- `type`:

  type of logs message.

- `text`:

  log message text to be displayed

------------------------------------------------------------------------

### Method `INFO()`

a basic INFO logger function

#### Usage

    OGCAbstractObject$INFO(text)

#### Arguments

- `text`:

  log message text to be displayed

------------------------------------------------------------------------

### Method `WARN()`

a basic WARN logger function

#### Usage

    OGCAbstractObject$WARN(text)

#### Arguments

- `text`:

  log message text to be displayed

------------------------------------------------------------------------

### Method `ERROR()`

a basic ERROR logger function

#### Usage

    OGCAbstractObject$ERROR(text)

#### Arguments

- `text`:

  log message text to be displayed

------------------------------------------------------------------------

### Method `new()`

Initializes an object extending OGCAbstractObject

#### Usage

    OGCAbstractObject$new(
      xml = NULL,
      element = NULL,
      namespacePrefix = NULL,
      attrs = list(),
      defaults = list(),
      wrap = FALSE,
      logger = NULL
    )

#### Arguments

- `xml`:

  object of class
  [XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
  from XML

- `element`:

  element name

- `namespacePrefix`:

  namespace prefix for XML encoding

- `attrs`:

  list of attributes

- `defaults`:

  list of default values

- `wrap`:

  whether XML element has to be wrapped during XML encoding

- `logger`:

  logger

------------------------------------------------------------------------

### Method `getClassName()`

Get class name

#### Usage

    OGCAbstractObject$getClassName()

#### Returns

an object of class `character`

------------------------------------------------------------------------

### Method `getClass()`

Get class

#### Usage

    OGCAbstractObject$getClass()

#### Returns

an object of class `R6Class`

------------------------------------------------------------------------

### Method `isFieldInheritedFrom()`

Utility to return the parent class in which field is defined

#### Usage

    OGCAbstractObject$isFieldInheritedFrom(field)

#### Arguments

- `field`:

  field name

#### Returns

object of class `R6Class`

------------------------------------------------------------------------

### Method `getNamespaceDefinition()`

Gets the namespace definition

#### Usage

    OGCAbstractObject$getNamespaceDefinition(recursive = FALSE)

#### Arguments

- `recursive`:

  Get all namespace recursively

#### Returns

the namespace definitions as named `list`

------------------------------------------------------------------------

### Method `encode()`

Encodes as XML. The `addNS` . Extra parameters related to geometa
objects: `geometa_validate` (TRUE by default) and `geometa_inspire`
(FALSE by default) can be used to perform ISO and INSPIRE validation
respectively.

#### Usage

    OGCAbstractObject$encode(
      addNS = TRUE,
      geometa_validate = TRUE,
      geometa_inspire = FALSE,
      geometa_inspireValidator = NULL
    )

#### Arguments

- `addNS`:

  addNS controls the addition of XML namespaces

- `geometa_validate`:

  Relates to geometa object ISO validation. Default is `TRUE`

- `geometa_inspire`:

  Relates to geometa object INSPIRE validation. Default is `FALSE`

- `geometa_inspireValidator`:

  Relates to geometa object INSPIRE validation. Default is `NULL`.
  Deprecated, see below note.

#### Returns

an object of class
[XMLInternalNode-class](https://rdrr.io/pkg/XML/man/XMLNode-class.html)
from XML

------------------------------------------------------------------------

### Method [`print()`](https://rdrr.io/r/base/print.html)

Provides a custom print output (as tree) of the current class

#### Usage

    OGCAbstractObject$print(..., depth = 1)

#### Arguments

- `...`:

  args

- `depth`:

  class nesting depth

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    OGCAbstractObject$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
