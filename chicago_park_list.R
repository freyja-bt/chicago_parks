library(tidyverse)
library(rvest)
library(xml2)

all.parks <- map(
  0:127,
  function(x) {
    webpage <- read_html(sprintf("https://www.chicagoparkdistrict.com/park-finder?page=%s", as.character(x)))
    
    tibble(
      Name = html_elements(webpage, ".views-field-title a") |>
    html_text2(),
      Address = html_elements(webpage, ".address") |> 
      html_text2()
    )
  },
  .progress = TRUE
)

write_csv(bind_rows(all.parks), "all_chicago_parks.csv")

