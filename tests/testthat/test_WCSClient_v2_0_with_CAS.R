# test_WCSClient_v2_0_with_CAS.R
# Author: Emmanuel Blondel <emmanuel.blondel1@gmail.com>
#
# Description: Integration tests for WCS Client version 2.0 - with CAS
#=======================
require(ows4R, quietly = TRUE)
require(testthat)
context("WCS")

test_that("WCS 2.0.1 - CMEMS",{
  testthat::skip_on_cran()
  if(FALSE){
    wcs <- WCSClient$new(
      url = "https://nrt.cmems-du.eu/motu-web/wcs",
      user = Sys.getenv("CMEMS_USER"), pwd = Sys.getenv("CMEMS_PWD"), cas_url = "https://cmems-cas.cls.fr/cas",
      serviceVersion = "2.0.1",
      logger = "INFO"
    )
    
    expect_true(length(wcs$capabilities$getCoverageSummaries())>0)
    cov <- wcs$capabilities$findCoverageSummaryById("OCEANCOLOUR_BAL_CHL_L3_NRT_OBSERVATIONS_009_049-TDS@dataset-oc-bal-chl-olci-l3-nn_300m_daily-rt")
    cov_data = cov$getCoverage(time = c(1609459200,1609459200), format = "application/netcdf", bbox = OWSUtils$toBBOX(9,11,53,55))
  }
  
})