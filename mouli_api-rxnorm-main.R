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
#' get_approximate_match(c("Piribedil","zocor", "levodopa"), 2)

get_approximate_match <- function(rx_string, max_entries) {
  check_internet()
  cols_order = c("rxcui", "rxaui", "score", "rank", "name", "source")
  for(rx in 1:length(rx_string)) {
    df <- cbind(rx_string[rx],
      parse_rx_name(httr::GET(
      paste0(
        base_url, "approximateTerm.json?term=", rx_string[rx], "&maxEntries=", max_entries
        )
      )
    )[, cols_order])
    if(rx != 1) {
      write.table(df, file="rxfile.csv", append=TRUE, row.names = F, col.names = F, 
                  sep = ",", qmethod = "double", fileEncoding = "utf-8")
    } else {
      write.table(df, file="rxfile.csv", append=TRUE, row.names = F, col.names = c("input", cols_order), 
                  sep = ",", qmethod = "double", fileEncoding = "utf-8")
    }
  Sys.sleep(1)
  }
}




