
library(xml2)
library(purrr)
library(stringr)
ilbrary(R.utils)

swdi_url <- "https://www1.ncdc.noaa.gov/pub/data/swdi/database-csv/v2"
swdi_site <- read_html(swdi_url)

hail_links <- swdi_site %>% 
  xml_find_all(".//a") %>% 
  xml_attr("href") %>%
  keep(str_detect, "^hail-[0-9]")

walk(
  hail_links,
  ~ download.file(
    file.path(swdi_url, .), 
    file.path("data", "nexrad", "hail", "csv", .)
  )
)

walk(list.files("data/nexrad/hail/csv", full.names = TRUE), gunzip)


download.file(
  "http://www2.census.gov/geo/tiger/GENZ2017/shp/cb_2017_us_state_20m.zip", 
  "data/shapefiles/cb_2017_us_state_20m.zip"
)

unzip(
  "data/shapefiles/cb_2017_us_state_20m.zip", 
  exdir = "data/shapefiles/cb_2017_us_state_20m"
)



