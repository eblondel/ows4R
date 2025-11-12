# CASClient

CASClient

CASClient

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

Object of [`R6Class`](https://r6.r-lib.org/reference/R6Class.html) with
methods for interfacing a Central Authentication Service (CAS).

## Note

Class used internally by ows4R

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Methods

### Public methods

- [`CASClient$new()`](#method-CASClient-new)

- [`CASClient$getUrl()`](#method-CASClient-getUrl)

- [`CASClient$login()`](#method-CASClient-login)

- [`CASClient$logout()`](#method-CASClient-logout)

- [`CASClient$clone()`](#method-CASClient-clone)

------------------------------------------------------------------------

### Method `new()`

Initializes an object of class CASClient

#### Usage

    CASClient$new(url)

#### Arguments

- `url`:

  base URL of the Central Authentication Service (CAS)

------------------------------------------------------------------------

### Method `getUrl()`

Get CAS base URL

#### Usage

    CASClient$getUrl()

#### Returns

the base URL

------------------------------------------------------------------------

### Method `login()`

Logs in the CAS

#### Usage

    CASClient$login(user, pwd)

#### Arguments

- `user`:

  user

- `pwd`:

  password

#### Returns

`TRUE` if logged in, `FALSE` otherwise

------------------------------------------------------------------------

### Method `logout()`

Logs out from the CAS

#### Usage

    CASClient$logout()

#### Returns

`TRUE` if logged out, `FALSE` otherwise

------------------------------------------------------------------------

### Method `clone()`

The objects of this class are cloneable with this method.

#### Usage

    CASClient$clone(deep = FALSE)

#### Arguments

- `deep`:

  Whether to make a deep clone.
