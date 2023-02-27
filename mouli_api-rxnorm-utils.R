# API TO RXNORM

base_url <- "https://rxnav.nlm.nih.gov/REST/"
cols_order = c("rxcui", "rxaui", "score", "rank", "name", "source")

check_internet <- function() {
  stopifnot("No internet connection" = curl::has_internet())
}

check_status <- function(x) {
  httr::status_code(x) == "200"
}

# space, dash, parenthesis, dot, forward slash are allowed 
root_rx_names <- function(rx) {
  sv <- tolower(gsub("\\%|\\(|\\)|\\.|\\,|\\&|\\:|\\'", "", rx))
trimws(sv, which = "both") 
}

parse_rx_name <- function(x) {
  if (!check_status(x)) {
    return(NA_character_)
  }
  res <- httr::content(x, "text", encoding = "utf-8")
  if(length(jsonlite::fromJSON(res)[["approximateGroup"]]) >1 && 
     length(names(
       jsonlite::fromJSON(res)[["approximateGroup"]][["candidate"]]
     )) == length(cols_order)) {
    as.data.frame(
      jsonlite::fromJSON(res)[["approximateGroup"]][["candidate"]]
    )
  } else {
    as.data.frame(
      matrix(NA, nrow = 1, ncol = length(cols_order), dimnames = list(NULL, cols_order))
    )
  }
}