fk_index <- function(url, xpath) {
  # Fetch appropriate packages
  require(tidyverse)
  require(rvest)
  require(RCurl)
  
  # Fetch html content (wrapped in a trycatch to mitigate 404)
  tryCatch(
    content <-
      paste(read_html(url) %>% html_nodes(xpath = xpath) %>% html_text(), collapse = ' '),
    error = function(e) {
      NA
    }
  )
  
  # Sentence Count
  st <-
    sapply(regmatches(
      content,
      gregexpr("\\. |\\? |\\! ", content)
    ), length)
  # Word Count
  wd <-
    sapply(regmatches(content, gregexpr(" ", content)), length)
  # Syllable Count (approx)
  sy <-
    nchar(gsub("[^X]", "", gsub(
      "[aeiouy]+", "X", tolower(content)
    )))
  # Flesch-kincaid score
  fk <-
    206.835 - (1.015 * (wd / st)) - (84.6 * (sy / wd))
  
  return(fk)
  
}
