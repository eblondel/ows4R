## [ows4R 0.4](https://github.com/eblondel/ows4R) | [![CRAN_Status_Badge](https://img.shields.io/badge/CRAN-unavailable-red.svg)](https://github.com/eblondel/ows4R)

**Corrections**

- [#111](https://github.com/eblondel/ows4R/pull/111) WCSCoverageSummary - Fix download failure due to min/max handling
- [#112](https://github.com/eblondel/ows4R/issues/112) OWSHttpRequest GET doesn't detect existing params and make GetCapabilities fail
- [#113](https://github.com/eblondel/ows4R/issues/113) WCSGetCoverage- Fix vendor params handling 
- [#119](https://github.com/eblondel/ows4R/issues/119) WCS Coverage descriptions - patch to rewrite CRS online resources to https
- [#120](https://github.com/eblondel/ows4R/issues/120) Service requests under CAS do not work anymore

**New features**

- [#116](https://github.com/eblondel/ows4R/issues/116) Support Service exceptions handling
- [#117](https://github.com/eblondel/ows4R/issues/117) Support pretty print of R6 objects

**Enhancements**

- [#122](https://github.com/eblondel/ows4R/issues/122) Service exceptions are not always handled in status code 400
- [#123](https://github.com/eblondel/ows4R/issues/123) Missing axis labels handling for WCS coverage envelope
- [#124](https://github.com/eblondel/ows4R/issues/124) Optimize WFS getFeatures depending on the outputFormat

## [ows4R 0.3-6](https://github.com/eblondel/ows4R) | [![CRAN_Status_Badge](https://img.shields.io/badge/CRAN-published-blue.svg)](https://github.com/eblondel/ows4R)

**Corrections**

- [#110](https://github.com/eblondel/ows4R/issues/110) 'hasGeometry' based on FeatureType description is not enough in case propertyNames is used with geom

**Enhancements**

- [#109](https://github.com/eblondel/ows4R/issues/109) Improve CSV support for WFS

## [ows4R 0.3-5](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.3-5.tar.gz) | [![CRAN_Status_Badge](https://img.shields.io/badge/CRAN-published-blue.svg)](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.3-5.tar.gz)

**Enhancements**

- [#106](https://github.com/eblondel/ows4R/issues/106) ows4R will switch off s2 by default (s2 is not ISO/OGC compliant)

## [ows4R 0.3-4](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.3-4.tar.gz) | [![CRAN_Status_Badge](https://img.shields.io/badge/CRAN-published-blue.svg)](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.3-4.tar.gz)

**Corrections**

- [#102](https://github.com/eblondel/ows4R/issues/102) OWSHttpRequest - issue with json format not handled as text

**Enhancements**

- [#101](https://github.com/eblondel/ows4R/issues/101) WFS - Ensure features CRS are inherited

## [ows4R 0.3-3](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.3-3.tar.gz) | [![CRAN_Status_Badge](https://img.shields.io/badge/CRAN-published-blue.svg)](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.3-3.tar.gz)

**Corrections**

- [#99](https://github.com/eblondel/ows4R/issues/99) CRS not inherited with WFS/GetFeatures

## [ows4R 0.3-2](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.3-2.tar.gz) | [![CRAN_Status_Badge](https://img.shields.io/badge/CRAN-published-blue.svg)](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.3-2.tar.gz)

**Corrections**

- [#89](https://github.com/eblondel/ows4R/commit/23f606c74da0f87f1043ffa8d5193dd634da4e37) Align WCS `getCoverage` arguments with wrapper
- [#91](https://github.com/eblondel/ows4R/issues/91) `getCoverage` needs to download in tempdir instead of current wd, when no filename is provider
- [#96](https://github.com/eblondel/ows4R/issues/96) summary$getDimensions() not returning coefficients anymore

**Enhancements**

- [#88](https://github.com/eblondel/ows4R/issues/88) `describeCoverage` & `getCoverage` not returning all rangeType info for multiband coverages (supported through [geometa#187](https://github.com/eblondel/geometa/issues/187) - OGC SWE support -  [geometa#197](https://github.com/eblondel/geometa/issues/197) enhancement)
- [#89](https://github.com/eblondel/ows4R/issues/89) Allow geometa classes inheritance using `ows4R::` (supported through [geometa#201](https://github.com/eblondel/geometa/issues/201) enhancement)

## [ows4R 0.3-1](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.3-1.tar.gz) | [![CRAN_Status_Badge](https://img.shields.io/badge/CRAN-published-blue.svg)](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.3-1.tar.gz)

**Corrections**

- [#87](https://github.com/eblondel/ows4R/issues/87) Upgrade roxygen2 7.2.1 to fix html issues

## [ows4R 0.3](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.3.tar.gz) | [![CRAN_Status_Badge](https://img.shields.io/badge/CRAN-published-blue.svg)](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.3.tar.gz)


**New features**

- [#9](https://github.com/eblondel/ows4R/issues/9) WCS client support
- [#58](https://github.com/eblondel/ows4R/issues/58) Implement 'exact' find method for WMS layers
- [#63](https://github.com/eblondel/ows4R/issues/63) CAS authentication client support
- [#64](https://github.com/eblondel/ows4R/issues/64) Support httr config argument for OGC service clients
- [#73](https://github.com/eblondel/ows4R/issues/73) Implement progress bar in OWS GET data requests
- [#74](https://github.com/eblondel/ows4R/issues/74) Get all styles of a WMS layer

**Enhancements**

- [#61](https://github.com/eblondel/ows4R/issues/61) Generalize auth-related arguments in OWS Http requests
- [#78](https://github.com/eblondel/ows4R/issues/78) Remove dependency with rgdal

**Corrections**

- [#56](https://github.com/eblondel/ows4R/issues/56) Duplicate feature with findFeatureTypeByName
- [#76](https://github.com/eblondel/ows4R/issues/76) WFS getFeatures with json and csv do not work - bad writer

## [ows4R 0.2](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.2.tar.gz) | [![CRAN_Status_Badge](https://img.shields.io/badge/CRAN-published-blue.svg)](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.2.tar.gz)

**Corrections**

- [#45](https://github.com/eblondel/ows4R/issues/45) WFS featureType getDescription fails as prettified when missing properties
- [#49](https://github.com/eblondel/ows4R/issues/49) OWS Capabilities components not correctly parsed when ref namespace is from service (eg. wms)

**Enhancements**

- [#41](https://github.com/eblondel/ows4R/issues/41) Add control on hasGeometry in case geom excluded from propertyNames
- [#42](https://github.com/eblondel/ows4R/issues/42) Support other WFS output formats than GML
- [#44](https://github.com/eblondel/ows4R/issues/44) Warning raised when reading WFS capabilities / proj4 with +init

**New features**

- [#10](https://github.com/eblondel/ows4R/issues/10) Support WPS client version 1.0.0
- [#15](https://github.com/eblondel/ows4R/issues/15) Generalize auth to clients/requests
- [#43](https://github.com/eblondel/ows4R/issues/43) Support WMS GetCapabilities, GetFeatureInfo requests

## [ows4R 0.1-5](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.1-5.tar.gz) | [![CRAN_Status_Badge](https://img.shields.io/badge/CRAN-published-blue.svg)](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.1-5.tar.gz)

**Enhancements**

* [#34](https://github.com/eblondel/ows4R/issues/34) WFS – Support coercing of date/datetime fields
* [#35](https://github.com/eblondel/ows4R/issues/35) WFS – Improve support of WFS 2.0
* [#36](https://github.com/eblondel/ows4R/issues/36) WFS – findFeatureTypeByName fixes
* [#37](https://github.com/eblondel/ows4R/issues/37) WFS – Support for xsd:float primitive type
* [#38](https://github.com/eblondel/ows4R/issues/38) WFS – add pretty option for feature type description
* [#39](https://github.com/eblondel/ows4R/issues/39) CSW – fix getRecordById for feature catalogue (ISO 19110) parsing

## [ows4R 0.1-4](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.1-4.tar.gz) | [![CRAN_Status_Badge](https://img.shields.io/badge/CRAN-published-blue.svg)](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.1-4.tar.gz)

**Corrections**

*[#32](https://github.com/eblondel/ows4R/issues/32) Regression with WFS getfeatures - issue when setting CQL_filter

## [ows4R 0.1-3](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.1-3.tar.gz) | [![CRAN_Status_Badge](https://img.shields.io/badge/CRAN-published-blue.svg)](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.1-3.tar.gz)

**Corrections**

* [#14](https://github.com/eblondel/ows4R/issues/14) debug parameter shouldn't be passed to OWS requests
* [#30](https://github.com/eblondel/ows4R/issues/30) WFS - Handle Resulttype Hits get features response

**Enhancements**

_No enhancements_

**New Features**

* [#16](https://github.com/eblondel/ows4R/issues/26) Add support for Bearer (token) authentication
* [#28](https://github.com/eblondel/ows4R/issues/28) Support geometa record validate/inspire options in CSW-T

## [ows4R 0.1-2](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.1-2.tar.gz) | [![CRAN_Status_Badge](https://img.shields.io/badge/CRAN-published-blue.svg)](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.1-2.tar.gz)

**Corrections**

* [#12](https://github.com/eblondel/ows4R/issues/12) Issue with maxRecords parameter scope in getRecords 
* [#13](https://github.com/eblondel/ows4R/issues/13) Bad XML encoding of OGC BBOX Expression
* [#19](https://github.com/eblondel/ows4R/issues/19) mapping FeatureType datatypes fails with case sensitive datatypes

**Enhancements**

* [#18](https://github.com/eblondel/ows4R/issues/18) Issue with missing EPSG:404000 code not found in init file
* [#20](https://github.com/eblondel/ows4R/issues/20) WFS FeatureTypeElement support xs/xsd types & elements restrictions
* [#24](https://github.com/eblondel/ows4R/issues/24) improve getFeatureTypes
* [#21](https://github.com/eblondel/ows4R/issues/21) Test insertion / update of multi-lingual metadata records

**New Features**

* [#16](https://github.com/eblondel/ows4R/issues/16) add function to reload client capabilities

## [ows4R 0.1-1](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.1-1.tar.gz) | [![CRAN_Status_Badge](https://img.shields.io/badge/CRAN-published-blue.svg)](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.1-1.tar.gz)

**Corrections**

* [#12](https://github.com/eblondel/ows4R/issues/12) Issue with maxRecords parameter scope in getRecords
* [#13](https://github.com/eblondel/ows4R/issues/13) Bad XML encoding of OGC BBOX Expression
* [#19](https://github.com/eblondel/ows4R/issues/19) mapping FeatureType datatypes fails with case sensitive datatypes (support to [#17](https://github.com/eblondel/ows4R/issues/17))

**Enhancements**

* [#16](https://github.com/eblondel/ows4R/issues/16) Add function to reload client capabilities
* [#18](https://github.com/eblondel/ows4R/issues/18) Handle specific CRS wildcard EPSG:404000
* [#20](https://github.com/eblondel/ows4R/issues/20) WFS FeatureTypeElement support xs/xsd types & elements restrictions (support to [#17](https://github.com/eblondel/ows4R/issues/17))
* [#21](https://github.com/eblondel/ows4R/issues/21) Test insertion / update of multi-lingual metadata records


**New Features**

_No new features at now_

## [ows4R 0.1-0](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.1-0.tar.gz) | [![CRAN_Status_Badge](https://img.shields.io/badge/CRAN-published-blue.svg)](https://cran.r-project.org/src/contrib/Archive/ows4R/ows4R_0.1-0.tar.gz)

**New features**
  
* [#8](https://github.com/eblondel/ows4R/issues/8) Allow authentication on OWS Requests
* [#7](https://github.com/eblondel/ows4R/issues/7) Prepare 1st release on CRAN
* [#6](https://github.com/eblondel/ows4R/issues/6) Set up travis-ci build for integration tests / quality assurance
* [#5](https://github.com/eblondel/ows4R/issues/5) OGC Filter Encoding + XML representation
* [#4](https://github.com/eblondel/ows4R/issues/4) OWS (Common Web-Service) OGC - OWS
* [#3](https://github.com/eblondel/ows4R/issues/3) CSW Client, versions ``2.0.2`` (including ``Transaction`` and ``Harvest``), partial support for ``3.0``
* [#2](https://github.com/eblondel/ows4R/issues/2) WFS Client, versions ``1.0.0``, ``1.1.0``, ``2.0.0`` for main operations (``GetCapabilities``, ``DescribeFeatureType``, ``GetFeature``
* [#1](https://github.com/eblondel/ows4R/issues/1) Set-up package structure
