# registerOWSNamespace

`registerOWSNamespace` allows to register a new namespace in ows4R

## Usage

``` r
registerOWSNamespace(id, uri, force)
```

## Arguments

- id:

  prefix of the namespace

- uri:

  URI of the namespace

- force:

  logical parameter indicating if registration has be to be forced in
  case the identified namespace is already registered

## Author

Emmanuel Blondel, <emmanuel.blondel1@gmail.com>

## Examples

``` r
            
  registerOWSNamespace(id = "myprefix", uri = "http://someuri")
```
