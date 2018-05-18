# ows4R

[![Build Status](https://travis-ci.org/eblondel/ows4R.svg?branch=master)](https://travis-ci.org/eblondel/ows4R)
[![codecov.io](http://codecov.io/github/eblondel/ows4R/coverage.svg?branch=master)](http://codecov.io/github/eblondel/ows4R?branch=master)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/ows4R)](https://cran.r-project.org/package=ows4R)
[![Github_Status_Badge](https://img.shields.io/badge/Github-0.1--1-blue.svg)](https://github.com/eblondel/ows4R)

R client for OGC Web-Services

``ows4R`` is a new project that aims to set-up a pure R interface to OGC Web-Services. In a first time (ongoing work), ``ows4R`` will target:
* the Common OGC Web-Services specifications, version ``1.1.0``
* the Catalogue Service (CSW), version ``2.0.2``
* the Web Feature Service (WFS), versions ``1.0.0``, ``1.1.0``, and ``2.0.0``

## OGC standards coverage status

Standard  |Description|Supported versions|Supported R bindings|Support
----------|-----------|------------------|--------------------|------|
OGC Common|[Web Service Common](http://www.opengeospatial.org/standards/common)|``1.1.0``||ongoing
OGC CSW   |[Catalogue Service](http://www.opengeospatial.org/standards/cat)|``2.0.2``|[geometa](https://github.com/eblondel/geometa) (ISO 19115 / 19119 / 19110)|ongoing
OGC WFS   |[Web Feature Service](http://www.opengeospatial.org/standards/wfs)|``1.0.0``,``1.1.0``,``2.0.0``|[sf](https://github.com/r-spatial/sf) (OGC Simple Feature)|ongoing

In case of a missing feature, [create a ticket](https://github.com/eblondel/ows4R/issues/new).

## Development perspectives

* Support for additional OGC web-service standard specifications

For more information, or if you are interested in funding this R package project or to contribute to it, do not hesitate to contact me by [e-mail](mailto:emmanuel.blondel1@gmail.com)

