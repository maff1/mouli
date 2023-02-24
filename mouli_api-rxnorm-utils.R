# API TO RXNORM

base_url <- "https://rxnav.nlm.nih.gov/REST/"

check_internet <- function() {
  stopifnot("No internet connection" = curl::has_internet())
}

check_status <- function(x) {
  httr::status_code(x) == "200"
}

parse_rx_name <- function(x) {
  if (!check_status(x)) {
    return(NA_character_)
  }
  
  res <- httr::content(x, "text", encoding = "utf-8")
  as.data.frame(
    jsonlite::fromJSON(res)[["approximateGroup"]][["candidate"]]
  )
}