#' Dominick's Finer Foods department sales data
#'
#' @description
#'
#' From the [Chicago Booth Kilts Center for Marketing](https://www.chicagobooth.edu/research/kilts/datasets/dominicks):
#'
#' From 1989 to 1994, Chicago Booth and Dominick’s Finer Foods entered into a
#' partnership for store-level research into shelf management and pricing.
#' Randomized experiments were conducted in more than 25 different categories
#' throughout all stores in this 100-store chain. As a by-product of this
#' research cooperation, approximately nine years of store-level data on the
#' sales of more than 3,500 UPCs is available in this dataset. This data is
#' unique for the breadth of its coverage and for the information available on
#' retail margins.
#'
#' The customer count file includes information about in-store traffic. The data
#' is store specific and on a daily basis. The customer count data refers to the
#' number of customers visiting the store and purchasing something. Also in the
#' customer count file is a total dollar sales and total coupons redeemed
#' figure, by DFF defined department. These figures are compiled daily from the
#' register/scanner receipts.
#'
#' @source <https://www.chicagobooth.edu/research/kilts/datasets/dominicks>
#' @family Dominick's datasets
#'
#' @format `r rd_describe_format(dominick, dominick_dictionary)`
#'
#' @examples
#' # Convert to `tsibble`
#' library(tsibble)
#' dominick %>%
#'   as_tsibble(key = c("store"), index = date)
"dominick"

#' @describeIn dominick The `dominick` data dictionary
"dominick_dictionary"

#' Dominick's Finer Foods oatmeal sales data
#'
#' @description
#'
#' From the [Chicago Booth Kilts Center for Marketing](https://www.chicagobooth.edu/research/kilts/datasets/dominicks):
#'
#' From 1989 to 1994, Chicago Booth and Dominick’s Finer Foods entered into a
#' partnership for store-level research into shelf management and pricing.
#' Randomized experiments were conducted in more than 25 different categories
#' throughout all stores in this 100-store chain. As a by-product of this
#' research cooperation, approximately nine years of store-level data on the
#' sales of more than 3,500 UPCs is available in this dataset. This data is
#' unique for the breadth of its coverage and for the information available on
#' retail margins.
#'
#' The data contain a description of each UPC in a category and sales
#' information at the store level for each UPC in a category. The information is
#' stored on a weekly basis.
#'
#' Note: This is historical data and the products are not for sale.
#'
#' @source <https://www.chicagobooth.edu/research/kilts/datasets/dominicks>
#' @family Dominick's datasets
#'
#' @format `r rd_describe_format(dominick_oatmeal, dominick_oatmeal_dictionary)`
#'
#' @examples
#' # Convert to `tsibble`
#' library(tsibble)
#' dominick_oatmeal %>%
#'   as_tsibble(key = c("store", "product", "size", "price"), index = week)
"dominick_oatmeal"

#' @describeIn dominick_oatmeal The `dominick_oatmeal` data dictionary
"dominick_oatmeal_dictionary"

#' Dominick's Finer Foods bath soap sales data
#'
#' @description
#'
#' From the [Chicago Booth Kilts Center for Marketing](https://www.chicagobooth.edu/research/kilts/datasets/dominicks):
#'
#' From 1989 to 1994, Chicago Booth and Dominick’s Finer Foods entered into a
#' partnership for store-level research into shelf management and pricing.
#' Randomized experiments were conducted in more than 25 different categories
#' throughout all stores in this 100-store chain. As a by-product of this
#' research cooperation, approximately nine years of store-level data on the
#' sales of more than 3,500 UPCs is available in this dataset. This data is
#' unique for the breadth of its coverage and for the information available on
#' retail margins.
#'
#' The data contain a description of each UPC in a category and sales
#' information at the store level for each UPC in a category. The information is
#' stored on a weekly basis.
#'
#' Note: This is historical data and the products are not for sale.
#'
#' @source <https://www.chicagobooth.edu/research/kilts/datasets/dominicks>
#' @family Dominick's datasets
#'
#' @format `r rd_describe_format(dominick_soap, dominick_soap_dictionary)`
#'
#' @examples
#' # Convert to `tsibble`
#' library(tsibble)
#' dominick_soap %>%
#'   as_tsibble(key = c("store", "product", "size", "price"), index = week)
"dominick_soap"

#' @describeIn dominick_soap The `dominick_soap` data dictionary
"dominick_soap_dictionary"
