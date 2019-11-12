# ows4R

[![Build Status](https://travis-ci.org/eblondel/ows4R.svg?branch=master)](https://travis-ci.org/eblondel/ows4R)
[![codecov.io](http://codecov.io/github/eblondel/ows4R/coverage.svg?branch=master)](http://codecov.io/github/eblondel/ows4R?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/ows4R)](https://cran.r-project.org/package=ows4R)
[![cran checks](https://cranchecks.info/badges/worst/ows4R)](https://cran.r-project.org/web/checks/check_results_ows4R.html)
[![Github_Status_Badge](https://img.shields.io/badge/Github-0.1--4-blue.svg)](https://github.com/eblondel/ows4R)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1345111.svg)](https://doi.org/10.5281/zenodo.1345111)

R client for OGC Web-Services

``ows4R`` is a new project that aims to set-up a pure R interface to OGC Web-Services. In a first time (ongoing work), ``ows4R`` will target:
* the Common OGC Web-Services specifications, versions ``1.1`` and ``2.0``
* the Catalogue Service for the Web (CSW), version ``2.0.2`` (including ``Transaction`` and ``Harvest`` operations)
* the Web Feature Service (WFS), versions ``1.0.0``, ``1.1.0``, and ``2.0.0``

### Citation

We thank in advance people that use ``ows4R`` for citing it in their work / publication(s). For this, please use the citation provided at this link [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1345111.svg)](https://doi.org/10.5281/zenodo.1345111)

## OGC standards coverage status

Standard  |Description|Supported versions|Unsupported versions|Supported R bindings|Support
----------|-----------|------------------|-----------------|--------------------|------|
OGC Filter|[Filter Encoding](http://www.opengeospatial.org/standards/filter)|``1.1.0``|``2.0``||ongoing
OGC Common|[Web Service Common](http://www.opengeospatial.org/standards/common)|``1.1``,``2.0``|||ongoing
OGC CSW   |[Catalogue Service](http://www.opengeospatial.org/standards/cat)|``2.0.2``|``3.0.0``|[geometa](https://github.com/eblondel/geometa) (ISO 19115 / 19119 / 19110 / 19139 XML)|ongoing / seeking sponsors
OGC WFS   |[Web Feature Service](http://www.opengeospatial.org/standards/wfs)|``1.0.0``,``1.1.0``,``2.0.0``||[sf](https://github.com/r-spatial/sf) (OGC Simple Feature)|ongoing
OGC WCS |[Web Coverage Service](http://www.opengeospatial.org/standards/wcs)|``1.1.0``, ``1.1.1``, ``2.0.1``|``1.0.0``|[raster](https://cran.r-project.org/package=raster)|under investigation/seek sponsors

In case of a missing feature, [create a ticket](https://github.com/eblondel/ows4R/issues/new).

## Development perspectives

Support for additional OGC web-service standard specifications including
* Filter Encoding (FES) version ``2.0``
* Catalogue Service (CSW) version ``3.0`` (including ``Transaction`` and ``Harvest`` operations)
* Web Feature Service (WFS) ``Transaction`` operations
* Web Coverage Service (WCS)
* Web Processing Service (WPS)
* ...

For more information, or if you are interested in funding this R project or to contribute to it, do not hesitate to contact me by [e-mail](mailto:emmanuel.blondel1@gmail.com)

