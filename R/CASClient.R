#' CASClient
#'
#' @docType class
#' @export
#' @keywords CAS Central Authentication Service
#' @return Object of \code{\link[R6]{R6Class}} with methods for interfacing a Central Authentication Service (CAS).
#' @format \code{\link[R6]{R6Class}} object.
#' 
#' @note Class used internally by \pkg{ows4R}
#' 
#' @author Emmanuel Blondel <emmanuel.blondel1@@gmail.com>
#' 
CASClient <- R6Class("CASClient",
   
   private = list(
     url = NULL
   ),
   
   public = list(
    
     #'@description Initializes an object of class \link{CASClient}
     #'@param url base URL of the Central Authentication Service (CAS)
     initialize = function(url){
       private$url <- url
     },
     
     #'@description Get CAS base URL
     #'@return the base URL
     getUrl = function(){
       return(private$url)
     },
     
     #'@description Logs in the CAS
     #'@param user user
     #'@param pwd password
     #'@return \code{TRUE} if logged in, \code{FALSE} otherwise
     login = function(user, pwd){
       logged_in = FALSE
       self$logout() #make sure we are logged out before login
       cas_url_login <- paste(private$url,"login", sep="/")
       text = httr::with_verbose(content(GET(cas_url_login),"text"))
       html = XML::htmlParse(text)
       hidden_elements_from_html = XML::getNodeSet(html, '//form//input[@type="hidden"]')
       if(length(hidden_elements_from_html)>0){
         payload <- lapply(hidden_elements_from_html, XML::xmlGetAttr, "value")
         names(payload) <- sapply(hidden_elements_from_html, XML::xmlGetAttr, "name")
         payload$username <- user
         payload$password <- pwd
         req_post <- httr::with_verbose(POST(cas_url_login, body = payload, encode = "form"))
         req_post_headers <- httr::headers(req_post)
         req_post_cookies = req_post_headers[names(req_post_headers)=="set-cookie"]
         logged_in = any(sapply(req_post_cookies, startsWith, "CASTGC"))
       }
       return(logged_in)
     },
     
     #'@description Logs out from the CAS
     #'@return \code{TRUE} if logged out, \code{FALSE} otherwise
     logout = function(){
       cas_url_logout <- paste(private$url, "logout", sep="/")
       req <- httr::GET(cas_url_logout)
       logged_out <- httr::status_code(req) == 200
       return(logged_out)
     }
   )
)