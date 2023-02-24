
#' Get approximate match from string
#'
#' @param rx_string string to search for.
#'
#' @param max_entries numeric max entries to return.
#' 
#' @return rxcui, rxaui, score, rank, name, and source; \code{NULL} if not successful.
#'
#' @export
#'
#' @examples
#' get_approximate_match("Piribedil", 2)

get_approximate_match <- function(rx_string, max_entries) {
  check_internet()
  parse_rx_name(httr::GET(paste0(base_url, "approximateTerm?term=", rx_string, "&maxEntries=", max_entries)))
}