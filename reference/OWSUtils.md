# OWSUtils

OWSUtils

## Usage

``` r
OWSUtils
```

## Format

[`R6Class`](https://r6.r-lib.org/reference/R6Class.html) object.

## Value

set of OWS Utilities

## Static methods

- `getNamespaces()`:

  Get the namespaces associated to a given XML object

- `findNamespace(namespaces, id, uri)`:

  Finds a namespace by id or by URI

- `toBBOX(xmin, xmax, ymin, ymax)`:

  Creates a bbox matrix from min/max x/y coordinates

- `findP4s(srsName, morphToESRI)`:

  Finds the PROJ4 string definition for a given srsName

- `toCRS(srsName)`:

  Converts a srsName into a CRS object

- `toEPSG(crs)`:

  Get the EPSG code from a CRS object

- `getAspectRatio(bbox)`:

  Get the aspect ratio for a given bbox

## Author

Emmanuel Blondel \<emmanuel.blondel1@gmail.com\>

## Examples

``` r
  #toBBOX
  bbox <- OWSUtils$toBBOX(-180,-90,180,90)
  
  #toCRS
  crs <- OWSUtils$toCRS("EPSG:4326")
```
