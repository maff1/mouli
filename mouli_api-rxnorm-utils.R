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
  
  res <- httr::content(x, "parse")
  lapply(res$approximateGroup$candidate,
         function(x) {
           c(x$rxcui,
             x$rxaui,
             x$score,
             x$rank,
             x$name,
             x$source
           )
         })[[1]]
}