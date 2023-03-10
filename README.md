[![Build Status](https://github.com/eblondel/ows4R/actions/workflows/r-cmd-check.yml/badge.svg?branch=master)](https://github.com/eblondel/ows4R/actions/workflows/r-cmd-check.yml)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/ows4R)](https://cran.r-project.org/package=ows4R)
[![cran checks](https://badges.cranchecks.info/worst/ows4R.svg)](https://cran.r-project.org/web/checks/check_results_ows4R.html)
[![Github_Status_Badge](https://img.shields.io/badge/Github-0.3--4-blue.svg)](https://github.com/eblondel/ows4R)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1345111.svg)](https://doi.org/10.5281/zenodo.1345111)

**ows4R – R Interface to OGC Web-Services (OWS)**

[ows4R](https://doi.org/10.5281/zenodo.1345111) provides an Interface to Web-Services defined as open standards by the [Open Geospatial Consortium (OGC)](https://www.ogc.org/standards/), including Web Feature Service (WFS) for vector data, Web Coverage Service (WCS), Catalogue Service (CSW) for ISO/OGC metadata, Web Processing Service (WPS) for data processes, and associated standards such as the common web-service specification (OWS) and OGC Filter Encoding. Partial support is provided for the Web Map Service (WMS). The purpose is to add support for additional OGC service standards such as Web Coverage Processing Service (WCPS), the Sensor Observation Service (SOS), or even new standard services emerging such OGC API or SensorThings. 

It currently targets:

* the Common OGC Web-Services specifications, versions ``1.1`` and ``2.0``
* the Catalogue Service for the Web (CSW), version ``2.0.2`` (including ``Transaction`` and ``Harvest`` operations)
* the Web Feature Service (WFS), versions ``1.0.0``, ``1.1.0``, and ``2.0.0``
* the Web Coverage Service (WCS), versions `1.0`, `1.1.0`, `1.1.1`, `2.0.1` and `2.1.0`
* the Web Map Service (WMS), versions ``1.1.0``, ``1.1.1``, and ``1.3.0``
* the Web Processing service (WPS) version `1.0.0`

Do you have a question? support request? you can create a 'discussion' [here](https://github.com/eblondel/ows4R/discussions)

## Sponsors

The following projects have contributed to strenghten ``ows4R``:

* for core, WFS and CSW support

<div>
  <a href="https://www.fao.org/home/en/"><img height=200 width=200 src="https://www.fao.org/fileadmin/templates/family-farming-decade/images/FAO-IFAD-Logos/FAO-Logo-EN.svg">
</div>

* for WMS and WPS support

<a href="https://blue-cloud.org/"><img height=100 width=300 src="https://hackathon.blue-cloud.org/wp-content/uploads/2021/11/Blue-cloud_extended_color.png"/></a>

_Blue-Cloud has received funding from the European Union's Horizon programme call BG-07-2019-2020, topic: [A] 2019 - Blue Cloud services, Grant Agreement No.862409._

* for the WCS support

<div>

<a href="https://emodnet.ec.europa.eu/en/biology" title="EMODnet Biology" style="float:left;"><img height=100 width=300 src="https://sextant.ifremer.fr/geonetwork/srv/api/records/73cd2a45-e0b3-4f70-96aa-c1b2639142d2/attachments/emodnet.png"/></a>
<a href="https://www.vliz.be" title="VLIZ" style="float:left;"><img height=100 width=100 src="https://www.vliz.be/sites/vliz.be/themes/vliz/img/logo.png"/></a>

</div>

### Citation

We thank in advance people that use ``ows4R`` for citing it in their work / publication(s). For this, please use the citation provided at this link [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1345111.svg)](https://doi.org/10.5281/zenodo.1345111)

## OGC standards coverage status

Standard  |Description|Supported versions|Unsupported versions|Supported R bindings|Support
----------|-----------|------------------|-----------------|--------------------|------|
OGC Filter|[Filter Encoding](https://www.ogc.org/standard/filter/)|``1.1.0``|``2.0``||ongoing
OGC Common|[Web Service Common](https://www.ogc.org/standard/common/)|``1.1``,``2.0``|||ongoing
OGC CSW   |[Catalogue Service](https://www.ogc.org/standard/cat/)|``2.0.2``|``3.0.0``|[geometa](https://github.com/eblondel/geometa) (ISO 19115 / 19119 / 19110 / 19139 XML)|ongoing - **seeking sponsors**
OGC WFS   |[Web Feature Service](https://www.ogc.org/standard/wfs/)|``1.0.0``,``1.1.0``,``2.0.0``||[sf](https://github.com/r-spatial/sf) (OGC Simple Feature)|ongoing
OGC WMS   |[Web Map Service](https://www.ogc.org/standard/wms/)|``1.1.0``,``1.1.1``,``1.3.0``||[sf](https://github.com/r-spatial/sf) (OGC Simple Feature - for `GetFeatureInfo` operation)|ongoing
OGC WCS |[Web Coverage Service](https://www.ogc.org/standard/wcs/)|``1.0.0``, ``1.1.0``, ``1.1.1``, ``2.0.1``, ``2.1.0``||[terra](https://cran.r-project.org/package=terra)|ongoing
OGC WPS |[Web Processing Service](https://www.ogc.org/standard/wps/)|`1.0.0`|`2.0`||under development (contribs welcome)
OGC SOS |[Sensor Observation Service](https://www.ogc.org/standard/sos/)|`1.0`,`2.0`|||under investigation - **seeking sponsors**

In case of a missing feature, [create a ticket](https://github.com/eblondel/ows4R/issues/new).

## Development perspectives

Support for additional OGC web-service standard specifications including:

* Web Coverage Processing Service (WCPS)
* Filter Encoding (FES) version ``2.0``
* Web Feature Service (WFS) ``Transaction`` operations
* Catalogue Service (CSW) version ``3.0`` (including ``Transaction`` and ``Harvest`` operations)
* OGC API
* ...

For more information, or if you are interested in funding this R project or to contribute to it, do not hesitate to contact me by [e-mail](mailto:eblondel.pro@gmail.com)

