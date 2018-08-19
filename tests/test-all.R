library(testthat)
library(httr)

runIntegrationTests <- class(try(httr::GET("http://localhost:8000/csw"))) != "try-error"
if(runIntegrationTests){
  cat(sprintf("Running integration tests...\n"))
  test_check("ows4R")
}else{
  cat("Skipping integration tests...\n")
}