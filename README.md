# ows4R

[![Build Status](https://github.com/eblondel/ows4R/actions/workflows/r-cmd-check.yml/badge.svg?branch=master)](https://github.com/eblondel/ows4R/actions/workflows/r-cmd-check.yml)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/ows4R)](https://cran.r-project.org/package=ows4R)
[![cran checks](https://cranchecks.info/badges/worst/ows4R)](https://cran.r-project.org/web/checks/check_results_ows4R.html)
[![Github_Status_Badge](https://img.shields.io/badge/Github-0.3-blue.svg)](https://github.com/eblondel/ows4R)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1345111.svg)](https://doi.org/10.5281/zenodo.1345111)

R client for OGC Web-Services

``ows4R`` aims to set-up a pure R interface to OGC Web-Services. It currently targets:
* the Common OGC Web-Services specifications, versions ``1.1`` and ``2.0``
* the Catalogue Service for the Web (CSW), version ``2.0.2`` (including ``Transaction`` and ``Harvest`` operations)
* the Web Feature Service (WFS), versions ``1.0.0``, ``1.1.0``, and ``2.0.0``
* the Web Coverage Service (WCS), versions `1.0`, `1.1.0`, `1.1.1`, `2.0.1` and `2.1.0`
* the Web Map Service (WMS), versions ``1.1.0``, ``1.1.1``, and ``1.3.0``
* the Web Processing service (WPS) version `1.0.0`

The following projects have contributed to strenghten ``ows4R``:

* for the WMS and WPS support (ongoing)

<a href="https://www.blue-cloud.org"><img height=100 width=300 src="https://www.blue-cloud.org/sites/all/themes/arcadia/logo.png"/></a>

_Blue-Cloud has received funding from the European Union's Horizon programme call BG-07-2019-2020, topic: [A] 2019 - Blue Cloud services, Grant Agreement No.862409._


### Citation

We thank in advance people that use ``ows4R`` for citing it in their work / publication(s). For this, please use the citation provided at this link [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1345111.svg)](https://doi.org/10.5281/zenodo.1345111)

## OGC standards coverage status

Standard  |Description|Supported versions|Unsupported versions|Supported R bindings|Support
----------|-----------|------------------|-----------------|--------------------|------|
OGC Filter|[Filter Encoding](https://www.ogc.org/standards/filter)|``1.1.0``|``2.0``||ongoing
OGC Common|[Web Service Common](https://www.ogc.org/standards/common)|``1.1``,``2.0``|||ongoing
OGC CSW   |[Catalogue Service](https://www.ogc.org/standards/cat)|``2.0.2``|``3.0.0``|[geometa](https://github.com/eblondel/geometa) (ISO 19115 / 19119 / 19110 / 19139 XML)|ongoing / seeking sponsors
OGC WFS   |[Web Feature Service](https://www.ogc.org/standards/wfs)|``1.0.0``,``1.1.0``,``2.0.0``||[sf](https://github.com/r-spatial/sf) (OGC Simple Feature)|ongoing
OGC WMS   |[Web Map Service](https://www.ogc.org/standards/wms)|``1.1.0``,``1.1.1``,``1.3.0``||[sf](https://github.com/r-spatial/sf) (OGC Simple Feature - for `GetFeatureInfo` operation)|ongoing
OGC WCS |[Web Coverage Service](https://www.ogc.org/standards/wcs)|``1.0.0``, ``1.1.0``, ``1.1.1``, ``2.0.1``, ``2.1.0``||[raster](https://cran.r-project.org/package=raster)|ongoing
OGC WPS |[Web Processing Service](https://www.ogc.org/standards/wps)|`1.0.0`|`2.0`||under development (contribs welcome)

In case of a missing feature, [create a ticket](https://github.com/eblondel/ows4R/issues/new).

## Development perspectives

Support for additional OGC web-service standard specifications including
* Web Processing Service (WPS)
* Web Coverage Service (WCS)
* Web Coverage Processing Service (WCPS)
* Filter Encoding (FES) version ``2.0``
* Web Feature Service (WFS) ``Transaction`` operations
* Catalogue Service (CSW) version ``3.0`` (including ``Transaction`` and ``Harvest`` operations)
* OGC API
* ...

For more information, or if you are interested in funding this R project or to contribute to it, do not hesitate to contact me by [e-mail](mailto:eblondel.pro@gmail.com)

