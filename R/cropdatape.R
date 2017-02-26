#' @title Annual agricultural production data of Peru
#' 
#' @description The cropdatape package is based on the Integrated System of Agricultural Statistics (SIEA) of Peruvian Agriculture Minestry. 
#' The variables are: sowing and harvest area, production, crop yield, price per plot by region. The range of year covers from 
#' 2005 to 2014. Some missing values (\code{NA}) means that in some periods there is no agriculture activity.
#' 
#' @format Data frame with --- rows and 9 columns.
#' \describe{
#'   \item{crop}{factor with 6 levels}
#'   \item{region}{Peruvian regions. Factor with 24 levels}
#'   \item{year}{Numeric. Range of years from 2005 to 2014}
#'   \item{month}{Factor with 12 levels}
#'   \item{sowa}{Sowing area measured by hectares (ha)}
#'   \item{harva}{Harvest area measured by hectare (ha)}
#'   \item{production}{Production of crop measured by tons (t)}
#'   \item{yield}{Yield of crop measured by kilograms per hectare (kg/ha)}
#'   \item{pricePlot}{Price per plot. The peruvian currency \code{peruvian nuevo sol} } 
#' }
#' @source http://siea.minagri.gob.pe/siea/?q=publicaciones/anuarios-estadisticos
#' @docType data
#' @name cropdatape
#' @usage cropdatape
#' @examples
#' cropdatape
NULL

